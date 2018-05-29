//
//  SKTimerManager.h
//  StockPB
//
//  Created by 张峥嵘 on 2018/1/25.
//

#import <Foundation/Foundation.h>
@import GCDTimer;

@class RACSubject;

@interface SKTimerManager: NSObject

+ (instancetype)sharedManager;

@property (nonatomic, assign) NSInteger timer;
@property (assign, nonatomic) BOOL refreshAble;

@property (nonatomic, strong, readonly) RACSubject *refreshSubject;


@end
