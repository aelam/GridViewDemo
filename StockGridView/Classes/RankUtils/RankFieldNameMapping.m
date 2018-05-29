//
//  RankFieldNameMapping.m
//  StockGridView
//
//  Created by ryan on 2018/5/29.
//

@import SKDynamicStock;

#import "RankFieldNameMapping.h"

@implementation RankFieldNameMapping

+ (NSDictionary <NSNumber*, NSString *>*)fieldsIdNameMapping {
    static NSDictionary *mapping = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mapping =
        @{
          @(stock_name): @"名称",
          @(clo_prc): @"最新",
          @(change_ratio): @"涨幅",
          @(cpx_dur_days): @"BS",
          @(change_prc): @"涨跌",
          @(turnover_ratio): @"换手",
          @(volume): @"总手",
          @(amount): @"总金额",
          @(big_order_inflow_amt): @"主力净买",
          @(big_order_inflow_dur_today): @"主力强买",
          @(high_prc): @"最高",
          @(low_prc): @"最低",
          @(quantity_relative_ratio): @"量比",
          @(amplitude): @"振幅",
          @(speed_ratio): @"涨速",
          @(open_prc): @"开盘",
          @(pre_clo_prc): @"昨收",
          @(pe_ratio): @"市盈率(TTM)",
          @(pb_ratio): @"市净率",
          @(tradable_market_value): @"流通市值",
          @(total_market_value): @"总市值",
          @(RiseHeadGoodsName): @"领涨个股",
          @(change_ratio_of5): @"5日涨幅",
          @(up_stock_num): @"上涨家数",
          @(down_stock_num): @"下跌家数",
          @(change_ratio_month): @"月涨幅",
          @(change_ratio_halfyear): @"半年涨幅",
          @(change_ratio_year): @"年涨幅",
          @(premium_ratio): @"溢价率",
          @(futures_goods_balance): @"期现差",
          @(cur_vol): @"现手",
          @(hold_vol): @"持仓量",
          @(hold_vol_increase_day): @"日增仓",
          @(contract_value): @"合约价值(万元/手)",
          @(pre_settl_prc): @"昨结算",
          @(amplitude_of_fluctation): @"波幅",
          @(buying_rate): @"现汇买入价",
          @(cash_buying_rate): @"现钞买入价",
          @(selling_rate): @"现汇卖出价",
          @(cash_selling_rate): @"现钞卖出价",
          @(big_order_ratio): @"大单比率",
          @(big_order_inflow_amt5): @"五日净买",
          @(big_order_inflow_days5): @"5日增仓",
          @(big_order_inflow_days10): @"10日增仓",
          @(big_order_inflow_days20): @"20日增仓",
          @(static_delivery_date): @"交割日",
          @(valuations): @"估值",
          @(static_net_value): @"净值",
          @(lever_price): @"价格杠杆",
          @(PARENT_FUND_NAME): @"母基名称",
          @(static_parent_fund_net_value): @"母基净值",
          @(static_up_parent_fund_rise): @"上折母基金需涨",
          @(static_under_parent_fund_fall): @"下折母基金需跌",
          @(static_AB_share_ratio): @"A:B份额比",
          @(TARGET_STOCK_NAME): @"参考指数",
          @(TARGET_STOCK_CHANGE_RATIO): @"指数涨幅",
          @(static_earnings_per_shares): @"每股收益",
          @(earnings_per100000shares): @"10万收益(元)",
          @(earnings_per_one_thousand): @"1千收益(元)",
          @(DAILY_EARNINGS_PER_TEN_THOUSAND): @"每万元日收益(元)",
          @(static_funds_available_date): @"资金可用(日期)",
          @(static_net_assets): @"净资产",
          @(static_conversion_price): @"转股价",
          @(conversion_value): @"转股价值",
          @(static_due_time): @"到期时间",
          @(static_remaining_years): @"剩余年限",
          @(static_resale_price): @"回售触发价",
          @(static_strong_price): @"强赎触发价",
          @(static_convertible_bonds_ratio): @"转债占比",
          @(full_price): @"全价",
          @(static_interest_payment): @"距付息(天)",
          @(static_duration): @"久期",
          @(static_pre_tax_earnings_rate): @"税前收益",
          @(static_after_tax_earnings_rate): @"税后收益",
          @(static_coupon): @"票息",
          @(static_guarantee): @"担保",
          @(static_bond_credit): @"债券信用",
          @(static_main_credit): @"主体信用",
          @(static_bond_scale): @"规模(亿)",
          @(static_total_share_capital): @"总股本",
          @(committee): @"委比",
          };
    });
    
    return mapping;
}


@end
