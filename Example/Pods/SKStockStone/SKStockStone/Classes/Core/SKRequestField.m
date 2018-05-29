//
//  SKRequestField.m
//  Pods
//
//  Created by ryan on 29/12/2016.
//
//

#import "SKRequestField.h"
#import "SKDynamicCommon.h"

@implementation SKRequestField

+ (NSDictionary <NSNumber*, NSString *>*)fieldsIdNameMapping {
    static NSDictionary *mapping = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mapping =
        @{
          @(stock_name):@"名称",
          @(clo_prc):@"最新",
          @(change_ratio):@"涨幅",
          @(change_prc):@"涨跌",
          @(turnover_ratio):@"换手",
          @(volume):@"总手",
          @(amount):@"总金额",
          @(big_order_inflow_amt):@"主力净买",
          @(high_prc):@"最高",
          @(low_prc):@"最低",
          @(quantity_relative_ratio):@"量比",
          @(amplitude):@"振幅",
          @(speed_ratio):@"涨速",
          @(open_prc):@"开盘",
          @(pre_clo_prc):@"昨收",
          @(pe_ratio):@"市盈率(TTM)",
          @(pb_ratio):@"市净率",
          @(tradable_market_value):@"流通市值",
          @(total_market_value):@"总市值",
          @(RiseHeadGoodsName):@"领涨个股",
          @(change_ratio_of5):@"5日涨幅",
          @(up_stock_num):@"上涨家数",
          @(down_stock_num):@"下跌家数",
          @(change_ratio_month):@"月涨幅",
          @(change_ratio_halfyear):@"半年涨幅",
          @(change_ratio_year):@"年涨幅",
          @(premium_ratio):@"溢价率",
          @(futures_goods_balance):@"期现差",
          @(cur_vol):@"现手",
          @(hold_vol):@"持仓量",
          @(hold_vol_increase_day):@"日增仓",
          @(contract_value):@"合约价值(万元/手)",
          @(pre_settl_prc):@"昨结算",
          @(amplitude_of_fluctation):@"波幅",
          @(buying_rate):@"现汇买入价",
          @(cash_buying_rate):@"现钞买入价",
          @(selling_rate):@"现汇卖出价",
          @(cash_selling_rate):@"现钞卖出价",
          @(big_order_ratio):@"大单比率",
          @(big_order_inflow_amt5):@"五日净买",
          @(big_order_inflow_days5):@"连续买",
          @(big_order_inflow_days10):@"10日增仓",
          @(big_order_inflow_days20):@"20日增仓",
          @(static_delivery_date):@"交割日",
          @(valuations):@"估值",
          @(static_net_value):@"净值",
          @(lever_price):@"价格杠杆",
          @(PARENT_FUND_NAME):@"母基名称",
          @(static_parent_fund_net_value):@"母基净值",
          @(static_up_parent_fund_rise):@"上折母基金需涨",
          @(static_under_parent_fund_fall):@"下折母基金需跌",
          @(static_AB_share_ratio):@"A:B份额比",
          @(TARGET_STOCK_NAME):@"参考指数",
          @(TARGET_STOCK_CHANGE_RATIO):@"指数涨幅",
          @(static_earnings_per_shares):@"每股收益",
          @(earnings_per100000shares):@"10万收益(元)",
          @(earnings_per_one_thousand):@"1千收益(元)",
          @(DAILY_EARNINGS_PER_TEN_THOUSAND):@"每万元日收益(元)",
          @(static_funds_available_date):@"资金可用(日期)",
          @(static_net_assets):@"净资产",
          @(static_conversion_price):@"转股价",
          @(conversion_value):@"转股价值",
          @(static_due_time):@"到期时间",
          @(static_remaining_years):@"剩余年限",
          @(static_resale_price):@"回售触发价",
          @(static_strong_price):@"强赎触发价",
          @(static_convertible_bonds_ratio):@"转债占比",
          @(full_price):@"全价",
          @(static_interest_payment):@"距付息(天)",
          @(static_duration):@"久期",
          @(static_pre_tax_earnings_rate):@"税前收益",
          @(static_after_tax_earnings_rate):@"税后收益",
          @(static_coupon):@"票息",
          @(static_guarantee):@"担保",
          @(static_bond_credit):@"债券信用",
          @(static_main_credit):@"主体信用",
          @(static_bond_scale):@"规模(亿)",
          @(static_total_share_capital):@"总股本",
          @(committee):@"委比"
          };
    });
    
    return mapping;
}


