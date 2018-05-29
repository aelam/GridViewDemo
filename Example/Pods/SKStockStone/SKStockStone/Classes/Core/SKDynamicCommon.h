//
//  SKDynamicCommon.h
//  Pods
//
//  Created by 张峥嵘 on 16/11/24.
//
//

#import <Foundation/Foundation.h>

// TODO : REMOVE?
typedef NS_ENUM(UInt64, SKDynamicRequestType) {
    SKDynamicRequestTypeGPBUnsetOneOfCase = 0,
    SKDynamicRequestTypeSystem = 1, //市场分类模版
    SKDynamicRequestTypeCustom = 2,    //自定义股票列表
    SKDynamicRequestTypeGoods = 3   //板块ID，请求板块成分股排序使用
};

typedef NS_ENUM(int32_t, SKStockRequireField) {
    stock_name                          = 0,//股票名称
    code_name                           = 1,//股票代码名称
    trade_date                          = 2,//交易日期：yyyymmdd
    open_prc                            = 3,//开盘价
    high_prc                            = 4,//最高价
    low_prc                             = 5,//最低价
    clo_prc                             = 6,//成交价（最新价）
    volume                              = 7,//成交量
    amount                              = 8,//成交额
    cur_vol                             = 9,//现手(当前成交的笔数)
    in_vol                              = 10,//内盘
    
    buy_order_vol_m                     = 12,//买量（中）
    buy_order_vol_l                     = 13,//买量（大）
    buy_order_vol_xl                    = 14,//买量（特大）
    //market_maker_num                    = 15,//做市商数
    sell_order_vol_m                    = 16,//卖量（中）
    sell_order_vol_l                    = 17,//卖量（大）
    sell_order_vol_xl                   = 18,//卖量（特大）
    overall_premium_ratio               = 19,//整体溢价
    buy_order_amt_m                     = 20,//买额（中）
    
    buy_order_amt_l                     = 21,//买额（大）
    buy_order_amt_xl                    = 22,//买额（特大）
    neeq_info                           = 23,//新三板信息（创新层、优先股等）*
    sell_order_amt_m                    = 24,//卖额（中）
    sell_order_amt_l                    = 25,//卖额（大）
    sell_order_amt_xl                   = 26,//卖额（特大）
    pe_ratio_static                     = 27,//静态市盈率 （市盈率动）
    buy_prc1                            = 28,//买一价
    stock_hold_rate	                    = 29,//股票持仓比【分级A、分级B】*
    //AB_share_ratio                      = 30,//A:B份额比【分级B】
    
    //parent_fund_id                      = 31,//母基金【分级B】
    change_ratio_month                  = 32,//月涨幅
    change_ratio_halfyear               = 33,//半年涨幅
    change_ratio_year                   = 34,//年涨幅
    futures_goods_balance               = 35,//期现差【股指期货】
    net_leverage                        = 36,//净值杠杆【分级B】*

    sell_prc1                           = 38,//卖一价

    contract_value                      = 40,//合约价值【股指期货】
    
    bid_ask_spread                      = 49,//买卖价差
    buy_vol1                            = 50,//买一量
    
    tradable_market_value               = 53,//流通市值
    total_market_value                  = 54,//总市值

    a_fund_net_value                    = 57,//分级A净值

    sell_vol1                           = 60,//卖一量

    earnings_per100000shares	         = 61,//每十万元收益【回购】*
    valuations                           = 62,//估值【分级B
    earnings_per_one_thousand            = 63,//每千元收益【回购】*
    lever_price                          = 64,//杠杆价格【分级B】
    //conversion_price                     = 65,//转股价【可转债】 静态低频
    conversion_value	                 = 66,//转股价值【可转债】
    full_price                           = 67,//全价【债券】

    cpx_dur_days                        = 70,//操盘线个数（日）,正数表示买入信号持续天数（算当日），负数表示卖出信号
    cpx_dur_weeks                       = 71,//操盘线个数（周）,正数表示买入信号持续天数（算当日），负数表示卖出信号
    cpx_dur_months                      = 72,//操盘线个数（月）,正数表示买入信号持续天数（算当日），负数表示卖出信号
    cpx_dur_30m                         = 73,//操盘线个数（30分钟）,正数表示买入信号持续天数（算当日），负数表示卖出信号
    cpx_dur_60m                         = 74,//操盘线个数（60分钟）,正数表示买入信号持续天数（算当日），负数表示卖出信号
    up_stock_num                        = 75,//涨盘家数（该值仅指数板块类股票有意义）
    down_stock_num                      = 76,//跌盘家数（该值仅指数板块类股票有意义）
    plat_stock_num                      = 77,//平盘家数（该值仅指数板块类股票有意义）
    lead_up_stock                       = 78,//领涨个股ID（该值仅指数板块类股票有意
    lead_down_stock                     = 79,//领跌个股ID（该值仅指数板块类股票有意
    
    
    settl_prc                           = 80,//结算价（该值仅期货类数据有效）
    hold_vol                            = 81,//持仓量（该值仅期货类数据有效）
    hold_vol_increase                   = 82,//增仓（该值仅期货类数据有效）
    target_stock_prc                    = 83,//标的股现价（该值仅期货类数据有效，算基
    change_prc                          = 84,//涨跌额
    change_ratio                        = 85,//涨跌幅 %
    change_ratio_of5                    = 86,//5日涨跌幅
    change_ratio_of10                   = 87,//10日涨跌幅
    change_ratio_of20                   = 88,//20日涨跌幅
    speed_ratio                         = 89,//涨速幅
    turnover_ratio                      = 90,//换手率
    
    turnover_ratio_of5                  = 91,//5日换手率
    pe_ratio                            = 92,//市盈率
    pb_ratio                            = 93,//市净率
    quantity_relative_ratio             = 94,//量比
    big_order_inflow_amt                = 95,//资金净流
    big_order_inflow_amt5               = 96,//5日资金净流
    big_order_ratio                     = 97,//大单比率
    amplitude                           = 98,//振幅
    big_order_inflow_dur_today          = 99,//主力强买
    big_order_inflow_days5              = 100,//5日主力增仓
    
    big_order_inflow_days10             = 101,//10日主力增仓
    big_order_inflow_days20             = 102,//20日主力增仓
    hold_vol_increase_day               = 103,//日增仓
    week52_high_price                   = 104,//52周最高
    week52_low_price                    = 105,//52周最低
    pre_clo_prc                         = 106,//昨收价
    trading_halt                        = 107,//停牌标记
    //AB_fund_id                          = 108,//分级A/B股票ID
    discount_ratio	                    = 109,//折价率
    //avg_vol_of5                         = 110,//5日均量（算量比）
    
    //capital                             = 111,//流通股本
    //lim_up_prc                          = 112,//涨停价
    //lim_down_prc                        = 113,//跌停价
    committee                           = 116,//委比
    trade_num                           = 117,//笔数
    aveprice                            = 118,//均价
    pre_settl_prc                       = 119,//昨结算价（该值仅期货类数据有效）
    
    commission                          = 120,//委差
    
    target_stock_id                     = 121,//相关股票ID
    exercise_price                      = 122,//行权价（股票期权有效）
    call_put_flag                       = 123,//认沽认购标记（股票期权有效）
    premium_ratio                       = 124,//溢价率 升水比例
    
    data_timestamp                      = 125,//数据时间戳(YYYYMMDDhhmmss)*
    fund_size	                        = 126,//基金规模*
    fund_type	                        = 127,//基金类型*
    fund_establish_date                 = 128,//基金成立日(UINX时间戳)*
    fund_manager	                    = 129,//基金管理人*
    fund_nearly_1m_return               = 130,//基金近一个月回报*
    fund_nearly_3m_return               = 131,//基金近三个月回报*
    available_tradable_shares           = 132,//有效流通股*
    
    amplitude_of_fluctation             = 133,//波幅（国际汇率）
    buying_rate                         = 134,//现汇买入价
    cash_buying_rate                    = 135,//现钞买入价
    selling_rate                        = 136,//现汇卖出价
    cash_selling_rate                   = 137,//现钞卖出价
    
    fund_nearly_1y_return               = 138,//基金近一年回报*
    fund_nearly_3y_return	            = 139,//基金近三年回报*
    fund_total_shares                   = 140,//基金份额*
    fund_total_shares_growth            = 141,//基金份额增长 *
    net_asset_per_share                 = 142,//每股净资产*
    fund_total_shares_growth_datetime   = 143,//基金份额增长年月日(时间戳精确到毫秒)

    
    //低频动态字段
    static_hands_of_shares                   = 1001,//每手股数(港股)
    static_market_maker_num                  = 1002,//做市商数(新三板)
    static_delivery_date                     = 1003,//交割日(股指期货)
    static_AB_share_ratio                    = 1004,//AB份额比(分级基金)
    static_parent_fund_id                    = 1005,//母基金id(分级基金)
    static_under_parent_fund_fall            = 1006,//下折母基金需跌（分级基金）
    static_up_parent_fund_rise               = 1007,//上折母基金需涨（分级基金）
    static_parent_fund_net_value             = 1008,//母基净值（分级基金）
    static_AB_fund_id                        = 1009,//分级A/B股票ID（分级基金）
    static_min_creation_unit                 = 1010,//最小申赎单位（ETF基金）
    
    static_interest_payment                   = 1011,//距付息(天)（债券）
    static_remaining_years                    = 1012,//剩余年限（债券/可转债）
    static_coupon                             = 1013,//票息（债券）
    static_duration                           = 1014,//久期（债券）
    static_bond_scale                         = 1015,//规模（债券）
    static_guarantee                          = 1016,//担保（债券
    static_bond_credit                        = 1017,//债券信用（债券）
    static_main_credit                        = 1018,//主体信用（债券）
    static_due_time                           = 1019,//到期时间（债券/可转债）
    static_resale_price                       = 1020,//回售触发价（可转债）
    
    static_strong_price                       = 1021,//强赎触发价（可转债）
    static_convertible_bonds_ratio            = 1022,//转债占比（可转债）
    static_net_assets                         = 1023,//净资产（可转债）
    static_conversion_price                   = 1024,//转股价（可转债）
    static_funds_available_date               = 1025,//资金可用日期（回购）
    static_repo_days                          = 1026,//回购天数（回购）
    static_total_share_capital                = 1027,//总股本
    static_capital                            = 1028,//流通股本
    static_lim_up_prc                         = 1029,//涨停价
    static_lim_down_prc                       = 1030,//跌停价
    
    static_avg_vol_of5                        = 1031,//5日均量（算量比）
    static_earnings_per_shares                = 1032,//每股收益（EPS）
    static_net_value                    = 1033,//分级B净值（分级基金）static_fundB_net_value
    static_report_date                        = 1034,//报告日期
    static_pre_tax_earnings_rate              = 1035,//税前收益率【债券】
    static_after_tax_earnings_rate            = 1036,//税后收益率【债券】
    static_neeq_info                          = 1037,//新三板信息（创新层、优先股等）
    static_stock_hold_rate                    = 1038,//股票持仓比【分级A、分级B】

    //负数表示计算字段
    /*
     -1 板块（指数）领涨个股名称 string
     -2 板块（指数）领跌个股名称 string
     */
    RiseHeadGoodsName                   = -1,// 板块领涨股名称
    FallHeadGoodsName                   = -2,// 板块领跌股名称
    RiseHeadGoodsZDF                    = -3,// 板块领涨股涨跌幅
    FallHeadGoodsZDF                    = -4,// 板块领跌股涨跌幅
    TARGET_STOCK_CODE                   = -5,// 相关股票代码
    TARGET_STOCK_CLO_PRC                = -6,// 相关股票最新价
    TARGET_STOCK_CHANGE_PRC             = -7,// 相关股票涨跌额
    TARGET_STOCK_CHANGE_RATIO           = -8,//相关股票涨跌幅
    MARGIN_TRADING_FLAG                 = -9,// 融资融券标志
    PARENT_FUND_NAME                    = -10,//母基金名称
    TARGET_STOCK_NAME                   = -11,//相关股票名称
    AB_FUND_CODE                        = -12,//关联基金（AB）代码
    AB_FUND_NAME                        = -13,//关联基金（AB）名称
    AB_FUND_CHANGE_PRC                  = -14,//关联基金（AB）涨跌额
    AB_FUND_CHANGE_RATIO                = -15,//关联基金（AB）涨跌幅
    SUSPENDED_REASON                    = -16,//停牌理由
    SUSPENDED_TIME                      = -17,//停牌开始时间(unix时间戳)
    RESUME_TIME                         = -18,//停牌结束时间（预计）(UINX时间戳)
    EX_VOL                              = -19,//外盘
    AVAILABLE_MARKET_VALUE              = -20,//有效流通市值*
    
    NEEQ_TYPE                           = -21,//类型（新三版）*
    NEEQ_LEVEL                          = -22,//级别（新三板）*
    NEEQ_EXCHANGE                       = -23,//转让（新三板）*
    REPORT_QUARTER                      = -24,//报告季度（1-3表示1-3季度，0表示4季度）
    DAILY_EARNINGS_PER_TEN_THOUSAND     = -25,//每万元日收益
    
    RISE_HEAD_PRC                       = -26,//板块（指数）领涨个股最新价
    FALL_HEAD_PRC                       = -27,//板块（指数）领跌个股最新价
    GOODS_DOCTOR_FLAG                   = -28,//股票医生评级
    BOARD_FRONT_ZF_STOCK                = -29,//[ { "stock_code": 100966, "stock_name": "葫芦回售", "code_name": "100966", "exchange": 0 , "category": 32, "trade_session": 1, "close": 0, "price": 0 } ] )
    FUTURES_GOODS_BASIS                 = -30,//基差
    FUTURES_GOODS_DIFFERENCE            = -31,//差幅（基差百分比

    
    //客服端自定义字段
    goods_time_version                  = -1000  //ValueData_Response 使用
};

