//
//  SKCheckTimeManager.h
//  StockPB
//
//  Created by RenChao on 2018/3/30.
//

#import <Foundation/Foundation.h>

/**
 时间校验管理器
 */
// todo: 请求服务器时间
@interface SKCheckTimeManager : NSObject

+ (instancetype)sharedManager;

/**
 已校验过的当前时间的时间戳，单位秒
 */
@property (assign, nonatomic, readonly) NSTimeInterval timeInterval;

/**
 已经校验过的时间
 */
@property (strong, nonatomic, readonly) NSDate *date;

/**
 服务器与本地时间差，单位秒
 */
@property (assign, nonatomic, readonly) NSTimeInterval deltaTime;


/**
 校验时间
 */
- (void)check;
    
@end
