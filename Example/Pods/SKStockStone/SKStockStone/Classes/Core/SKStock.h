//
//  SKStock.h
//  Pods
//
//  Created by ryan on 30/12/2016.
//
//

#import <Foundation/Foundation.h>
#import "SKDynamicCommon.h"

@protocol SKStock <NSObject, NSCopying>

//- (id)objectForKeyedSubscript:(id<NSCopying>)key;
//- (void)setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key NS_AVAILABLE(10_8, 6_0);

- (id)objectAtIndexedSubscript:(SKStockRequireField)index;
- (void)setObject:(id)obj atIndexedSubscript:(SKStockRequireField)index NS_AVAILABLE(10_8, 6_0);

@property (nonatomic, assign) NSUInteger stockId;       //股票ID
@property (nonatomic, copy) NSString *stockName;        //股票名  [stock_name]
@property (nonatomic, copy) NSString *codeName;         //股票代码显示名称 [code_name]
@property (nonatomic, assign) E_STATION_TYPE exchange;      // 市场
@property (nonatomic, assign) UInt64 category;          // 分类
@property (nonatomic, assign) NSUInteger tradeSession;  // 交易时间

@end

