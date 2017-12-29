//
//  SafeZombieProxy.m
//
//  Created by linxinda on 2017/10/28.
//

#import "SafeZombieProxy.h"
#import "SafeCallSelector.h"

@implementation SafeZombieProxy


- (BOOL)respondsToSelector: (SEL)aSelector
{
    return [self.originClass instancesRespondToSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector: (SEL)sel
{
    return [self.originClass instanceMethodSignatureForSelector:sel];
}

- (void)forwardInvocation: (NSInvocation *)invocation
{
    [self callSaveToLocalWithSelector: invocation.selector];
}

#define SafeSaveZombieThrowMesssageToLcoal() [self callSaveToLocalWithSelector: _cmd]
- (Class)class
{
    SafeSaveZombieThrowMesssageToLcoal();
    return nil;
}

- (BOOL)isEqual:(id)object
{
    SafeSaveZombieThrowMesssageToLcoal();
    return NO;
}

- (NSUInteger)hash
{
    SafeSaveZombieThrowMesssageToLcoal();
    return 0;
}

- (id)self
{
    SafeSaveZombieThrowMesssageToLcoal();
    return nil;
}

- (BOOL)isKindOfClass:(Class)aClass
{
    SafeSaveZombieThrowMesssageToLcoal();
    return NO;
}

- (BOOL)isMemberOfClass:(Class)aClass
{
    SafeSaveZombieThrowMesssageToLcoal();
    return NO;
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    SafeSaveZombieThrowMesssageToLcoal();
    return NO;
}

- (BOOL)isProxy
{
    SafeSaveZombieThrowMesssageToLcoal();
    
    return NO;
}

- (id)retain
{
    SafeSaveZombieThrowMesssageToLcoal();
    return nil;
}

- (oneway void)release
{
    SafeSaveZombieThrowMesssageToLcoal();
}

- (id)autorelease
{
    SafeSaveZombieThrowMesssageToLcoal();
    return nil;
}

- (void)dealloc
{
    SafeSaveZombieThrowMesssageToLcoal();
    [super dealloc];
}

- (NSUInteger)retainCount
{
    SafeSaveZombieThrowMesssageToLcoal();
    return 0;
}

- (NSZone *)zone
{
    SafeSaveZombieThrowMesssageToLcoal();
    return nil;
}

- (NSString *)description
{
    SafeSaveZombieThrowMesssageToLcoal();
    return nil;
}


#pragma mark - Private
- (void)callSaveToLocalWithSelector: (SEL)selector
{
    NSString *crashMessages = [NSString stringWithFormat:@"(-[%@ %@]) was sent to a zombie object at address: %p", NSStringFromClass(self.originClass), NSStringFromSelector(selector), self];
    [[SafeCallSelector new] SHCrashProtectCollectCrashMessages:crashMessages];
}


@end
