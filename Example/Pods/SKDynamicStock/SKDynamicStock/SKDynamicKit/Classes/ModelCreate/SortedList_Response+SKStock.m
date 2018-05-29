//
//  SortedList_Response+SKStock.m
//  Pods
//
//  Created by ryan on 05/01/2017.
//
//

#import "SortedList_Response+SKStock.h"
#import "SKStock.h"
#import "SortedListResponse.pbobjc.h"
#import "SortedListRequest.pbobjc.h"

@import PINCache;

@implementation SortedList_Response (SKStock)

- (NSArray<id<SKStock>> *)stocksWithStockClass:(Class)stockClass {
    SortedList_Response *response = self;
    NSMutableArray <id<SKStock>>* goodsArray = [NSMutableArray array];
    for (SortedList_Response_ValueData *valueData in response.valueListArray) {
        id<SKStock> stock = [[stockClass alloc] init];
        stock.stockId = valueData.goodsId;
        stock.exchange = valueData.exchange;
        stock.category = (NSUInteger)valueData.category;
        
        for (int i = 0; i < valueData.fieldValueArray_Count; i++) {
            int key = [response.requestParams.fieldsIdArray valueAtIndex:i];
            id value = [valueData.fieldValueArray objectAtIndex:i];
            stock[key] = value;
        }
        
        [goodsArray addObject:stock];
        [[PINMemoryCache sharedCache] setObject:self forKey:[NSString stringWithFormat:@"%zd",stock.stockId]];
        [PINMemoryCache sharedCache].ageLimit = 86400.0;//缓存1天时间
    }
    return goodsArray;
}

@end
