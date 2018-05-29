//
//  SKDynamicFieldUtils.m
//  SKStockStone
//
//  Created by ryan on 08/11/2017.
//

#import "SKDynamicFieldUtils.h"

@implementation SKDynamicFieldUtils

+ (SKStockRequireFieldType)fieldTypeWithFieldId:(SKStockRequireField)fieldId {
    SKStockRequireFieldType dataType = SKStockRequireFieldTypeOther;
    switch (fieldId) {
            //开高低收
        case open_prc:
        case high_prc:
        case low_prc:
        case clo_prc:
            
        case settl_prc://结算价（该值仅期货类数据有效）
        case target_stock_prc:/*标的股现价*/
        case change_prc: // 涨跌额
            
            //收盘价
        case pre_clo_prc://昨收价
        case net_asset_per_share://每股净资产
            //涨跌停价
        case static_lim_up_prc://涨停价
        case static_lim_down_prc://跌停价
        case aveprice: //均价
            //结算价
        case exercise_price://行权价（股票期权有效）
        case pre_settl_prc: //昨结算价（该值仅期货类数据有效）
            
            //买卖价
        case buy_prc1: //买一价
        case sell_prc1: //卖一价
        case bid_ask_spread: //买卖价差
            //人民币中间价
        case buying_rate:
        case cash_buying_rate:
        case selling_rate:
        case cash_selling_rate:
            
            //板块
        case TARGET_STOCK_CLO_PRC: //相关股票最新价
        case TARGET_STOCK_CHANGE_PRC:
        case AB_FUND_CHANGE_PRC://关联基金（AB）涨跌额
            
        case static_resale_price:                        //回售触发价【可转债】
        case static_strong_price:                        //强赎触发价【可转债】
            
        case static_conversion_price:                     //转股价【可转债】
        case full_price:                           //全价【债券】
            
        case lever_price:                          //杠杆价格【分级B】
            
        case futures_goods_balance:                //期现差【股指期货】
        case contract_value:                       //合约价值 【股指期货】
        case week52_high_price:                    //52周最高
        case week52_low_price:                     //52周最低
        case RISE_HEAD_PRC:
        case FALL_HEAD_PRC:
            dataType = SKStockRequireFieldTypePrice;
            
            break;
            //涨幅
        case change_ratio_month:     //月涨幅
        case change_ratio_halfyear:  //半年涨幅
        case change_ratio_year:      //年涨幅
        case change_ratio: // 涨跌幅
        case change_ratio_of5:
        case change_ratio_of10:
        case change_ratio_of20:
            
            //涨速
        case speed_ratio:
            
            //换手率
        case turnover_ratio:
        case turnover_ratio_of5://5日换手率
            
        case amplitude://振幅
            
            //板块 涨跌幅
        case RiseHeadGoodsZDF:// 板块领涨股涨跌幅
        case FallHeadGoodsZDF:// 板块领跌股涨跌幅
        case AB_FUND_CHANGE_RATIO: //关联基金（AB）涨跌幅
        case TARGET_STOCK_CHANGE_RATIO://相关股票涨跌幅
            
            //债券
        case static_pre_tax_earnings_rate:          //税前收益率【债券】
        case static_after_tax_earnings_rate:       //税后收益率【债券】
        case premium_ratio:                 //溢价率 升水比例
        case discount_ratio:                //折价率
        case static_convertible_bonds_ratio:       //转债占比【可转债】
        case overall_premium_ratio:  //整体溢价
        case fund_nearly_1m_return:
        case fund_nearly_3m_return:
        case fund_nearly_1y_return:
        case fund_nearly_3y_return:
            dataType = SKStockRequireFieldTypeRatioPercent;
            //            text = HundredthPercentageString([self.stock[fieldId] floatValue] / 100.0); // TODO
            
            break;
            
        case quantity_relative_ratio: // 量比
        case big_order_ratio://大单比率
        case pe_ratio_static:// 静态市盈率 （市盈动）
        case pb_ratio://市净率
            
            dataType = SKStockRequireFieldTypeRatio;
            
            //text = HundredthString([self.stock[fieldId] floatValue] / 100.0);
            break;
            
        case volume://成交量
        case cur_vol://现手（当前成交的笔数）
        case in_vol://内盘
        case EX_VOL://外盘
        case trade_num://笔数
        case commission://委差
            //买、卖量
        case buy_order_vol_m:
        case buy_order_vol_l:
        case buy_order_vol_xl:
        case sell_order_vol_m:
        case sell_order_vol_l:
        case sell_order_vol_xl:
        case sell_vol1:                           //卖一量
        case buy_vol1:                            //买一量 todo
            
            dataType = SKStockRequireFieldTypeVolume;
            //            text = BigNumberString([self.stock[fieldId] floatValue] / 100.0);
            
            break;
            
        case amount://成交额
        case tradable_market_value:      //流通市值
        case AVAILABLE_MARKET_VALUE:     //有效流通市值
        case total_market_value:         //总市值
        case big_order_inflow_amt:      //资金净流
        case big_order_inflow_amt5:     //5日资金净流
            //买额
        case buy_order_amt_m:   ////买额（中）
        case buy_order_amt_l:
        case buy_order_amt_xl:
        case sell_order_amt_m:
        case sell_order_amt_l:
        case sell_order_amt_xl:
        case fund_size: //基金规模
            
            dataType = SKStockRequireFieldTypeAmount;
            // text = BigNumberString([self.stock[fieldId] floatValue] / 1000.0);
            
            break;
        default:
            break;
    }
    return  dataType;
}

@end
