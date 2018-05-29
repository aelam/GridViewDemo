//
//  SKStockStringFormatter.m
//  Pods
//
//  Created by ryan on 30/12/2016.
//
//

#import "SKStockStringFormatter.h"
#import "SKStockFormatter.h"
#import "StringFormat.h"
#import "SKDynamicFieldUtils.h"

#import "SKDynamicCommon.h"
#import "SKStock.h"
#import "SKStockGenre.h"

@interface SKStockStringFormatter ()

@property (nonatomic, readwrite, strong) id<SKStock> stock;

@end

@implementation SKStockStringFormatter

+ (instancetype)formatterWithStock:(id<SKStock>)stock {
    SKStockStringFormatter *formatter = [[self alloc] init];
    formatter.stock = stock;
    
    return formatter;
}

- (id)objectForKeyedSubscript:(id<NSCopying>)key {
    return [self stringForFieldId:[(NSNumber *)key intValue]];
}

- (id)objectAtIndexedSubscript:(SKStockRequireField)idx {
    return [self stringForFieldId:(int32_t)idx];
}

- (NSString *)stringForFieldId:(int32_t)fieldId {
    
    NSObject *value = self.stock[fieldId];
    if (value == nil ||
        ([value isKindOfClass:[NSString class]] && [self.stock[fieldId] isEqualToString: @""])) {
        if ((fieldId == REPORT_QUARTER) || (fieldId == static_report_date)) //报告季度参数
        {
            return @"";
        }
        return @"--";
    }
    
    NSString *text = nil;
    SKStockRequireFieldType dataType = [SKDynamicFieldUtils fieldTypeWithFieldId:fieldId];
    
    if (dataType != SKStockRequireFieldTypeOther) {
        switch (dataType) {
            case SKStockRequireFieldTypePrice:
                text = [self priceFormatForFieldId:fieldId];
                break;
            case SKStockRequireFieldTypeRatio:
            {
                text = [self ratioStringFormatString:fieldId];
            }
                break;
            case SKStockRequireFieldTypeRatioPercent:
                text = [self ratioPercentFormatString:fieldId];
                break;
            case SKStockRequireFieldTypeVolume:
                text = [self volumeFormatForFieldId:fieldId];
                break;
            case SKStockRequireFieldTypeAmount:
                text = [self amountFormatForFieldId:fieldId];
                break;
            default:
                break;
        }
        if (text == nil || text.length == 0) {
            text = @"--";
        }
        
        return  text;
    }
    
    switch (fieldId) {
            
        case static_AB_share_ratio:
            text = ABRatioString([self.stock[fieldId] floatValue]);
            break;
        case static_interest_payment:                    //距付息(天)【债券】
            text = self.stock[fieldId];
            break;
        case static_remaining_years:                     //剩余年限【债券】【可转债】
        case contract_value:                      //合约价值【股指期货】
            text = HundredthString([[NSDecimalNumber decimalNumberWithString:self.stock[fieldId]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]]);
            //text = HundredthString([self.stock[fieldId] floatValue] / 10000.0);
            break;
            
        case static_coupon:                              //抓取的是票息【债券 年利率直接加%
        {
            NSString *piaoxiString = HundredthString([[NSDecimalNumber decimalNumberWithString:self.stock[fieldId]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]]);
            text = [NSString stringWithFormat:@"%@%%", piaoxiString];
            break;
        }
            
        case static_bond_credit:
        case static_main_credit:
            //            text = HundredthString([self.stock[fieldId] floatValue] / 10000.0);
            //            break;
        case static_due_time:
            text = [NSString stringWithFormat:@"%@", self.stock[fieldId]];
            break;
        case static_under_parent_fund_fall:              //下折母基金需跌【分级B】
            if ([self.stock[fieldId] floatValue] == 0) {
                text = @"无下折";
            }else {
                text = HundredthPercentageString([[NSDecimalNumber decimalNumberWithString:self.stock[fieldId]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]]);
            }
            break;
        case static_up_parent_fund_rise:                 //上折母基金需涨【分级B】
            text = HundredthPercentageString([[NSDecimalNumber decimalNumberWithString:self.stock[fieldId]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]]);
            break;
        case static_duration:                            //久期【债券】
        case static_bond_scale:                          //规模【债券】
            // text = HundredthString([self.stock[fieldId] floatValue] / 10000.0);
            text = HundredthString([[NSDecimalNumber decimalNumberWithString:self.stock[fieldId]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]]);
            
            break;
        case static_parent_fund_net_value:               //母基净值【分级B】
            text = TenThousandthString([[NSDecimalNumber decimalNumberWithString:self.stock[fieldId]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]]);
            break;
        case static_net_assets:                          //净资产【可转债】
        case conversion_value:	                 //转股价值【可转债】
        case static_guarantee:
            //text = HundredthString([self.stock[fieldId] floatValue] / 10000.0);
            text = HundredthString([[NSDecimalNumber decimalNumberWithString:self.stock[fieldId]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]]);
            
            break;
        case earnings_per100000shares:             //每十万元收益【回购 上证
        case earnings_per_one_thousand:            //每千元收益 深圳
        case DAILY_EARNINGS_PER_TEN_THOUSAND:      //每万元日收益
            text = ThousandthString([[NSDecimalNumber decimalNumberWithString:self.stock[fieldId]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]]);
            break;
        case valuations:                           //估值【分级B
            text = ThousandthString([[NSDecimalNumber decimalNumberWithString:self.stock[fieldId]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]]);
            break;
        case static_net_value:                            //净值【分级B】 四位小数
            text = TenThousandthString([[NSDecimalNumber decimalNumberWithString:self.stock[fieldId]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]]);
            break;
            
        case static_min_creation_unit:  //最小申赎单位
            text = [NSString stringWithFormat:@"%@万份",self.stock[fieldId]];
            break;
        case static_capital:   //流通股本
        case available_tradable_shares: //有效流通股本
            text = BigNumberString2([self.stock[fieldId] floatValue]);
            break;
        case static_earnings_per_shares:   //每股收益率（EPS）
            text = HundredthString([[NSDecimalNumber decimalNumberWithString:self.stock[fieldId]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]]);
            
            //    text = HundredthString([self.stock[fieldId] floatValue] / 10000.0);
            break;
        case static_repo_days:  //回购 期限
        case big_order_inflow_days10:
        case big_order_inflow_days20:
            text = [NSString stringWithFormat:@"%@", self.stock[fieldId]];
            break;
        case static_delivery_date:
        case static_funds_available_date:
            if ([self.stock[fieldId] intValue] > 0) {
                text = formatDateString(self.stock[fieldId]);
            }
            break;
        case hold_vol_increase_day://日增仓
            text = self.stock[fieldId];
            break;
        case amplitude_of_fluctation://波幅（国际汇率）
            text = HundredthPercentageString([[NSDecimalNumber decimalNumberWithString:self.stock[fieldId]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]]);
            break;
        case SUSPENDED_TIME://停牌开始时间
        case RESUME_TIME: //停牌结束时间
            text = FormatTimestampString(self.stock[fieldId],@"yyyy-MM-dd HH:mm");
            break;
        case committee: //委比
            text = HundredthString([[NSDecimalNumber decimalNumberWithString:self.stock[fieldId]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]]);
            text = [NSString stringWithFormat:@"%@%%", text];
            break;
        case static_total_share_capital:    //总股本
            text = BigNumberString([self.stock[fieldId] floatValue]);
            break;
        case static_AB_fund_id://
            text = self.stock[fieldId];
            break;
        case fund_establish_date: //基金成立日
            if ([self.stock[fieldId] intValue] > 0) {
                text = FormatTimestampString(self.stock[fieldId],@"yyyy-MM-dd");
            }
            break;
        case fund_total_shares: //份额
        case fund_total_shares_growth: //份额
            text = BigNumberString([self.stock[fieldId] floatValue]);
            break;
        case REPORT_QUARTER: //报告季度参数
            return [self reportQuarterFormatForFieldId:fieldId];
            //break;
        case static_report_date: //报告日期 基金超级盘口
            if ([self.stock[fieldId] intValue] > 0) {
                text = formatDateString(self.stock[fieldId]);
            }
            break;
        case pe_ratio://市盈率 （市盈率TTM）
            if ([self.stock[fieldId] intValue] > 0) {
                text = HundredthString([[NSDecimalNumber decimalNumberWithString:self.stock[fieldId]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]]);
            } else {
                text = @"亏损";
            }
            break;
        default:
        {
            // 没有配置field的格式化函数
            //            NSLog(@"String:没有配置field=%zd的格式化函数", fieldId);
            
            NSString *value = self.stock[fieldId];
            text = [NSString stringWithFormat:@"%@", value];
        }
            break;
            
    }
    
    if (text == nil || text.length == 0) {
        text = @"--";
    }
    
    return text;
}

