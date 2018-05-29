//
//  ValueData_Response+SKStock.m
//  Pods
//
//  Created by songbo on 2017/3/27.
//
//

@import PINCache;
@import SKStockStone;

#import "ValueData_Response+SKStock.h"
#import "ValueDataResponse.pbobjc.h"
#import "ValueDataRequest.pbobjc.h"

@implementation ValueData_Response (SKStock)

- (id<SKStock>)stockWithStockClass:(Class)stockClass {
    ValueData_Response *response = self;
    id<SKStock> stock = [[stockClass alloc] init];
    stock.stockId = response.requestParams.goodsId;
    stock.exchange = response.exchange;
    stock.category = response.category;
    stock.tradeSession = (NSUInteger)response.tradeSession;
    [response.fieldValue enumerateKeysAndObjectsUsingBlock:^(int32_t key, NSString * _Nonnull object, BOOL * _Nonnull stop) {
        stock[key] = object;
    }];
    
    [[PINMemoryCache sharedCache] setObject:self forKey:[NSString stringWithFormat:@"%zd",stock.stockId]];
    [PINMemoryCache sharedCache].ageLimit = 86400.0;//缓存1天时间
    
    return stock;
}

- (NSArray *)stocksWithStockClass:(Class<SKStock>)stockClass {
    return @[[self stockWithStockClass:stockClass]];
}


@end
