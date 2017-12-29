//
//  SafeObserver.m
//  timerLeak
//
//  Created by sunhua on 2017/11/6.
//  Copyright © 2017年 sunhua. All rights reserved.
//

#import "SafeObserver.h"
#import <objc/runtime.h>
//static char ObserverKey;
//
//#pragma mark - NSNotificationCenter
//@interface NSNotificationCenter (SafeKit)
//
//@end
//
//@implementation NSNotificationCenter (SafeKit)
//- (void)safeAddObserver:(id)observer selector:(SEL)aSelector name:(nullable NSNotificationName)aName object:(nullable id)anObject {
//    NSString *observerName = NSStringFromClass([observer class]);
//    NSString *newKeyPath = [NSString stringWithFormat:@"%@_%@", aName, observerName];
//    NSMutableArray *mutableArr = objc_getAssociatedObject(observer, "ObserverList");
//    if (!mutableArr) {
//        mutableArr = [NSMutableArray array];
//        [mutableArr addObject:newKeyPath];
//        objc_setAssociatedObject(observer, "ObserverList", mutableArr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    }else {
//        if ([mutableArr containsObject:newKeyPath]) {
//            return;
//        }else {
//            [mutableArr addObject:newKeyPath];
//        }
//    }
//    
//    return [self safeAddObserver:observer selector:aSelector name:aName object:anObject];
//}
//
//- (void)safeRemoveObserver:(id)observer {
//    NSMutableArray *mutableArr = objc_getAssociatedObject(observer, "ObserverList");
//    if (mutableArr.count > 0) {
//        for (NSString *keyStr in mutableArr) {
//            [mutableArr removeObject:keyStr];
//        }
//    }else {
//        return;
//    }
//    
//    return [self safeRemoveObserver:observer];
//}
//
//- (void)safeRemoveObserver:(id)observer name:(nullable NSNotificationName)aName object:(nullable id)anObject {
//    NSString *observerName = NSStringFromClass([observer class]);
//    NSString *newKeyPath = [NSString stringWithFormat:@"%@_%@", aName, observerName];
//    NSMutableArray *mutableArr = objc_getAssociatedObject(observer, "ObserverList");
//    if (mutableArr) {
//        if ([mutableArr containsObject:newKeyPath]) {
//            [mutableArr removeObject:newKeyPath];
//        }else {
//            return;
//        }
//    }else {
//        return;
//    }
//    return [self safeRemoveObserver:observer name:aName object:anObject];
//}
//@end
/////
#pragma mark - NSSet
@interface NSSet (SafeKit)

@end

@implementation NSSet (SafeKit)
- (void)safeAddObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
    NSString *observerName = NSStringFromClass([observer class]);
    NSString *newKeyPath = [NSString stringWithFormat:@"%@_%@", keyPath, observerName];
    NSMutableArray *mutableArr = objc_getAssociatedObject(observer, "ObserverList");
    if (!mutableArr) {
        mutableArr = [NSMutableArray array];
        [mutableArr addObject:newKeyPath];
        objc_setAssociatedObject(observer, "ObserverList", mutableArr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }else {
        if ([mutableArr containsObject:newKeyPath]) {
            return;
        }else {
            [mutableArr addObject:newKeyPath];
        }
    }
    
    return [self safeAddObserver:observer forKeyPath:keyPath options:options context:context];
}

- (void)safeRemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(nullable void *)context {
    NSString *observerName = NSStringFromClass([observer class]);
    NSString *newKeyPath = [NSString stringWithFormat:@"%@_%@", keyPath, observerName];
    NSMutableArray *mutableArr = objc_getAssociatedObject(observer, "ObserverList");
    if (mutableArr) {
        if ([mutableArr containsObject:newKeyPath]) {
            [mutableArr removeObject:newKeyPath];
        }else {
            return;
        }
    }else {
        return;
    }
    
    return [self safeRemoveObserver:observer forKeyPath:keyPath context:context];
}

- (void)safeRemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    NSString *observerName = NSStringFromClass([observer class]);
    NSString *newKeyPath = [NSString stringWithFormat:@"%@_%@", keyPath, observerName];
    NSMutableArray *mutableArr = objc_getAssociatedObject(observer, "ObserverList");
    if (mutableArr) {
        if ([mutableArr containsObject:newKeyPath]) {
            [mutableArr removeObject:newKeyPath];
        }else {
            return;
        }
    }else {
        return;
    }
    return [self safeRemoveObserver:observer forKeyPath:keyPath];
}
@end

#pragma mark - NSOrderedSet
@interface NSOrderedSet (SafeKit)

@end

@implementation NSOrderedSet (SafeKit)
- (void)safeAddObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
    NSString *observerName = NSStringFromClass([observer class]);
    NSString *newKeyPath = [NSString stringWithFormat:@"%@_%@", keyPath, observerName];
    NSMutableArray *mutableArr = objc_getAssociatedObject(observer, "ObserverList");
    if (!mutableArr) {
        mutableArr = [NSMutableArray array];
        [mutableArr addObject:newKeyPath];
        objc_setAssociatedObject(observer, "ObserverList", mutableArr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }else {
        if ([mutableArr containsObject:newKeyPath]) {
            return;
        }else {
            [mutableArr addObject:newKeyPath];
        }
    }
    
    return [self safeAddObserver:observer forKeyPath:keyPath options:options context:context];
}

