//
//  SafeCallSelector.h
//  timerLeak
//
//  Created by admin on 2017/10/20.
//  Copyright © 2017年 sunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 统一日志输出类
 */
@interface SafeCallSelector : UIViewController

/**
 记录日志，打印出来，也可以上传到指定服务器,已经做了防护，不会crash

 @param crashMessage 自定义的错误日志
 */
- (void)SHCrashProtectCollectCrashMessages:(NSString *)crashMessage;


/**
 抓取crash记录，发生奔溃，没有防护

 @param crashMessage 自定义的错误日志
 */
- (void)SHCatchCrashMessages:(NSString *)crashMessage;
@end