- (NSString *)priceFormatForFieldId:(int32_t)fieldId {
    if(isFund(self.stock) || isBondSHSZ(self.stock) || isBondConvertible(self.stock) || ([self.stock exchange] == E_STATION_0_SH && ([self.stock category] & GROUP_SH_B) == GROUP_SH_B)/*上证B股*/ ||
       ([self.stock exchange] == E_STATION_0_SH && ([self.stock category] & GROUP_OPTIONS) == GROUP_OPTIONS) /*股票期权*/ ||
       ([self.stock exchange] == E_STATION_5_HK && ([self.stock category] & GROUP_HKZB) == GROUP_HKZB) /*香港主板*/ ) {
        // 基金/债券价格3位小数
        return ThousandthString([[NSDecimalNumber decimalNumberWithString:self.stock[fieldId]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]]);
    } else if ([self.stock exchange] == E_STATION_11_WH || isRMB_PJ(self.stock)) {
        // 国际汇率4位小数
        return TenThousandthString([[NSDecimalNumber decimalNumberWithString:self.stock[fieldId]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]]);
    } else if ([self.stock exchange] == E_STATION_4_GZQH ) {
        // 股指期货1位小数
        //&& (fieldId == clo_prc || fieldId == pre_clo_prc || fieldId == pre_settl_prc || fieldId == futures_goods_balance)
        return TenthString([[NSDecimalNumber decimalNumberWithString:self.stock[fieldId]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]]);
    } else if (isBondRepurchase(self.stock)/*上证深圳回购*/) {
        if (fieldId == clo_prc) {
            return ThousandthPercentageString([[NSDecimalNumber decimalNumberWithString:self.stock[fieldId]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]]);
        } else {
            return ThousandthString([[NSDecimalNumber decimalNumberWithString:self.stock[fieldId]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]]);
        }
    }
    else {
        return HundredthString([[NSDecimalNumber decimalNumberWithString:self.stock[fieldId]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]]);
    }
}


