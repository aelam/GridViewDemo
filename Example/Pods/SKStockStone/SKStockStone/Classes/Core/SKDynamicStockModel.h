//
//  SKDynamicStockModel.h
//  Pods
//
//  Created by 张峥嵘 on 16/11/21.
//
//

#import "SKStock.h"
#import "SKDynamicCommon.h"

@interface SKDynamicStockModel : NSObject <SKStock, NSCoding, NSCopying>


@property (nonatomic, assign) NSUInteger stockId;         //股票ID
@property (nonatomic, copy) NSString *stockName;        //股票名  [stock_name]
@property (nonatomic, copy) NSString *codeName;         //股票代码显示名称 [code_name]
@property (nonatomic, assign) E_STATION_TYPE exchange;       // 市场
@property (nonatomic, assign) uint64_t category;       // 分类
@property (nonatomic, assign) NSUInteger tradeSession;   // 交易时间

@end


@interface SKDynamicStockModel (Depracated)

+ (NSDictionary *)propertyAndFieldMapping;

@end
