//
//  SafeKit
//  timerLeak
//
//  Created by admin on 2017/10/19.
//  Copyright © 2017年 sunhua. All rights reserved.
//

#import "SafeKit.h"
#import "objc/runtime.h"
#import <UIKit/UIKit.h>
#import "SafeTimer.h"
#import "SafeContainer.h"
#import "SafeCallSelector.h"
#import "SafeObserver.h"
#import "SafeZombieSniffer.h"

@interface SafeKit ()
@end

@implementation SafeKit
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //@{key1:@{key2:value}}:
        //key1 = 类名，key2 = 实例方法or类方法，value = 需要替换的方法
        //PS：所有替换后的方法是safeXxxx
        NSLog(@"safe kit has run!");
        
        //dealloc 单独列出来，寻找野指针和移除NSTimer
        [SafeZombieSniffer installSniffer];
        NSArray *selectorStr = @[@{@"NSTimer":@{@"class":@[@"scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:",
                                                           @"timerWithTimeInterval:target:selector:userInfo:repeats:"],}},
                                 @{@"CADisplayLink":@{@"class":@[@"displayLinkWithTarget:selector:"]}},
                                 @{@"NSArray":@{@"instance":@[@"objectAtIndex:"],
                                                @"class":@[@"arrayWithObjects:count:"]}},
                                 @{@"NSMutableArray":@{@"instance":@[@"objectAtIndex:",
                                                                     @"replaceObjectAtIndex:withObject:",
                                                                     @"addObject:",
                                                                     @"insertObject:atIndex:",]}},
                                 @{@"NSDictionary":@{@"class":@[@"dictionaryWithObjects:forKeys:count:"]}},
                                 @{@"NSMutableDictionary":@{@"instance":@[@"setObject:forKey:"]}},
                                 @{@"NSObject":@{@"instance":@[@"addObserver:forKeyPath:options:context:",
                                                               @"removeObserver:forKeyPath:context:",
                                                               @"removeObserver:forKeyPath:",]}},
                                 @{@"NSArray":@{@"instance":@[@"addObserver:forKeyPath:options:context:",
                                                              @"removeObserver:forKeyPath:context:",
                                                              @"removeObserver:forKeyPath:",]}},
                                 @{@"NSOrderedSet":@{@"instance":@[@"addObserver:forKeyPath:options:context:",
                                                                   @"removeObserver:forKeyPath:context:",
                                                                   @"removeObserver:forKeyPath:",]}},
                                 @{@"NSSet":@{@"instance":@[@"addObserver:forKeyPath:options:context:",
                                                            @"removeObserver:forKeyPath:context:",
                                                            @"removeObserver:forKeyPath:",]}},];
        for (int i = 0; i < selectorStr.count; i++) {
            NSDictionary *dic = selectorStr[i];
            NSString *classStr = dic.allKeys[0];
            NSDictionary *classDic = dic[classStr];
            for (NSString *typeStr in classDic.allKeys) {
                if ([typeStr isEqualToString:@"class"]) {
                    NSArray *selectorArr = classDic[typeStr];
                    for (NSString *selectorStr in selectorArr) {
                        Method originMethod = [self classMethodOfSelector:NSSelectorFromString(selectorStr) clas:NSClassFromString(classStr)];
                        NSString *str = [self caculatorStr:selectorStr];
                        Method newMethod = [self classMethodOfSelector:NSSelectorFromString(str) clas:NSClassFromString(classStr)];
                        [self exchangeOriginalMethod:originMethod
                                       withNewMethod:newMethod];
                    }
                }else {
                    NSArray *selectorArr = classDic[typeStr];
                    for (NSString *selectorStr in selectorArr) {
                        Method originMethod = [self instanceMethodOfSelector:NSSelectorFromString(selectorStr) clas:NSClassFromString(classStr)];
                        NSString *str = [self caculatorStr:selectorStr];
                        Method newMethod = [self instanceMethodOfSelector:NSSelectorFromString(str) clas:NSClassFromString(classStr)];
                        [self exchangeOriginalMethod:originMethod
                                       withNewMethod:newMethod];
                    }
                }
            }
        }
        //注册Crash捕获
        //    [safeTimer initHandler];
    });
}

+ (void)exchangeOriginalMethod:(Method)originalMethod withNewMethod:(Method)newMethod
{
    method_exchangeImplementations(originalMethod, newMethod);
}

+ (Method)instanceMethodOfSelector:(SEL)selector clas:(Class)clas {
    return class_getInstanceMethod(clas, selector);
}

+ (Method)classMethodOfSelector:(SEL)selector clas:(Class)clas {
    return class_getClassMethod(clas, selector);
}

+ (NSString *)caculatorStr:(NSString *)str {
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    NSString *newStr = @"";
    NSString *oneWord = [str substringToIndex:1];
    NSString *nextWords = [str substringFromIndex:1];
    newStr = [oneWord uppercaseString];
    newStr = [newStr stringByAppendingString:nextWords];
    return [NSString stringWithFormat:@"safe%@", newStr];
}

void handleExceptions(NSException *exception) {
//    NSString *crashMessages = [NSString stringWithFormat:@"name:%@ \n reason:%@ \n userInfo:%@ \n callStackSymbols:%@ \n callStackReturnAddresses:%@",
//                               exception.name,
//                               exception.reason,
//                               exception.userInfo,
//                               exception.callStackSymbols,
//                               exception.callStackReturnAddresses];
//    [[safeCallSelector new] SHCatchCrashMessages:crashMessages];

}

+ (void)initHandler {
    struct sigaction newSignalAction;
    memset(&newSignalAction, 0,sizeof(newSignalAction));
    sigaction(SIGABRT, &newSignalAction, NULL);
    sigaction(SIGILL, &newSignalAction, NULL);
    sigaction(SIGSEGV, &newSignalAction, NULL);
    sigaction(SIGFPE, &newSignalAction, NULL);
    sigaction(SIGBUS, &newSignalAction, NULL);
    sigaction(SIGPIPE, &newSignalAction, NULL);
    
    //异常时调用的函数
    NSSetUncaughtExceptionHandler(&handleExceptions);
}
@end