- (NSString *)ratioPercentFormatString:(int32_t)fieldId {
    
    NSString * text = HundredthPercentageString([[NSDecimalNumber decimalNumberWithString:self.stock[fieldId]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]]);
    
    return text;
}

- (NSString *)ratioStringFormatString:(int32_t)fieldId {
    //   NSString * text = HundredthString([self.stock[fieldId] floatValue] / 100.0);
    return HundredthString([[NSDecimalNumber decimalNumberWithString:self.stock[fieldId]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]]);
}


/**
 成交量类型（成交量，持仓量、总手等）
 单位精确到股，各品种股手转换倍率如下
 股票：1手=100股
 债券：1手=10股
 期货：1手=1股（合约）
 
 @param fieldId 参数
 @return 字符
 */
- (NSString *)volumeFormatForFieldId:(int32_t)fieldId {
    
    NSString *text = nil;
    if (isBond(self.stock)) {
        text = BigNumberVOLString([self.stock[fieldId] floatValue] / 10.0);
    } else if ([self.stock exchange] == E_STATION_4_GZQH) {
        text = BigNumberVOLString([self.stock[fieldId] floatValue]);
    } else {
        text = BigNumberVOLString([self.stock[fieldId] floatValue] / 100.0);
    }
    return text;
}

- (NSString *)amountFormatForFieldId:(int32_t)fieldId {
    
    NSString *text = BigNumberString([self.stock[fieldId] floatValue] / 1000.0);
    return text;
}

- (NSString *)reportQuarterFormatForFieldId:(int32_t)fieldId {
    NSString *text = @"";
    if ([self.stock[fieldId] intValue] == 0) {
        text = @"④";
    }else if ([self.stock[fieldId] intValue]== 1) {
        text = @"①";
    }else if ([self.stock[fieldId] intValue]== 2) {
        text = @"②";
    }else if ([self.stock[fieldId] intValue]== 3) {
        text = @"③";
    }
    return text;
}


@end