//沪市exchange == 0
#define GROUP_SH_INDEX	0x00000001ULL	//指数
#define GROUP_SH_A      0x00000002ULL	//A股
#define GROUP_SH_B      0x00000004ULL	//B股
#define GROUP_SH_JJ     0x00000008ULL	//基金
#define GROUP_SH_ZQ     0x00000010ULL	//债券
#define GROUP_SH_ZZ     0x00000020ULL	//转债
#define GROUP_SH_ST     0x00000040ULL	//ST股

#define GROUP_SH_HG_OLD     0x00000080ULL	//**回购-旧 //还用吗？沪市债券质押式回购

#define GROUP_SH_WIT    0x00000100ULL	//国债预发行
#define GROUP_SH_N      0x00000200ULL	//新股
#define GROUP_SH_OTHER	0x00000400ULL	//其他
#define GROUP_SH_Z      0x00000800ULL	//沪退市整理
#define GROUP_OPTIONS	0x00001000ULL	//期权
#define GROUP_SH_CEF	0x00002000ULL	//封闭式基金
#define GROUP_SH_OEF	0x00004000ULL	//开放式基金
#define GROUP_SH_ETF	0x00008000ULL	//ETF式基金
#define GROUP_SH_LOF	0x00010000ULL	//LOF式基金
#define GROUP_SH_XGZ	0x00020000ULL	//沪小公债
#define GROUP_SH_HGT    0x00040000ULL  //沪港通中的沪股通
#define GROUP_SH_AH     0x00080000ULL  //沪市AH股
#define SH_OPTIONS_TARGET	0x00100000ULL	//沪市股票期权标的股
#define GROUP_SH_FUND_A		0x00200000ULL	//沪市分级A基金
#define GROUP_SH_FUND_B		0x00400000ULL	//沪市分级B基金
#define GROUP_SH_HG         0x00800000ULL	//沪市债券质押式回购 **回购新
#define GROUP_SH_ZZ_VALID   0x01000000ULL   //沪市有效转债
#define GROUP_SH_RISK_WARNING   0x02000000ULL   //沪市风险警示
//深市exchange==1
#define GROUP_SZ_INDEX	0x00000001ULL	//指数
#define GROUP_SZ_A      0x00000002ULL	//A股
#define GROUP_SZ_B      0x00000004ULL	//B股
#define GROUP_SZ_JJ     0x00000008ULL	//基金
#define GROUP_SZ_ZQ     0x00000010ULL	//债券
#define GROUP_SZ_ZZ     0x00000020ULL	//转债
#define GROUP_SZ_ST     0x00000040ULL	//ST股