+ (NSDictionary <NSString*, NSNumber *> *)fieldsNameIdMapping {
    static NSMutableDictionary *mapping = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mapping = [NSMutableDictionary dictionary];
        NSDictionary *idNameMapping = [self fieldsIdNameMapping];
        for (NSNumber *key in idNameMapping) {
            NSString *value = idNameMapping[key];
            mapping[value] = key;
        }
    });
                  
    return mapping;
}


+ (NSArray *)getRequireFieldsWithSectionType:(NSInteger)sectionType
{
    if (sectionType == 1000) {
        return @[@(stock_name),@(code_name),@(clo_prc),@(change_ratio),@(amount),@(change_prc),@(turnover_ratio),@(volume),@(big_order_inflow_amt),@(high_prc),@(low_prc),@(quantity_relative_ratio),@(amplitude),@(speed_ratio),@(open_prc),@(pre_clo_prc)];
    }
    else if (sectionType == 1001 || sectionType == 1003)
    {
        return @[@(stock_name),@(code_name),@(clo_prc),@(change_ratio),@(amount),@(change_prc),@(turnover_ratio),@(volume),@(big_order_inflow_amt),@(high_prc),@(low_prc),@(quantity_relative_ratio),@(amplitude),@(speed_ratio),@(pe_ratio),@(pb_ratio),@(tradable_market_value),@(total_market_value),@(open_prc),@(pre_clo_prc)];
    }
    else if (sectionType == 1002 || sectionType == 1008)
    {
        return @[@(stock_name),@(code_name),@(clo_prc),@(big_order_inflow_amt),@(change_ratio),@(amount),@(change_prc),@(turnover_ratio),@(volume),@(high_prc),@(low_prc),@(quantity_relative_ratio),@(amplitude),@(speed_ratio),@(pe_ratio),@(pb_ratio),@(tradable_market_value),@(total_market_value),@(open_prc),@(pre_clo_prc)];
    }
    else if (sectionType == 1004)
    {
        return @[@(stock_name),@(code_name),@(clo_prc),@(speed_ratio),@(change_ratio),@(amount),@(change_prc),@(turnover_ratio),@(volume),@(big_order_inflow_amt),@(high_prc),@(low_prc),@(quantity_relative_ratio),@(amplitude),@(pe_ratio),@(pb_ratio),@(tradable_market_value),@(total_market_value),@(open_prc),@(pre_clo_prc)];
    }
    else if (sectionType == 1005)
    {
        return @[@(stock_name),@(code_name),@(clo_prc),@(turnover_ratio),@(change_ratio),@(amount),@(change_prc),@(volume),@(big_order_inflow_amt),@(high_prc),@(low_prc),@(quantity_relative_ratio),@(amplitude),@(speed_ratio),@(pe_ratio),@(pb_ratio),@(tradable_market_value),@(total_market_value),@(open_prc),@(pre_clo_prc)];
    }
    else if (sectionType == 1006)
    {
        return @[@(stock_name),@(code_name),@(clo_prc),@(quantity_relative_ratio),@(change_ratio),@(amount),@(change_prc),@(turnover_ratio),@(volume),@(big_order_inflow_amt),@(high_prc),@(low_prc),@(amplitude),@(speed_ratio),@(pe_ratio),@(pb_ratio),@(tradable_market_value),@(total_market_value),@(open_prc),@(pre_clo_prc)];
    }
    else if (sectionType == 1007)
    {
        return @[@(stock_name),@(code_name),@(clo_prc),@(amount),@(change_ratio),@(change_prc),@(turnover_ratio),@(volume),@(big_order_inflow_amt),@(high_prc),@(low_prc),@(quantity_relative_ratio),@(amplitude),@(speed_ratio),@(pe_ratio),@(pb_ratio),@(tradable_market_value),@(total_market_value),@(open_prc),@(pre_clo_prc)];
    }
    else if (sectionType == 2000 || sectionType == 2001 || sectionType == 2002 || sectionType == 2003 || sectionType == 2004) {
        return @[@(stock_name),@(code_name),@(clo_prc),@(change_prc),@(change_ratio),@(RiseHeadGoodsName),@(RiseHeadGoodsZDF),@(change_ratio_of5),@(up_stock_num),@(down_stock_num),@(turnover_ratio),@(volume),@(amount),@(big_order_inflow_amt),@(change_ratio_month),@(change_ratio_halfyear),@(change_ratio_year),@(tradable_market_value),@(total_market_value),@(high_prc),@(low_prc),@(quantity_relative_ratio),@(amplitude),@(speed_ratio),@(open_prc),@(pre_clo_prc)];
    }
    else if (sectionType == 3001 || sectionType == 3002 || sectionType == 3003) {
        return @[@(stock_name),@(code_name),@(clo_prc),@(change_ratio),@(amount),@(change_prc),@(turnover_ratio),@(volume),@(big_order_inflow_amt),@(high_prc),@(low_prc),@(quantity_relative_ratio),@(amplitude),@(speed_ratio),@(pe_ratio),@(pb_ratio),@(tradable_market_value),@(total_market_value),@(open_prc),@(pre_clo_prc)];
    }
    else if (sectionType == 3004) {
        return @[@(stock_name),@(code_name),@(clo_prc),@(change_ratio),@(premium_ratio),@(TARGET_STOCK_CODE),@(TARGET_STOCK_CLO_PRC),@(TARGET_STOCK_CHANGE_RATIO),@(target_stock_id),@(TARGET_STOCK_NAME)];
    }
    else if (sectionType == 4000 || sectionType == 4001 || sectionType == 4002 || sectionType == 4003) {
        return @[@(stock_name),@(code_name),@(clo_prc),@(change_ratio),@(change_prc),@(high_prc),@(low_prc),@(amplitude),@(open_prc),@(pre_clo_prc)];
    }
    else if (sectionType == 4004) {
        return @[@(stock_name),@(code_name),@(clo_prc),@(change_ratio),@(change_prc),@(high_prc),@(low_prc),@(open_prc),@(pre_settl_prc)];
    }
    else if (sectionType == 4005) {
        return @[@(stock_name),@(code_name),@(clo_prc),@(change_ratio),@(change_prc),@(high_prc),@(low_prc),@(amplitude),@(amplitude_of_fluctation),@(open_prc),@(pre_clo_prc)];
    }
    else if (sectionType == 4006) {
        return @[@(stock_name),@(code_name),@(clo_prc),@(buying_rate),@(cash_buying_rate)];//,@(change_ratio),@(change_prc),@(selling_rate),@(cash_selling_rate)];//差一 中行折算价
    }
    else if (sectionType == 5001 || sectionType == 5101 || sectionType == 5201 || sectionType == 5301 || sectionType == 5401 || sectionType == 5002 || sectionType == 5102 || sectionType == 5202 || sectionType == 5302 || sectionType == 5402)
    {
        return @[@(stock_name),@(code_name),@(clo_prc),@(change_ratio),@(amount),@(change_prc),@(turnover_ratio),@(volume),@(big_order_inflow_amt),@(high_prc),@(low_prc),@(quantity_relative_ratio),@(amplitude),@(speed_ratio),@(pe_ratio),@(pb_ratio),@(tradable_market_value),@(total_market_value),@(open_prc),@(pre_clo_prc)];
    }
    else if (sectionType == 5003 || sectionType == 5103 || sectionType == 5203 || sectionType == 5303 || sectionType == 5403)
    {
        return @[@(stock_name),@(code_name),@(clo_prc),@(amount),@(change_ratio),@(change_prc),@(turnover_ratio),@(volume),@(big_order_inflow_amt),@(high_prc),@(low_prc),@(quantity_relative_ratio),@(amplitude),@(speed_ratio),@(pe_ratio),@(pb_ratio),@(tradable_market_value),@(total_market_value),@(open_prc),@(pre_clo_prc)];
    }
    else if (sectionType == 6000) { // 更多_期指_股指期货
        return @[@(stock_name),@(code_name),@(clo_prc),@(change_ratio),@(futures_goods_balance),@(premium_ratio),@(cur_vol),@(volume),@(amount),@(hold_vol),@(hold_vol_increase_day),@(contract_value),@(static_delivery_date),@(open_prc),@(pre_settl_prc)];//@"升水比例"@"交割日"
    }
    else if (sectionType == 6001) { // 更多_期指_股票期权
        return @[@(stock_name),@(code_name),@(clo_prc),@(change_ratio),@(change_prc),@(turnover_ratio),@(change_ratio_of5)];
    }
    else if (sectionType == 6011) { // 基金-分级B
        return@[@(stock_name),@(code_name),@(clo_prc),@(valuations),@(premium_ratio),@(change_ratio),@(static_net_value),@(volume),@(amount),@(TARGET_STOCK_NAME),@(TARGET_STOCK_CHANGE_RATIO),@(lever_price),@(static_AB_share_ratio),@(PARENT_FUND_NAME),@(static_parent_fund_net_value),@(static_under_parent_fund_fall),@(static_up_parent_fund_rise),@(open_prc),@(pre_clo_prc)];//
    }
    else if (sectionType >= 6010 && sectionType < 6020) { // 更多_基金
        return @[@(stock_name),@(code_name),@(clo_prc),@(change_ratio),@(amount),@(change_prc),@(turnover_ratio),@(volume),@(big_order_inflow_amt),@(high_prc),@(low_prc),@(quantity_relative_ratio),@(amplitude),@(speed_ratio),@(open_prc),@(pre_clo_prc)];
    }
    else if (sectionType >= 6020 && sectionType < 6030) { // 沪深
        return @[@(stock_name),@(code_name),@(clo_prc),@(change_ratio),@(amount),@(change_prc),@(turnover_ratio),@(volume),@(big_order_inflow_amt),@(high_prc),@(low_prc),@(quantity_relative_ratio),@(amplitude),@(speed_ratio),@(pe_ratio),@(pb_ratio),@(tradable_market_value),@(total_market_value),@(open_prc),@(pre_clo_prc)];
    }
    else if (sectionType >= 6030 && sectionType < 6040) { // 美股-中概股
        return @[@(stock_name),@(code_name),@(clo_prc),@(change_ratio),@(change_prc),@(turnover_ratio),@(high_prc),@(low_prc),@(amplitude),@(pe_ratio),@(static_earnings_per_shares),@(total_market_value),@(static_total_share_capital),@(open_prc),@(pre_clo_prc)];//@"总股本"
    }else if (sectionType == 60401) { //逆回购***
        return @[@(stock_name),@(code_name),@(clo_prc),@(DAILY_EARNINGS_PER_TEN_THOUSAND),@(static_funds_available_date),@(volume),@(amount),@(big_order_inflow_amt),@(high_prc),@(low_prc),@(open_prc),@(pre_clo_prc)];//
    }else if (sectionType == 6040) { // 上证回购
        return @[@(stock_name),@(code_name),@(clo_prc),@(DAILY_EARNINGS_PER_TEN_THOUSAND),@(earnings_per100000shares),@(static_funds_available_date),@(volume),@(amount),@(big_order_inflow_amt),@(high_prc),@(low_prc),@(open_prc),@(pre_clo_prc)];//
    }
    else if (sectionType == 6041) { // 深证回购
        return @[@(stock_name),@(code_name),@(clo_prc),@(DAILY_EARNINGS_PER_TEN_THOUSAND),@(earnings_per_one_thousand),@(static_funds_available_date),@(volume),@(amount),@(big_order_inflow_amt),@(high_prc),@(low_prc),@(open_prc),@(pre_clo_prc)];//
    }
    else if (sectionType == 6042) { // 可转债
        return @[@(stock_name),@(code_name),@(clo_prc),@(change_ratio),@(TARGET_STOCK_NAME),@(TARGET_STOCK_CHANGE_RATIO),@(static_net_assets),@(pb_ratio),@(static_conversion_price),@(conversion_value),@(premium_ratio),@(static_due_time),@(static_remaining_years),@(static_resale_price),@(static_strong_price),@(static_convertible_bonds_ratio),@(open_prc),@(pre_clo_prc)];//@"正股", @"正股涨幅",
    }
    else if (sectionType == 6043 || sectionType == 6044) { // 上证债券|深证债券
        return @[@(stock_name),@(code_name),@(clo_prc),@(change_ratio),@(full_price),@(static_interest_payment),@(static_remaining_years),@(static_duration),@(static_pre_tax_earnings_rate),@(static_after_tax_earnings_rate),@(static_coupon),@(static_due_time),@(static_bond_credit),@(static_main_credit),@(static_bond_scale),@(open_prc),@(pre_clo_prc)];//
    }
    else if (sectionType == 6045) { // 全部债权
        return @[@(stock_name),@(code_name),@(clo_prc),@(change_ratio),@(full_price),@(static_interest_payment),@(static_remaining_years),@(static_duration),@(static_pre_tax_earnings_rate),@(static_after_tax_earnings_rate),@(static_coupon),@(static_due_time),@(open_prc),@(pre_clo_prc),@(static_bond_credit),@(static_main_credit),@(static_bond_scale)];//
    }
    else {
        //
        return @[@(stock_name),@(code_name),@(clo_prc),@(speed_ratio),@(change_ratio),@(amount),@(change_prc),@(turnover_ratio),@(volume),@(big_order_inflow_amt),@(high_prc),@(low_prc),@(quantity_relative_ratio),@(amplitude),@(open_prc),@(pre_clo_prc)];
        //        return @[@"名称",@"最新",@"涨速",@"涨幅",@"涨跌",@"换手",@"总手",@"总金额",@"主力净买",@"最高",@"最低",@"量比",@"振幅",@"开盘",@"昨收"];
    }
}


