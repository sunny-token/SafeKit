//
//  SafeCallSelector.m
//  timerLeak
//
//  Created by admin on 2017/10/20.
//  Copyright © 2017年 sunhua. All rights reserved.
//

#import "SafeCallSelector.h"

@implementation SafeCallSelector
- (void)SHCrashProtectCollectCrashMessages:(NSString *)crashMessage{
    
    NSLog(@"===Crash(Protect)=== \n %@ \n %@",crashMessage, [NSThread callStackSymbols]);
    
}

- (void)SHCatchCrashMessages:(NSString *)crashMessage {
    
    NSLog(@"===Crash=== \n %@",crashMessage);
    printLastSelectorName(crashMessage);
}

static void printLastSelectorName(NSString *crashStackString)
{
    // print registers
    NSLog(@"*** print registers begin. ***");
    if (crashStackString.length > 0 && ([crashStackString rangeOfString:@"objc_msgSend"].location != NSNotFound)) {
        NSLog(@"*** have found objc_msgSend. ***");
        NSString *r1Flag = @"r1: 0x";
        NSString *x1Flag = @"x1: 0x";
        NSRange rangeContainsR1Reg = [crashStackString rangeOfString:r1Flag];
        NSRange rangeContainsX1Reg = [crashStackString rangeOfString:x1Flag];
        
        NSString *valOfR1X1 = nil;
        
        @try {
            if ((rangeContainsR1Reg.location != NSNotFound) && (crashStackString.length >= rangeContainsR1Reg.location + r1Flag.length + 8)) { // 32-bit
                valOfR1X1 = [crashStackString substringWithRange:NSMakeRange(rangeContainsR1Reg.location + r1Flag.length, 8)];
            }
            else if ((rangeContainsX1Reg.location != NSNotFound) && (crashStackString.length >= rangeContainsX1Reg.location + x1Flag.length + 16)) { // 64-bit
                valOfR1X1 = [crashStackString substringWithRange:NSMakeRange(rangeContainsX1Reg.location + x1Flag.length, 16)];
            }
        }
        @catch (NSException *exception) {
            NSLog(@"*** exception: %@", exception);
        }
        
        if (valOfR1X1.length > 0) {
            unsigned long val = strtoul([[valOfR1X1 substringWithRange:NSMakeRange(0, valOfR1X1.length)] UTF8String], 0, 16);
            if (val != 0 && val != ULONG_MAX) {
                NSLog(@"*** r1(x1) val = %lx", val);
                NSLog(@"*** r1(x1): %@", NSStringFromSelector((SEL)val));
            }
        }
    }
    
    NSLog(@"*** print registers end. ***");
}
@end
