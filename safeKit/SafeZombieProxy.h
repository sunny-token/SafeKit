//
//  SafeZombieProxy.h
//
//  Created by linxinda on 2017/10/28.
//

#import <Foundation/Foundation.h>

/*!
 *  @class  SafeZombieProxy
 *  zombie对象类
 */
@interface SafeZombieProxy : NSProxy

@property (nonatomic, assign) Class originClass;

@end