+ (NSArray <NSNumber *> *)getShowFieldIDsByFieldIds:(NSArray *)fieldIds {
    NSMutableArray *fields = [NSMutableArray arrayWithArray:fieldIds];
    if ([fields containsObject:@(RiseHeadGoodsName)]) {
        [fields removeObject:@(RiseHeadGoodsZDF)];
        [fields removeObject:@(clo_prc)];
        [fields removeObject:@(change_prc)];
        [fields removeObject:@(high_prc)];
        [fields removeObject:@(low_prc)];
        [fields removeObject:@(quantity_relative_ratio)];
        [fields removeObject:@(amplitude)];
        [fields removeObject:@(speed_ratio)];
        [fields removeObject:@(open_prc)];
        [fields removeObject:@(pre_clo_prc)];
    }
    if ([fields containsObject:@(code_name)]) {
        [fields removeObject:@(code_name)];
    }
    if ([fields containsObject:@(trading_halt)]) {
        [fields removeObject:@(trading_halt)];
    }
    if ([fields containsObject:@(stock_name)]) {
//        [fields removeObject:@(stock_name)];
    }
    return fields;
}


+ (NSArray <NSString *> *)getShowTitlesByFieldIds:(NSArray *)fieldIds{
    NSMutableArray *tempArray = [NSMutableArray array];
//    [tempArray addObject:@"名称"];
    for (int i = 0; i < fieldIds.count; i++) {
        NSNumber *number = [fieldIds objectAtIndex:i];
        NSString *string = [[self fieldsIdNameMapping] objectForKey:number];
        if (string) {
            [tempArray addObject:string];
        } else {
            [tempArray addObject:@"未配置映射"];
        }
    }
    return tempArray;
}


