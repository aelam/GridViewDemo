//
//  SKSessionManager+WebAPI.h
//  Pods
//
//  Created by ryan on 03/05/2017.
//
//

#import <StockPB/SKSessionManager.h>

@interface SKSessionManager (WebAPI)

+ (void)setSharedWebAPIManager:(SKSessionManager *)manager;
+ (instancetype)sharedWebAPIManager;

@end