#define GROUP_SZ_HG_OLD 0x00000080ULL	//回购 **回购-旧 请使用新分类**

#define GROUP_SZ_N      0x00000100ULL	//新股
#define GROUP_SZ_OTHER	0x00000200ULL	//其他
#define GROUP_SZ_ZXB	0x00000400ULL	//深中小板
#define GROUP_SZ_CYB	0x00000800ULL  //深创业板
#define GROUP_SZ_STB	0x00001000ULL	//深三板
#define GROUP_SZ_Z      0x00002000ULL	//深退市整理
#define GROUP_SZ_CEF	0x00004000ULL	//封闭式基金
#define GROUP_SZ_OEF	0x00008000ULL	//开放式基金
#define GROUP_SZ_ETF	0x00010000ULL	//ETF式基金
#define GROUP_SZ_LOF	0x00020000ULL	//LOF式基金
#define SUB_ZXQY_1		0x00040000ULL	//新三板协议转让
#define SUB_ZXQY_2		0x00080000ULL	//新三板做市转让
#define SUB_ZXQY_3		0x00100000ULL	//新三板创新层
#define SUB_ZXQY_4		0x00200000ULL	//新三板基础层
#define SUB_ZXQY_5		0x00400000ULL	//两网及A股退市
#define SUB_ZXQY_6		0x00800000ULL	//B股退市
#define SUB_ZXQY_7		0x01000000ULL	//新增及首日转让
#define GROUP_GZXT1		0x02000000ULL	//股转系统-两网及退市(三板)
#define GROUP_GZXT2		0x04000000ULL	//股转系统-挂牌公司
#define GROUP_SZ_SGT    0x08000000ULL  //深港通中的深股通
#define GROUP_SZ_AH     0x10000000ULL  //深市AH股
#define GROUP_SZ_FUND_A		0x20000000ULL	//深市分级A基金
#define GROUP_SZ_FUND_B		0x40000000ULL	//深市分级B基金
#define GROUP_SZ_HG         0x80000000ULL	//深市债券质押式回购 --回购 **客户端回购使用新分类**
#define GROUP_SZ_SUB_ZS     0x100000000ULL	//深市新三板指数**
#define GROUP_SZ_ZZ_VALID   0x200000000ULL   //深市有效转债