@end


@implementation SKRequestField (GeneralFields)

#pragma mark - Private
+ (NSArray <NSNumber *>*)HS__BK__Global {
    return @[@(stock_name),@(code_name),@(clo_prc),@(change_ratio),@(amount),@(change_prc),@(turnover_ratio),@(volume),@(big_order_inflow_amt),@(high_prc),@(low_prc),@(quantity_relative_ratio),@(amplitude),@(speed_ratio),@(open_prc),@(pre_clo_prc)];
}

+ (NSArray <NSNumber *>*)HK__HS_JLC {
    return @[@(stock_name),@(code_name),@(clo_prc),@(big_order_inflow_amt),@(change_ratio),@(amount),@(change_prc),@(turnover_ratio),@(volume),@(high_prc),@(low_prc),@(quantity_relative_ratio),@(amplitude),@(speed_ratio),@(open_prc),@(pre_clo_prc)];
}

+ (NSArray <NSNumber *>*)Bond_SHZQ__Bond_SZZQ {
    return @[@(stock_name),@(code_name),@(clo_prc),@(change_ratio),@(open_prc),@(pre_clo_prc)];//
    //        return @[@"名称", @"最新", @"涨幅", @"全价", @"距付息(天)", @"剩余年限", @"久期", @"税前收益", @"税后收益", @"票息", @"担保", @"到期时间", @"开盘", @"昨收"];
}



