//
//  SafeZombieSniffer
//
//  Created by linxinda on 2017/10/28.
//

#import <Foundation/Foundation.h>

/*!
 *  @category   SafeZombieSniffer
 *  zombie对象嗅探器
 */
@interface SafeZombieSniffer : NSObject

/*!
 *  @method installSniffer
 *  启动zombie检测
 */
+ (void)installSniffer;

/*!
 *  @method appendIgnoreClass
 *  添加白名单类
 */
+ (void)appendIgnoreClass: (Class)cls;

@end
