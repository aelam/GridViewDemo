//
//  SKStockFormatter.h
//  Pods
//
//  Created by ryan on 30/12/2016.
//
//

#import <Foundation/Foundation.h>
#import "SKDynamicCommon.h"

@protocol SKStock;

@protocol SKStockFormatter <NSObject>

+ (instancetype)formatterWithStock:(id<SKStock>)stock;

@property (nonatomic, readonly) id<SKStock> stock;

// 可通过colorFormatter[fieldId] 获取股票对应字段颜色
// 可通过stringFormatter[fieldId] 获取股票对应字段格式化字符串
- (id)objectForKeyedSubscript:(id<NSCopying>)key;
- (id)objectAtIndexedSubscript:(SKStockRequireField)field;

@end


@protocol StockStringFormatter <SKStockFormatter>

- (NSString *)objectAtIndexedSubscript:(SKStockRequireField)field;

@end