#pragma mark - Public
//////////////////////////////////////////////////////////////////////////////
// 一级页面类
+ (NSArray <NSNumber *>*)HS {
    return [self HS__BK__Global];
}// 1000 // 沪深

+ (NSArray <NSNumber *>*)BK {
    return [self HS__BK__Global];
}// 1001 // 板块

+ (NSArray <NSNumber *>*)HK {
    return [self HK__HS_JLC];
}// 1002 // 港股

+ (NSArray <NSNumber *>*)Global {
    return [self HS__BK__Global];
}// 1003 // 全球

+ (NSArray <NSNumber *>*)More {
    return @[@(stock_name),@(code_name),@(clo_prc),@(speed_ratio),@(change_ratio),@(amount),@(change_prc),@(turnover_ratio),@(volume),@(big_order_inflow_amt),@(high_prc),@(low_prc),@(quantity_relative_ratio),@(amplitude),@(open_prc),@(pre_clo_prc)];
}// 1004 // 更多

+ (NSArray <NSNumber *>*)HS_HSL {
    return @[@(stock_name),@(code_name),@(clo_prc),@(turnover_ratio),@(change_ratio),@(amount),@(change_prc),@(volume),@(big_order_inflow_amt),@(high_prc),@(low_prc),@(quantity_relative_ratio),@(amplitude),@(speed_ratio),@(open_prc),@(pre_clo_prc)];
}//1005 // 沪深_换手率

