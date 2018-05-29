//
//  SKDynamicStockModel.m
//  Pods
//
//  Created by 张峥嵘 on 16/11/21.
//
//

#import "SKDynamicStockModel.h"

@interface SKDynamicStockModel ()

@property (nonatomic, strong) NSMutableDictionary <NSNumber *, id>*stockInfo;

@end

@implementation SKDynamicStockModel

/////////////////////////////////////////////////////////////////////////////////////////////

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.stockInfo forKey:@"stockInfo"];
    [coder encodeInteger:self.stockId forKey:@"stockId"];
    [coder encodeInt32:self.exchange forKey:@"exchange"];
    [coder encodeInt64:self.category forKey:@"category"];
    [coder encodeInteger:self.tradeSession forKey:@"tradeSession"];
    
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        _stockInfo = [coder decodeObjectForKey:@"stockInfo"];
        self.stockId = [coder decodeIntegerForKey:@"stockId"];
        self.exchange = [coder decodeInt32ForKey:@"exchange"];
        self.category = [coder decodeInt64ForKey:@"category"];
        self.tradeSession = [coder decodeIntegerForKey:@"tradeSession"];
    }
    return self;
}

//MARK: - - Copy
- (id)copyWithZone:(NSZone *)zone {
    SKDynamicStockModel *newModel = [[SKDynamicStockModel alloc] init];
    
    newModel.stockId = self.stockId;
    newModel.exchange = self.exchange;
    newModel.category = self.category;
    newModel.tradeSession = self.tradeSession;
    [newModel.stockInfo addEntriesFromDictionary:self.stockInfo.mutableCopy];
    
    return newModel;
}

- (instancetype)init {
    if (self = [super init]) {
        self.stockInfo = [NSMutableDictionary dictionary];
    }
    return self;
}



#pragma mark - Subscript
- (id)objectForKeyedSubscript:(id<NSCopying>)key {
    return self.stockInfo[(NSNumber *)key];
}

- (void)setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    self.stockInfo[key] = obj;
}

- (id)objectAtIndexedSubscript:(SKStockRequireField)idx {
    return self.stockInfo[@(idx)];
}

- (void)setObject:(id)obj atIndexedSubscript:(SKStockRequireField)idx {
    self.stockInfo[@(idx)] = obj;
}

#pragma mark - General Properties
- (NSString *)stockName {
    return (NSString *)self.stockInfo[@(stock_name)];
}

- (void)setStockName:(NSString *)stockName {
    self.stockInfo[@(stock_name)] = stockName;
}


- (NSString *)codeName {
    return (NSString *)self.stockInfo[@(code_name)];
}

- (void)setCodeName:(NSString *)codeName {
    self.stockInfo[@(code_name)] = codeName;
}

- (NSString *)description {
    
    NSString *descString = [NSString stringWithFormat:@"stock--stockId:%zd,stockName:%@,codeName:%@,tradeSession:%zd,exchange:%zd,category:%zd \n stockInfo:%@",self.stockId,self.stockName,self.codeName,self.tradeSession,self.exchange,self.category,self.stockInfo];
    return descString;
}

@end


@implementation SKDynamicStockModel (Depracated)

+ (NSDictionary *)propertyAndFieldMapping {
    static NSDictionary *mapping = nil;
    if (mapping == nil) {
        mapping =
        @{
          @"stockName":@(stock_name),
          @"codeName":@(code_name),
          @"stockPrice":@(clo_prc),
          @"stockZDF":@(change_ratio),
          @"stockZD":@(change_prc),
          @"stockHSL":@(turnover_ratio),
          @"stockVolume":@(volume),
          @"stockAmount":@(amount),
          @"stockBigamt":@(big_order_inflow_amt),
          @"stockHigh":@(high_prc),
          @"stockLow":@(low_prc),
          @"stockLiangBi":@(quantity_relative_ratio),
          @"stockZhenFu":@(amplitude),
          @"stockOpen":@(open_prc),
          @"stockClose":@(pre_clo_prc),
          @"stockZDF5":@(change_ratio_of5),
          @"stockBKRise":@(up_stock_num),
          @"stockBKFall":@(down_stock_num),
          @"stockLTSZ":@(tradable_market_value),
          @"stockZSZ":@(total_market_value),
          @"stockSYL":@(pe_ratio),
          @"stockSJL":@(pb_ratio),
          @"bkHeaderName":@(RiseHeadGoodsName),
          @"bkHeaderZDF":@(RiseHeadGoodsZDF),
          @"stockZLQM":@(big_order_inflow_dur_today),
          @"stockZDFMonth":@(change_ratio_month),
          @"stockZDFHalfYear":@(change_ratio_halfyear),
          @"stockZDFYear":@(change_ratio_year),
          @"relateStockCode":@(TARGET_STOCK_CODE),
          @"relateStockPrc":@(TARGET_STOCK_CLO_PRC),
          @"relateStockZDF":@(TARGET_STOCK_CHANGE_RATIO),
          @"stockYJL":@(premium_ratio)
          };
    }
    return mapping;
}

@end
