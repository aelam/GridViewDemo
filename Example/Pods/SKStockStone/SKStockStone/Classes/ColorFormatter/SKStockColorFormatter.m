//
//  SKStockColorFormatter.m
//  Pods
//
//  Created by ryan on 30/12/2016.
//
//


#import "SKStockColorFormatter.h"
#import "SKStock.h"
#import "SKDynamicCommon.h"
#import "SKStockFormatter.h"
#import "SKStockGenre.h"
#import "SKStockColorConfiguration.h"

@interface SKStockColorFormatter ()

@property (nonatomic, readwrite, strong) id<SKStock> stock;

@end

@implementation SKStockColorFormatter

+ (instancetype)formatterWithStock:(id<SKStock>)stock {
    SKStockColorFormatter *formatter = [[self alloc] init];
    formatter.stock = stock;
    
    return formatter;
}

- (nullable id)valueForKey:(NSString *)key {
    return [self colorForField:[(NSNumber *)key intValue]];
}

- (id)objectForKey:(NSString *)key {
    return [self colorForField:[(NSNumber *)key intValue]];
}

#pragma mark - Subscript
- (id)objectForKeyedSubscript:(id<NSCopying>)key {
    return [self colorForField:[(NSNumber *)key intValue]];
}

- (id)objectAtIndexedSubscript:(SKStockRequireField)idx {
    return [self colorForField:(int32_t)idx];
}

