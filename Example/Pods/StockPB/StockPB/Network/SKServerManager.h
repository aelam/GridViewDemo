//
//  SKServerManager.h
//  Pods
//
//  Created by ryan on 22/12/2016.
//
//

#import <Foundation/Foundation.h>
#import <StockPB/SKRequestMiddleWare.h>
#import <StockPB/SKServerProvider.h>

@interface SKServerManager : NSObject <SKServerProvider, SKRequestMiddleWare>

+ (instancetype)sharedManager;

@property (nonatomic, strong, readwrite) NSArray<NSString *> *hosts;
@property (nonatomic, assign) NSInteger failureThreshold;

@end
