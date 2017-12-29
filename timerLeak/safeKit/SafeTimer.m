//
//  SafeTimer.m
//  timerLeak
//
//  Created by sunhua on 2017/11/6.
//  Copyright © 2017年 sunhua. All rights reserved.
//

#import "SafeTimer.h"
#import "objc/runtime.h"
#import <QuartzCore/CADisplayLink.h>

@interface WeakObjectContainer : NSObject
@property (nonatomic, readonly, weak) id weakObject;
@end

@implementation WeakObjectContainer
- (instancetype) initWithObject:(id)object {
    if (self = [super init]) {
        _weakObject = object;
    }
    return self;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.weakObject;
}

- (void)dealloc {
}
@end

#pragma mark - NSTimer
@implementation NSTimer (SafeKit)

+ (id)changeTargetToWeak:(id)aTarget {
    WeakObjectContainer *weakObj = objc_getAssociatedObject(aTarget, &TimerKey);
    if (!weakObj) {
        weakObj = [[WeakObjectContainer alloc] initWithObject:aTarget];
//        NSLog(@"========%p-------%@", aTarget, NSStringFromClass([aTarget class]));
        objc_setAssociatedObject(aTarget, &TimerKey, weakObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return weakObj;
}

+ (instancetype)safeScheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo {
    WeakObjectContainer *weakObj = [self changeTargetToWeak:aTarget];
    return [self safeScheduledTimerWithTimeInterval:ti target:weakObj selector:aSelector userInfo:userInfo repeats:yesOrNo];
}

+ (instancetype)safeTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo {
    WeakObjectContainer *weakObj = [self changeTargetToWeak:aTarget];
    return [self safeTimerWithTimeInterval:ti target:weakObj selector:aSelector userInfo:userInfo repeats:yesOrNo];
}
@end

#pragma mark - CADisplayLink
@implementation CADisplayLink (safeKit)

+ (id)changeTargetToWeak:(id)aTarget {
    WeakObjectContainer *weakObj = objc_getAssociatedObject(aTarget, &TimerKey);
    if (!weakObj) {
        weakObj = [[WeakObjectContainer alloc] initWithObject:aTarget];
        objc_setAssociatedObject(aTarget, &TimerKey, weakObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return weakObj;
}

+ (CADisplayLink *)safeDisplayLinkWithTarget:(id)target selector:(SEL)sel {
    WeakObjectContainer *weakObj = [self changeTargetToWeak:target];
    return [self safeDisplayLinkWithTarget:weakObj selector:sel];
}

@end

@implementation SafeTimer

@end