+ (NSArray <NSNumber *>*)HS_JLC {
    return [self HS__BK__Global];
}// 1008 //沪深_资金净流出

// 专题
+ (NSArray <NSNumber *>*)HGT {
    return nil;
}// 2005 // 沪港通

+ (NSArray <NSNumber *>*)SGT {
    return nil;
}// 2006 // 深港通

// 新三板

+ (NSArray <NSNumber *>*)XSB_CX {
    return nil;
}// 3000 // 新三板_创新

+ (NSArray <NSNumber *>*)XSB_JC {
    return nil;
}// 3001 // 深港通

+ (NSArray <NSNumber *>*)XSB_ZS {
    return nil;
}// 3002 // 新三板_做市

+ (NSArray <NSNumber *>*)XSB_XY {
    return nil;
}// 3003 // 新三板_协议

+ (NSArray <NSNumber *>*)XSB_YXG {
    return nil;
}// 3004,// 新三板_优先股

// 更多-期指

+ (NSArray <NSNumber *>*)QZ_GZQH {
    return @[@(stock_name),@(code_name),@(clo_prc),@(change_ratio),@(futures_goods_balance),@(cur_vol),@(volume),@(amount),@(hold_vol),@(hold_vol_increase_day),@(contract_value),@(open_prc),@(pre_settl_prc)];//@"升水比例"@"交割日"
} // 6000, // 更多_期指_股指期货


+ (NSArray <NSNumber *>*)QZ_GPQH {
    return @[@(stock_name),@(code_name),@(clo_prc),@(change_ratio),@(change_prc),@(turnover_ratio),@(change_ratio_of5)];
 } // 6001, // 更多_期指_股票期权

+ (NSArray <NSNumber *>*)Fund_FJA {
    return nil;
}// 6010, // 更多_基金_分级A

+ (NSArray <NSNumber *>*)Fund_FJB {
    return nil;
}// 6011, // 更多_基金_分级B

+ (NSArray <NSNumber *>*)Fund_ETF {
    return nil;
}// 6012, // 更多_基金_ETF

+ (NSArray <NSNumber *>*)Fund_LOF {
    return nil;
}// 6013, // 更多_基金_LOF

+ (NSArray <NSNumber *>*)Fund_SHFB {
    return nil;
}// 6014, // 更多_基金_上证封闭基金