//板块exchange==2
#define GROUP_GNBK		0x00000001ULL	//概念板块指数
#define GROUP_HYBK		0x00000002ULL	//行业板块指数
#define GROUP_DQBK		0x00000004ULL	//地区板块指数
#define GROUP_XGNBK		0x00000008ULL  //小概念	2006xxx
#define GROUP_XHYBK		0x00000010ULL  //小行业	2005xxx
#define GROUP_ZDYBK		0x00000020ULL	//板块指数 (未用)

//股指期货exchange==4
#define GROUP_GZQH		0x00000001ULL  //股指期货
#define GROUP_TF		0x00000002ULL  //国债期货
#define GROUP_WHQH		0x00000004ULL	//外汇期货（未用！）

//港股exchange==5
#define GROUP_HKZB		0x00000001ULL  //香港主板
#define GROUP_HK		0x00000002ULL  //沪市H股（不使用！）
#define GROUP_HK_AH     0x00000004ULL  //AH股对应的H股
#define GROUP_HGT_GGT   0x00000008ULL	//沪港通中的港股通
#define GROUP_SGT_GGT   0x00000010ULL	//深港通中的港股通
#define GROUP_HK_INDEX	0x00000020ULL	//港股指数

//环球指数exchange=6（）
#define GROUP_Global_MZ 0x00000001ULL  //美洲指数
#define GROUP_Global_OZ 0x00000002ULL  //欧洲市场指数
#define GROUP_Global_YT 0x00000004ULL  //亚太市场指数