// 注意: 外牌期货返回的`exchange` 不在枚举之中.
- (UIColor *)colorForField:(int32_t)fieldId {
    UIColor *color;
    switch (fieldId) {
            //*****************0--到--10******************//
        case stock_name:
            color = [[SKStockColorConfiguration sharedConfiguration] stockNameColor];
            break;
        case code_name:
            color = [[SKStockColorConfiguration sharedConfiguration] stockCodeColor];
            break;
        case trade_date:
            color = [[SKStockColorConfiguration sharedConfiguration] defaultTextColor];
            break;
        case open_prc:
            if ((self.stock.exchange == E_STATION_4_GZQH) || (self.stock.exchange >= 8000 && self.stock.exchange < 9000)){
                color = PriceColor([self.stock[open_prc] floatValue] - [self.stock[pre_settl_prc] floatValue]);
            }else {
                color = PriceColor([self.stock[open_prc] floatValue] - [self.stock[pre_clo_prc] floatValue]);
            }
            break;
        case high_prc:
        case low_prc:
        case aveprice:
            if (self.stock.exchange >= 8000 && self.stock.exchange < 9000) {//国际商品
                color = PriceColor([self.stock[fieldId] floatValue] - [self.stock[pre_settl_prc] floatValue]); // TODO
            }else {
                color = PriceColor([self.stock[fieldId] floatValue] - [self.stock[pre_clo_prc] floatValue]); // TODO
            }
            break;
        case clo_prc:
            if (self.stock.exchange == E_STATION_11_RMB) {
                color = nil;
            } else if (isBondRepurchase(self.stock))/*上证深圳回购*/ {
                color = [[SKStockColorConfiguration sharedConfiguration] raiseColor];
            } else {
                color = PriceColor([self.stock[change_ratio] floatValue]); // 通过涨跌幅获取颜色
            }
            break;
            
        case volume:
            color = [[SKStockColorConfiguration sharedConfiguration] volumeColor];
            break;
        case amount:
            color = [[SKStockColorConfiguration sharedConfiguration] amountColor];
            break;
        case cur_vol:
            color = [[SKStockColorConfiguration sharedConfiguration] volumeColor];
            break;
            //*****************11--到--20******************//
            //case buy_order_vol_s:
        case buy_order_vol_m:
        case buy_order_vol_l:
        case buy_order_vol_xl:
            //case sell_order_vol_s:
        case sell_order_vol_m:
        case sell_order_vol_l:
        case sell_order_vol_xl:
            //case buy_order_amt_s:
        case buy_order_amt_m:
            break;
        case overall_premium_ratio:   //整体溢价
            color = PriceColor([self.stock[fieldId] floatValue]);
            break;
            //*****************21--到--30******************//
        case buy_order_amt_l:
        case buy_order_amt_xl:
            //case sell_order_amt_s:
        case sell_order_amt_m:
        case sell_order_amt_l:
        case sell_order_amt_xl:
        case buy_prc1:
        case static_delivery_date:
            break;
        case committee:
            color = PriceColor([self.stock[fieldId] floatValue]);
            break;
        case static_AB_share_ratio:
            color = nil;
            break;
            //*****************31--到--40******************//
        case static_parent_fund_id:                     //母基金【分级B】
        case change_ratio_month:                  //月涨幅
        case change_ratio_halfyear:               //半年涨幅
        case change_ratio_year:                   //年涨幅
        case futures_goods_balance:               //期现差【股指期货】
            color = PriceColor([self.stock[fieldId] floatValue]);
            break;
        case static_interest_payment:                    //距付息(天)【债券】
        case static_remaining_years:                     //剩余年限【债券】【可转债】
        case sell_prc1:                           //卖一价
        case static_coupon:                              //票息【债券
        case contract_value:                      //合约价值【股指期货】
            
            //*****************41--到--50******************//
        case static_funds_available_date:                //资金可用(日期)【回购】
        case static_resale_price:                        //回售触发价【可转债】
        case static_strong_price:                        //强赎触发价【可转债】
        case static_convertible_bonds_ratio:             //转债占比【可转债】
        case static_bond_credit:                         //债券信用【债券】
        case static_main_credit:                         //主体信用【债券
        case static_due_time:                            //到期时间【债券、可转债】
            //case sell_order_num:                      //总卖挂单数
        case buy_vol1:                            //买一量
            color = nil;
            break;
            //*****************51--到--60******************//
        case static_under_parent_fund_fall:              //下折母基金需跌【分级B】
        case static_up_parent_fund_rise:                 //上折母基金需涨【分级B】
            color = PriceColor([self.stock[fieldId] floatValue]);
            break;
        case tradable_market_value:               //流通市值
        case total_market_value:                  //总市值
        case static_duration:                            //久期【债券】
        case static_bond_scale:                          //规模【债券】
        case static_parent_fund_net_value:               //母基净值【分级B】
        case static_net_assets:                          //净资产【可转债】
        case static_guarantee:                           //担保【债券】
        case sell_vol1:                           //卖一量
            
            //*****************61--到--70******************//
        case earnings_per100000shares:             //每十万元收益【回购 上证
        case earnings_per_one_thousand:            //每千元收益【回购 深圳
        case valuations:                           //估值【分级B
        case static_net_value:                            //净值【分级B】
        case lever_price:                          //杠杆价格【分级B】
        case static_conversion_price:                     //转股价【可转债】
        case conversion_value:	                 //转股价值【可转债】
        case full_price:                           //全价【债券】
        case static_pre_tax_earnings_rate:                //税前收益率【债券】
        case static_after_tax_earnings_rate:              //税后收益率【债券】
            
        case cpx_dur_days:
            //*****************70--到--80******************//
            color = [[SKStockColorConfiguration sharedConfiguration] raiseColor];;
        case cpx_dur_weeks:
        case cpx_dur_months:
        case cpx_dur_30m:
        case cpx_dur_60m:
            color = nil;
            break;
        case up_stock_num:
            color = [[SKStockColorConfiguration sharedConfiguration] raiseColor];;
            break;
        case down_stock_num:
            color = [[SKStockColorConfiguration sharedConfiguration] fallColor];
            break;
        case plat_stock_num:
            color = nil;
            break;
        case lead_up_stock:
            color = nil;
            break;
        case lead_down_stock:
            color = nil;
            break;
        case settl_prc:
            color = nil;
            break;
            
            //*****************81--到--90******************//
        case hold_vol:
            color = nil;
            break;
        case hold_vol_increase:
            color = nil;
            break;
        case target_stock_prc:
            color = nil;
            break;
        case change_prc:   // 涨跌额
        case change_ratio: // 涨跌幅
        case change_ratio_of5:
        case change_ratio_of10:
        case change_ratio_of20:
            color = PriceColor([self.stock[fieldId] floatValue]);
            break;
        case speed_ratio:
            color = PriceColor([self.stock[fieldId] floatValue]);
            break;
        case turnover_ratio:

            //*****************91--到--100******************//
        case turnover_ratio_of5:
            color = [[SKStockColorConfiguration sharedConfiguration] turnoverRatioColor];
            break;
        case pe_ratio:
            color = [[SKStockColorConfiguration sharedConfiguration] defaultTextColor];
            break;
        case pe_ratio_static:
        case pb_ratio:
            color = PriceColor([self.stock[fieldId] floatValue]);
            break;
        case quantity_relative_ratio: // 量比
            color = [[SKStockColorConfiguration sharedConfiguration] quantityRelativeRatioColor];
            break;
        case big_order_inflow_amt:
        case big_order_inflow_amt5:
            color = PriceColor([self.stock[fieldId] floatValue]);
            break;
        case big_order_ratio:
            color = nil;
            break;
        case amplitude:
        case big_order_inflow_dur_today: // 主力强买
        case big_order_inflow_days5:
            
            //*****************101--到--110******************//
        case big_order_inflow_days10:
        case big_order_inflow_days20:
        case hold_vol_increase_day:
            color = nil;
            break;
        case week52_high_price:
            color = [[SKStockColorConfiguration sharedConfiguration] raiseColor];
            break;
        case week52_low_price:
            color = [[SKStockColorConfiguration sharedConfiguration] fallColor];
            break;
        case pre_clo_prc:
            break;
        case trading_halt:
            break;
        case static_AB_fund_id:
            color = nil;
            break;
        case static_avg_vol_of5:
            color = nil;
            break;
            
            //*****************111--到--120******************//
        case static_capital:  //流通股本
            color = nil;
            break;
        case static_lim_up_prc:
            color = [[SKStockColorConfiguration sharedConfiguration] raiseColor];
            break;
        case static_lim_down_prc:
            color = [[SKStockColorConfiguration sharedConfiguration] fallColor];
            break;
        case static_min_creation_unit:  //最小申赎单位
            color = nil;
            break;
        case static_earnings_per_shares:   //每股收益率（EPS）
            color = PriceColor([self.stock[fieldId] floatValue]);
            break;
        case pre_settl_prc:
            color = nil;
            break;
        case discount_ratio:
            color = PriceColor([self.stock[fieldId] floatValue]);
            break;
            //*****************121--到--124******************//
            
        case target_stock_id:
            return self.stock[fieldId];
        case exercise_price:
            color = nil;
            break;
        case call_put_flag:
            color = nil;
            break;
        case premium_ratio:
            color = PriceColor([self.stock[fieldId] floatValue]);
            break;
        case fund_nearly_1m_return:
        case fund_nearly_3m_return:
        case fund_nearly_1y_return:
        case fund_nearly_3y_return:
            color = PriceColor([self.stock[fieldId] floatValue]);
            break;
            //*****************133--到--137******************//
        case amplitude_of_fluctation:
            color = nil;
            break;
        case buying_rate:
            color = nil;
            break;
        case cash_buying_rate:
            color = nil;
            break;
        case selling_rate:
            color = nil;
            break;
        case cash_selling_rate:
            color = nil;
            break;
        case net_asset_per_share:
            color = PriceColor([self.stock[fieldId] floatValue]);
            break;
            //*****************(-1)--到--(-10)扩展字段******************//
        case RiseHeadGoodsName:
        case FallHeadGoodsName:
        case RiseHeadGoodsZDF:
        case FallHeadGoodsZDF:
        case TARGET_STOCK_CODE:
            color = nil;
            break;
        case TARGET_STOCK_CLO_PRC:
        case TARGET_STOCK_CHANGE_PRC:
        case TARGET_STOCK_CHANGE_RATIO:
            color = PriceColor([self.stock[TARGET_STOCK_CHANGE_RATIO] floatValue]);;
            break;
        case MARGIN_TRADING_FLAG:
        case PARENT_FUND_NAME:
            color = nil;
            break;
        case TARGET_STOCK_NAME:  //相关股票名称
        case AB_FUND_CODE:      //关联基金（AB）代码
        case AB_FUND_NAME:    //关联基金（AB）名称
            color = nil;
            break;
        case AB_FUND_CHANGE_PRC: //关联基金涨跌额
        case AB_FUND_CHANGE_RATIO://关联基金涨跌幅
            color = PriceColor([self.stock[fieldId] floatValue]);
            break;
        case EX_VOL: //外盘
            color = [[SKStockColorConfiguration sharedConfiguration] raiseColor];;
            break;
        case in_vol: //内盘
            color = [[SKStockColorConfiguration sharedConfiguration] fallColor];
            break;
        default:
            // 没有配置field的格式化函数
            // TODO 默认颜色
//            NSLog(@"Color:没有配置field=%zd的格式化函数", fieldId);
            color = [[SKStockColorConfiguration sharedConfiguration] defaultTextColor];
    }
    if (color == nil) {
        color = [[SKStockColorConfiguration sharedConfiguration] defaultTextColor];
    }
    
    return color;
}


@end
