//
//  SafeZombieSniffer
//
//  Created by linxinda on 2017/10/28.
//

#import "SafeZombieSniffer.h"
#import "SafeZombieProxy.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "SafeTimer.h"

typedef void (*SafeDeallocPointer) (id obj);
static BOOL _enabled = NO;
static NSArray *_rootClasses = nil;
static NSDictionary<id, NSValue *> *_rootClassDeallocImps = nil;


static inline NSMutableSet *__sniff_white_list() {
    static NSMutableSet *sniff_white_list;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sniff_white_list = [[NSMutableSet alloc] init];
    });
    return sniff_white_list;
}

static inline void __orig_dealloc(__unsafe_unretained id obj) {
    Class currentCls = [obj class];
    Class rootCls = currentCls;
    
    while (rootCls != [NSObject class] && rootCls != [NSProxy class]) {
        rootCls = class_getSuperclass(rootCls);
    }
    NSString *clsName = NSStringFromClass(rootCls);
    SafeDeallocPointer deallocImp = NULL;
    [[_rootClassDeallocImps objectForKey: clsName] getValue: &deallocImp];
    
    if (deallocImp != NULL) {
        deallocImp(obj);
    }
}

static inline IMP __swizzleMethodWithBlock(Method method, void *block) {
    IMP blockImplementation = imp_implementationWithBlock(block);
    return method_setImplementation(method, blockImplementation);
}


@implementation SafeZombieSniffer

+ (void)initialize {
    _rootClasses = [@[[NSObject class], [NSProxy class]] retain];
}

#pragma mark - Public
+ (void)installSniffer {
    @synchronized(self) {
        if (!_enabled) {
            [self _swizzleDealloc];
            _enabled = YES;
        }
    }
}

+ (void)appendIgnoreClass: (Class)cls {
    @synchronized(self) {
        NSMutableSet *whiteList = __sniff_white_list();
        NSString *clsName = NSStringFromClass(cls);
        [clsName retain];
        [whiteList addObject: clsName];
    }
}

+ (void)getIvarName:(id)obj
{
    Class cls = [obj class];
    unsigned int count = 0;
    //拷贝出所有的成员变量的列表
    Ivar *ivars = class_copyIvarList(cls, &count);
//    NSLog(@"^^^^^^^^^:%d----%p",count, obj);
    for (int i =0; i<count; i++) {
        //取出成员变量
        Ivar var = *(ivars + i);
        
        //打印成员变量名字
        NSString *strType = [NSString stringWithUTF8String:ivar_getTypeEncoding(var)];
        if ([strType isEqualToString:@"@\"NSTimer\""]) {
            NSTimer *timer = (NSTimer *)object_getIvar(obj, var);
//            NSLog(@"$$$$$$$$$$$$$$:%@------%@", timer, cls);
            [self removeTimer:timer];
        }else if ([strType isEqualToString:@"@\"CADisplayLink\""]) {
            CADisplayLink *cad = (CADisplayLink *)object_getIvar(obj, var);
//            NSLog(@"####$$$$$$$$$$$$$$:%@------%@", cad, cls);
            [self removeTimer:cad];
        }
    }
    //释放
    free(ivars);
}

+ (void)removeTimer:(id)timer {
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}

#pragma mark - Private
+ (void)_swizzleDealloc {
    static void *swizzledDeallocBlock = NULL;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzledDeallocBlock = ([^void(id obj) {
            Class currentClass = [obj class];
            NSString *clsName = NSStringFromClass(currentClass);
            if ([__sniff_white_list() containsObject: clsName] || [clsName hasPrefix:@"OS_"] || [clsName hasPrefix:@"__"] || [clsName hasPrefix:@"CT"] || [clsName hasPrefix:@"FBS"] || [clsName hasPrefix:@"NS"] || [clsName hasPrefix:@"_"] || [clsName hasPrefix:@"BS"] || [clsName hasPrefix:@"BKS"]) {
                __orig_dealloc(obj);
            } else {
                [self getIvarName:obj];
//                NSLog(@"---------%p----%@",obj, clsName);
                __orig_dealloc(obj);
                return;
                //TODO:野指针，在类执行dealloc的时候将类替换为自己的Proxy类，然后延迟30秒释放，所有原先执行的方法转移到Proxy类里面
                //目前遇到的问题是，NSTimer，CADisplayLink等计时器需要立马执行释放操作才能自动停止
#if 0
                NSValue *objVal = [NSValue valueWithBytes: &obj objCType: @encode(typeof(obj))];
                object_setClass(obj, [SafeZombieProxy class]);
                ((SafeZombieProxy *)obj).originClass = currentClass;
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    __unsafe_unretained id deallocObj = nil;
                    [objVal getValue: &deallocObj];
                    object_setClass(deallocObj, currentClass);
                    __orig_dealloc(deallocObj);
                });
#endif
            }
        } copy]);
    });
    
    NSMutableDictionary *deallocImps = [NSMutableDictionary dictionary];
    for (Class rootClass in _rootClasses) {
        IMP originalDeallocImp = __swizzleMethodWithBlock(class_getInstanceMethod(rootClass, @selector(dealloc)), swizzledDeallocBlock);
        [deallocImps setObject: [NSValue valueWithBytes: &originalDeallocImp objCType: @encode(typeof(IMP))] forKey: NSStringFromClass(rootClass)];
    }
    _rootClassDeallocImps = [deallocImps copy];
}
@end
