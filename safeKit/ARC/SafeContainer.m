//
//  SafeContainer+SafeKit.h
//  timerLeak
//
//  Created by admin on 2017/10/20.
//  Copyright © 2017年 sunhua. All rights reserved.
//

#import "SafeContainer.h"
#import <objc/runtime.h>
#import "SafeCallSelector.h"

#pragma mark - NSArray

@interface NSArray (SafeKit)

@end

@implementation NSArray (SafeKit)
- (id)safeObjectAtIndexI:(NSUInteger)index
{
    if (index >= self.count)
    {
        NSString *crashMessages = [NSString stringWithFormat:@"[%@ %@] index {%lu} beyond bounds [0...%lu]",
                                   NSStringFromClass([self class]),
                                   NSStringFromSelector(_cmd),(unsigned long)index,
                                   MAX((unsigned long)self.count - 1, 0)];
        [[SafeCallSelector new] SHCrashProtectCollectCrashMessages:crashMessages];
        return nil;
    }
    
    return [self safeObjectAtIndexI:index];
}

+ (id)safeArrayWithObjects:(const id [])objects count:(NSUInteger)cnt
{
    id validObjects[cnt];
    NSUInteger count = 0;
    for (NSUInteger i = 0; i < cnt; i++)
    {
        if (objects[i])
        {
            validObjects[count] = objects[i];
            count++;
        }
        else
        {
            NSString *crashMessages = [NSString stringWithFormat:@"[%@ %@] NIL object at index {%lu}",
                                       NSStringFromClass([self class]),
                                       NSStringFromSelector(_cmd),
                                       (unsigned long)i];
            [[SafeCallSelector new] SHCrashProtectCollectCrashMessages:crashMessages];
        }
    }
    
    return [self safeArrayWithObjects:validObjects count:count];
}

@end

#pragma mark - NSMutableArray

@interface NSMutableArray (SafeKit)

@end

@implementation NSMutableArray (SafeKit)
- (id)safeObjectAtIndexM:(NSUInteger)index
{
    if (index >= self.count)
    {
        NSString *crashMessages = [NSString stringWithFormat:@"[%@ %@] index {%lu} beyond bounds [0...%lu]",
                                   NSStringFromClass([self class]),
                                   NSStringFromSelector(_cmd),
                                   (unsigned long)index,
                                   MAX((unsigned long)self.count - 1, 0)];
        [[SafeCallSelector new] SHCrashProtectCollectCrashMessages:crashMessages];
        return nil;
    }
    
    return [self safeObjectAtIndexM:index];
}

- (void)safeAddObject:(id)anObject
{
    if (!anObject)
    {
        NSString *crashMessages = [NSString stringWithFormat:@"[%@ %@], NIL object.",NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
        [[SafeCallSelector new] SHCrashProtectCollectCrashMessages:crashMessages];
        return;
    }
    [self safeAddObject:anObject];
}

- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (index >= self.count)
    {
        NSString *crashMessages = [NSString stringWithFormat:@"[%@ %@] index {%lu} beyond bounds [0...%lu].",
                                   NSStringFromClass([self class]),
                                   NSStringFromSelector(_cmd),
                                   (unsigned long)index,
                                   MAX((unsigned long)self.count - 1, 0)];
        [[SafeCallSelector new] SHCrashProtectCollectCrashMessages:crashMessages];
        return;
    }
    
    if (!anObject)
    {
        NSString *crashMessages = [NSString stringWithFormat:@"[%@ %@] NIL object.",NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
        [[SafeCallSelector new] SHCrashProtectCollectCrashMessages:crashMessages];
        return;
    }
    
    [self safeReplaceObjectAtIndex:index withObject:anObject];
}

- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (index > self.count)
    {
        NSString *crashMessages = [NSString stringWithFormat:@"[%@ %@] index {%lu} beyond bounds [0...%lu].",
                                   NSStringFromClass([self class]),
                                   NSStringFromSelector(_cmd),
                                   (unsigned long)index,
                                   MAX((unsigned long)self.count - 1, 0)];
        [[SafeCallSelector new] SHCrashProtectCollectCrashMessages:crashMessages];
        return;
    }
    
    if (!anObject)
    {
        NSString *crashMessages = [NSString stringWithFormat:@"[%@ %@] NIL object.",NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
        [[SafeCallSelector new] SHCrashProtectCollectCrashMessages:crashMessages];
        return;
    }
    
    [self safeInsertObject:anObject atIndex:index];
}

@end

#pragma mark - NSDictionary

@interface NSDictionary (SafeKit)

@end

@implementation NSDictionary (SafeKit)

+ (instancetype)safeDictionaryWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt
{
    id validObjects[cnt];
    id<NSCopying> validKeys[cnt];
    NSUInteger count = 0;
    for (NSUInteger i = 0; i < cnt; i++)
    {
        if (objects[i] && keys[i])
        {
            validObjects[count] = objects[i];
            validKeys[count] = keys[i];
            count ++;
        }
        else
        {
            NSString *crashMessages = [NSString stringWithFormat:@"[%@ %@] NIL object or key at index{%lu}.",
                                       NSStringFromClass(self),
                                       NSStringFromSelector(_cmd),
                                       (unsigned long)i];
            [[SafeCallSelector new] SHCrashProtectCollectCrashMessages:crashMessages];
        }
    }
    
    return [self safeDictionaryWithObjects:validObjects forKeys:validKeys count:count];
}

@end

#pragma mark - NSMutableDictionary

@interface NSMutableDictionary (SafeKit)

@end

@implementation NSMutableDictionary (SafeKit)
- (void)safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (!aKey)
    {
        NSString *crashMessages = [NSString stringWithFormat:@"[%@ %@] NIL key.", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
        [[SafeCallSelector new] SHCrashProtectCollectCrashMessages:crashMessages];
        return;
    }
    if (!anObject)
    {
        NSString *crashMessages = [NSString stringWithFormat:@"[%@ %@] NIL object.",NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
        [[SafeCallSelector new] SHCrashProtectCollectCrashMessages:crashMessages];
        return;
    }
    
    [self safeSetObject:anObject forKey:aKey];
}

@end

#pragma mark - SafeContainer

@implementation SafeContainer


@end