- (void)safeRemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(nullable void *)context {
    NSString *observerName = NSStringFromClass([observer class]);
    NSString *newKeyPath = [NSString stringWithFormat:@"%@_%@", keyPath, observerName];
    NSMutableArray *mutableArr = objc_getAssociatedObject(observer, "ObserverList");
    if (mutableArr) {
        if ([mutableArr containsObject:newKeyPath]) {
            [mutableArr removeObject:newKeyPath];
        }else {
            return;
        }
    }else {
        return;
    }
    
    return [self safeRemoveObserver:observer forKeyPath:keyPath context:context];
}

- (void)safeRemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    NSString *observerName = NSStringFromClass([observer class]);
    NSString *newKeyPath = [NSString stringWithFormat:@"%@_%@", keyPath, observerName];
    NSMutableArray *mutableArr = objc_getAssociatedObject(observer, "ObserverList");
    if (mutableArr) {
        if ([mutableArr containsObject:newKeyPath]) {
            [mutableArr removeObject:newKeyPath];
        }else {
            return;
        }
    }else {
        return;
    }
    return [self safeRemoveObserver:observer forKeyPath:keyPath];
}
@end

#pragma mark - NSArray
@interface NSArray (SafeKit)

@end

@implementation NSArray (SafeKit)
- (void)safeAddObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
    NSString *observerName = NSStringFromClass([observer class]);
    NSString *newKeyPath = [NSString stringWithFormat:@"%@_%@", keyPath, observerName];
    NSMutableArray *mutableArr = objc_getAssociatedObject(observer, "ObserverList");
    if (!mutableArr) {
        mutableArr = [NSMutableArray array];
        [mutableArr addObject:newKeyPath];
        objc_setAssociatedObject(observer, "ObserverList", mutableArr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }else {
        if ([mutableArr containsObject:newKeyPath]) {
            return;
        }else {
            [mutableArr addObject:newKeyPath];
        }
    }
    
    return [self safeAddObserver:observer forKeyPath:keyPath options:options context:context];
}

- (void)safeRemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(nullable void *)context {
    NSString *observerName = NSStringFromClass([observer class]);
    NSString *newKeyPath = [NSString stringWithFormat:@"%@_%@", keyPath, observerName];
    NSMutableArray *mutableArr = objc_getAssociatedObject(observer, "ObserverList");
    if (mutableArr) {
        if ([mutableArr containsObject:newKeyPath]) {
            [mutableArr removeObject:newKeyPath];
        }else {
            return;
        }
    }else {
        return;
    }
    
    return [self safeRemoveObserver:observer forKeyPath:keyPath context:context];
}

- (void)safeRemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    NSString *observerName = NSStringFromClass([observer class]);
    NSString *newKeyPath = [NSString stringWithFormat:@"%@_%@", keyPath, observerName];
    NSMutableArray *mutableArr = objc_getAssociatedObject(observer, "ObserverList");
    if (mutableArr) {
        if ([mutableArr containsObject:newKeyPath]) {
            [mutableArr removeObject:newKeyPath];
        }else {
            return;
        }
    }else {
        return;
    }
    return [self safeRemoveObserver:observer forKeyPath:keyPath];
}
@end

#pragma mark - NSObject
@interface NSObject (SafeKit)

@end

@implementation NSObject (SafeKit)
- (void)safeAddObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
    NSString *observerName = NSStringFromClass([observer class]);
    NSString *newKeyPath = [NSString stringWithFormat:@"%@_%@", keyPath, observerName];
    NSMutableArray *mutableArr = objc_getAssociatedObject(observer, "ObserverList");
    if (!mutableArr) {
        mutableArr = [NSMutableArray array];
        [mutableArr addObject:newKeyPath];
        objc_setAssociatedObject(observer, "ObserverList", mutableArr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }else {
        if ([mutableArr containsObject:newKeyPath]) {
            return;
        }else {
            [mutableArr addObject:newKeyPath];
        }
    }

    return [self safeAddObserver:observer forKeyPath:keyPath options:options context:context];
}

- (void)safeRemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(nullable void *)context {
    NSString *observerName = NSStringFromClass([observer class]);
    NSString *newKeyPath = [NSString stringWithFormat:@"%@_%@", keyPath, observerName];
    NSMutableArray *mutableArr = objc_getAssociatedObject(observer, "ObserverList");
    if (mutableArr) {
        if ([mutableArr containsObject:newKeyPath]) {
            [mutableArr removeObject:newKeyPath];
        }else {
            return;
        }
    }else {
        return;
    }
    
    return [self safeRemoveObserver:observer forKeyPath:keyPath context:context];
}

- (void)safeRemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    NSString *observerName = NSStringFromClass([observer class]);
    NSString *newKeyPath = [NSString stringWithFormat:@"%@_%@", keyPath, observerName];
    NSMutableArray *mutableArr = objc_getAssociatedObject(observer, "ObserverList");
    if (mutableArr) {
        if ([mutableArr containsObject:newKeyPath]) {
            [mutableArr removeObject:newKeyPath];
        }else {
            return;
        }
    }else {
        return;
    }
    return [self safeRemoveObserver:observer forKeyPath:keyPath];
}

@end

@implementation SafeObserver

@end