//国内商品期货exchange=7（未用！）
#define GROUP_SHFE		0x00000001ULL	 //上海期货
#define GROUP_DCE		0x00000002ULL	 //大连商品
#define GROUP_CZCE		0x00000004ULL   //郑州商品

////国际商品期货 外盘期货exchange=8
#define GROUP_WPQH_NY   0x00000001ULL //国际商品期货能源
#define GROUP_WPQH_GJS  0x00000002ULL //国际商品期货贵金属
#define GROUP_WPQH_JBJS 0x00000004ULL //国际商品期货基本金属
#define GROUP_WPQH_NCP  0x00000008ULL //国际商品期货农产品

//中国概念exchange=9～10（未用！）
#define GROUP_CHINA_NJS  0x00000001ULL // 纽交所上市
#define GROUP_CHINA_NSDK 0x00000002ULL // 纳斯达克上市
#define GROUP_CHINA_MJS  0x00000004ULL // 美交所上市
#define GROUP_CHINA_PINK 0x00000008ULL // PINK市场
#define GROUP_CHINA_OTC  0x00000010ULL // OTC市场
#define GROUP_CHINA_DJIA 0x00000020ULL // 道琼斯指数成分股
#define GROUP_CHINA      0x00000040ULL // 中概股

//国际汇率 外汇exchange=11（未用！）
#define GROUP_WH            0x00000001ULL //外汇

//人民币牌价 exchange=?（未用！）
#define GROUP_RMB_PJ		0x00000001ULL //人民币牌价

//////////////////////////////////////////////////////////////////////////

// 市场类型
typedef NS_ENUM(uint32_t, E_STATION_TYPE) {
    E_STATION_0_SH			= 0,		//沪市
    E_STATION_1_SZ			= 1,		//深市
    E_STATION_2_BK			= 2,		//板块
    //E_STATION_3_HK	    = 3,     	//港股实时（AH双市股票）未用
    E_STATION_4_GZQH		= 4,		//股指国债期货
    E_STATION_5_HK			= 5,		//港股延时（港股主板）
    E_STATION_6_WI			= 6,		//环球指数
    E_STATION_7_SPQH		= 7,		//国内商品期货：上海期货、大连商品、郑州商品
    E_STATION_8_WPQH		= 8,		//国际商品期货
    E_STATION_9_US          = 9,		//美股中国概念股
    E_STATION_11_WH			= 11,		//外汇 国际汇率
    E_STATION_11_RMB        = 12,       //人民币牌价
    E_STATION_L1SH			= 15,		//沪市level 1
    E_STATION_MAX			= 16,
    E_STATION_UNDEFINED     = 10000     //未定义类型-勿删除
};

