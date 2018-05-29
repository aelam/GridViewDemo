//
//  PBResponseModelCreation.h
//  Pods
//
//  Created by ryan on 05/01/2017.
//
//

#import <Foundation/Foundation.h>

@protocol SKStock;


@protocol PBResponseModelCreator <NSObject>

@optional

- (NSArray *)stocksWithStockClass:(Class<SKStock>)stockClass;

- (NSDictionary *)groupedStocksWithStockClass:(Class<SKStock>)stockClass;

- (id<SKStock>)stockWithStockClass:(Class<SKStock>)stockClass;

@end


// 使用`PBResponseModelCreator` 替代
@protocol PBResponseModelCreation <PBResponseModelCreator>

@end
