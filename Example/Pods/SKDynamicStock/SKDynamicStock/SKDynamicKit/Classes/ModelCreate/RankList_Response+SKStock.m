//
//  RankList_Response+SKStock.m
//  Pods
//
//  Created by ryan on 05/01/2017.
//
//

#import "RankList_Response+SKStock.h"
#import "SortedListResponse.pbobjc.h"
#import "SortedList_Response+SKStock.h"

@implementation RankList_Response (SKStock)

- (NSArray<id<SKStock>> *)stocksWithStockClass:(Class<SKStock>)stockClass {
    RankList_Response *response = self;
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (RankList_Response_Response *subResponse in response.rankListResponseArray) {
        SortedList_Response *sortRes = subResponse.templateRankResponse;
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        if (sortRes != nil) {
            NSArray *goodsArray = [sortRes stocksWithStockClass:stockClass];
            [dict setObject:goodsArray forKey:subResponse.templateName];
            [tempArray addObject:dict];
        }
    }
    return tempArray;
}

- (NSDictionary *)groupedStocksWithStockClass:(Class<SKStock>)stockClass {
    RankList_Response *response = self;
    
    NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
    for (RankList_Response_Response *subResponse in response.rankListResponseArray) {
        SortedList_Response *sortRes = subResponse.templateRankResponse;
        NSArray *goodsArray;
        if (sortRes != nil) {
            goodsArray = [sortRes stocksWithStockClass:stockClass];
        }
        tempDict[subResponse.templateName] = goodsArray;
    }
    
    return tempDict;

}



@end
