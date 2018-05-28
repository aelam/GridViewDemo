//
//  SKSessionManager+WebAPI.h
//  Pods
//
//  Created by ryan on 03/05/2017.
//
//

#import <StockPB/SKSessionManager.h>
#import <StockPB/SKServerManager.h>

@interface SKTServerManager: SKServerManager

@end

@interface SKMServerManager: SKServerManager

@end


@interface SKMTServerManager: SKServerManager

@end

@interface SKSessionManager (T)

+ (void)setSharedTManager:(SKSessionManager *)manager;
+ (instancetype)sharedMTManager;

@end

@interface SKSessionManager (M)

+ (void)setSharedMManager:(SKSessionManager *)manager;
+ (instancetype)sharedMTManager;

@end


@interface SKSessionManager (MT)

+ (void)setSharedMTManager:(SKSessionManager *)manager;
+ (instancetype)sharedMTManager;

@end
