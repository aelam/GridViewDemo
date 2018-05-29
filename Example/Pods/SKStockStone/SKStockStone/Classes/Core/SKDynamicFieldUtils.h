//
//  SKDynamicFieldUtils.h
//  SKStockStone
//
//  Created by ryan on 08/11/2017.
//

#import <Foundation/Foundation.h>
#import "SKDynamicCommon.h"

typedef NS_ENUM(NSUInteger, SKStockRequireFieldType) {
    SKStockRequireFieldTypePrice, //价格（开高低收，结算价等）
    SKStockRequireFieldTypeRatio,
    SKStockRequireFieldTypeRatioPercent,
    SKStockRequireFieldTypeAmount,
    SKStockRequireFieldTypeVolume, //成交量类型（成交量，持仓量、总手等）
    SKStockRequireFieldTypeOther
};

@interface SKDynamicFieldUtils : NSObject

+ (SKStockRequireFieldType)fieldTypeWithFieldId:(SKStockRequireField)fieldID;

@end
