//
//  SafeTimer.h
//  timerLeak
//
//  Created by sunhua on 2017/11/6.
//  Copyright © 2017年 sunhua. All rights reserved.
//
static char TimerKey;

#import <Foundation/Foundation.h>
/**
 替换NSTimer,CADisplayLink创建函数，使NSTimer,CADisplayLink不强引用对象
 */
@interface SafeTimer : NSObject

@end