+ (NSArray <NSNumber *>*)Fund_SZFB {
    return nil;
}// 6014, // 更多_基金_深证封闭基金

+ (NSArray <NSNumber *>*)Fund_All {
    return nil;
}// 6015, // 更多_基金_全部基金

// 沪深

+ (NSArray <NSNumber *>*)SH_A {
    return nil;
}// 6020,      // 更多_沪深_上证A股

+ (NSArray <NSNumber *>*)SH_B {
    return nil;
}// 6021,      // 更多_沪深_上证B股

+ (NSArray <NSNumber *>*)SZ_A {
    return nil;
}// 6022,      // 更多_沪深_深证A股

+ (NSArray <NSNumber *>*)SZ_B {
    return nil;
}// 6023,      // 更多_沪深_深证B股

+ (NSArray <NSNumber *>*)ZXB {
    return nil;
 } // 6024,      // 更多_沪深_中小板

+ (NSArray <NSNumber *>*)CYB {
    return nil;
 } // 6025,      // 更多_沪深_创业板

+ (NSArray <NSNumber *>*)RiskTips {
    return nil;

}// 6026,      // 更多_沪深_风险提示

+ (NSArray <NSNumber *>*)TSZG {
    return nil;
}// 6027,      // 更多_沪深_退市整改

// 美股

+ (NSArray <NSNumber *>*)US_ZGG {
    return nil;
 } // 6030,       // 更多_美股_中概股

// 债券

+ (NSArray <NSNumber *>*)Bond_SHHG {
    return nil;
}// 6040,       // 更多_债券_上证回购

+ (NSArray <NSNumber *>*)Bond_SZHG {
    return nil;
}// 6041,       // 更多_债券_深证回购

+ (NSArray <NSNumber *>*)Bond_KZZ  {
    return nil;
}// 6042,       // 更多_债券_可转债

+ (NSArray <NSNumber *>*)Bond_SHZQ {
    return [self Bond_SHZQ__Bond_SZZQ];
}// 6043,       // 更多_债券_上证债券

+ (NSArray <NSNumber *>*)Bond_SZZQ {
    return [self Bond_SHZQ__Bond_SZZQ];
}// 6044,       // 更多_债券_深证债券

+ (NSArray <NSNumber *>*)Bond_ALLZQ {
    return @[@(stock_name),@(code_name),@(clo_prc),@(change_ratio),@(open_prc),@(pre_clo_prc)];//
    //        return @[@"名称", @"最新", @"涨幅", @"全价", @"距付息(天)", @"剩余年限", @"久期", @"税前收益", @"税后收益", @"票息", @"担保", @"到期时间", @"开盘", @"昨收", @"债券信用", @"主体信用", @"规模"];
}// 6045,       // 更多_债券_全部债权

//SKMarketSectionTypeThird_CX_CJE    = 5003,     //新三板_创新_成交额
//SKMarketSectionTypeThird_JC_CJE    = 5103,     //新三板_基础_成交额
//SKMarketSectionTypeThird_ZS_CJE    = 5203,     //新三板_做市_成交额
//SKMarketSectionTypeThird_XY_CJE    = 5303,      //新三板_协议_成交额
//SKMarketSectionTypeThird_YXG_CJE   = 5403,     //新三板_优先股_成交额
+ (NSArray <NSNumber *>*)XSB_CJE {
    return @[@(stock_name),@(code_name),@(clo_prc),@(amount),@(change_ratio),@(change_prc),@(turnover_ratio),@(volume),@(big_order_inflow_amt),@(high_prc),@(low_prc),@(quantity_relative_ratio),@(amplitude),@(speed_ratio),@(pe_ratio),@(pb_ratio),@(tradable_market_value),@(total_market_value),@(open_prc),@(pre_clo_prc)];
} //新三板_成交额

+ (NSArray <NSNumber *>*)HS_CJE {
    return @[@(stock_name),@(code_name),@(clo_prc),@(amount),@(change_ratio),@(change_prc),@(turnover_ratio),@(volume),@(big_order_inflow_amt),@(high_prc),@(low_prc),@(quantity_relative_ratio),@(amplitude),@(speed_ratio),@(open_prc),@(pre_clo_prc)];
}//1007, //沪深_成交额

@end


