//
//  SKStockGenre.m
//  Pods
//
//  Created by flora on 17/2/28.
//
//

#import "SKStockGenre.h"


BOOL isIndexInland(id<SKStock> stock) {
    return (
            ( ([stock exchange] == E_STATION_0_SH) && ((stock.category & GROUP_SH_INDEX) == GROUP_SH_INDEX) )
            ||
            ( ([stock exchange] == E_STATION_1_SZ) && ((stock.category & GROUP_SZ_INDEX) == GROUP_SZ_INDEX) )
            ||
            ( ([stock exchange] == E_STATION_1_SZ) && ((stock.category & GROUP_SZ_SUB_ZS) == GROUP_SZ_SUB_ZS) )
            );
}

///MARK: isFund
BOOL isFundB(id<SKStock> stock) {
    return (
            ((stock.exchange == E_STATION_1_SZ) && ((stock.category & GROUP_SZ_FUND_B) == GROUP_SZ_FUND_B))
            ||
            ((stock.exchange == E_STATION_0_SH) && ((stock.category & GROUP_SH_FUND_B) == GROUP_SH_FUND_B))
           );
}

BOOL isFundA(id<SKStock> stock) {
    return (
            ((stock.exchange == E_STATION_1_SZ) && ((stock.category & GROUP_SZ_FUND_A) == GROUP_SZ_FUND_A))
            ||
            ((stock.exchange == E_STATION_0_SH) && ((stock.category & GROUP_SH_FUND_A) == GROUP_SH_FUND_A))
           );
}

BOOL isFundLOF(id<SKStock> stock) {
    return (
            ((stock.exchange == E_STATION_0_SH) && ((stock.category & GROUP_SH_LOF) == GROUP_SH_LOF))
            ||
            ((stock.exchange == E_STATION_1_SZ) && ((stock.category & GROUP_SZ_LOF) == GROUP_SZ_LOF))
           );
}

BOOL isFundETF(id<SKStock> stock) {
    return (
            ((stock.exchange == E_STATION_0_SH) && ((stock.category & GROUP_SH_ETF) == GROUP_SH_ETF))
            ||
            ((stock.exchange == E_STATION_1_SZ) && ((stock.category & GROUP_SZ_ETF) == GROUP_SZ_ETF))
           );
}


/// 封闭基金
BOOL isFundCEF(id<SKStock> stock) {
    return (
            ((stock.exchange == E_STATION_0_SH) && ((stock.category & GROUP_SH_CEF) == GROUP_SH_CEF))
            ||
            ((stock.exchange == E_STATION_1_SZ) && ((stock.category & GROUP_SZ_CEF) == GROUP_SZ_CEF))
           );
}

///开放基金
BOOL isFundOEF(id<SKStock> stock) {
    return (
            ((stock.exchange == E_STATION_0_SH) && ((stock.category & GROUP_SH_OEF) == GROUP_SH_OEF))
            ||
            ((stock.exchange == E_STATION_1_SZ) && ((stock.category & GROUP_SZ_OEF) == GROUP_SZ_OEF))
           );
}

BOOL isFund(id<SKStock> stock) {
    return  (isFundA(stock) ||
             isFundB(stock) ||
             isFundETF(stock) ||
             isFundLOF(stock) ||
             isFundCEF(stock) ||
             isFundOEF(stock) ||
             ((stock.exchange == E_STATION_0_SH) && ((stock.category & GROUP_SH_JJ) ==  GROUP_SH_JJ)));
}

///MARK: Bond
BOOL isBondRepurchase(id<SKStock> stock) {
    return (
            ((stock.exchange == E_STATION_0_SH) && ((stock.category & GROUP_SH_HG) == GROUP_SH_HG))
            ||
            ((stock.exchange == E_STATION_1_SZ) && ((stock.category & GROUP_SZ_HG) == GROUP_SZ_HG))
           );
}

BOOL isBondConvertible(id<SKStock> stock) {
    return (
            ((stock.exchange == E_STATION_1_SZ) && ((stock.category & GROUP_SZ_ZZ) == GROUP_SZ_ZZ))
            ||
            ((stock.exchange == E_STATION_0_SH) && ((stock.category & GROUP_SH_ZZ) == GROUP_SH_ZZ))
           );
}

BOOL isBondSHSZ(id<SKStock> stock) {
    return (
            ((stock.exchange == E_STATION_0_SH) && ((stock.category & GROUP_SH_ZQ) == GROUP_SH_ZQ))
            ||
            ((stock.exchange == E_STATION_1_SZ) && ((stock.category & GROUP_SZ_ZQ) == GROUP_SZ_ZQ))
           );
}

BOOL isBond(id<SKStock> stock) {
    return (isBondSHSZ(stock) ||
            isBondConvertible(stock) ||
            isBondRepurchase(stock));
}

///MARK: - - 三板 新三板
BOOL isXSB(id<SKStock> stock) {
    return (
            ((stock.exchange == E_STATION_1_SZ) && ((stock.category & GROUP_SZ_STB) == GROUP_SZ_STB))
            ||
            ((stock.exchange == E_STATION_1_SZ) && ((stock.category & SUB_ZXQY_1) == SUB_ZXQY_1))
            ||
            ((stock.exchange == E_STATION_1_SZ) && ((stock.category & SUB_ZXQY_2) == SUB_ZXQY_2))
            ||
            ((stock.exchange == E_STATION_1_SZ) && ((stock.category & SUB_ZXQY_3) == SUB_ZXQY_3))
            ||
            ((stock.exchange == E_STATION_1_SZ) && ((stock.category & SUB_ZXQY_4) == SUB_ZXQY_4))
          );
}

//深市-股转系统-两网及退市（三板）
BOOL isSB(id<SKStock> stock) {
    return (
            (stock.exchange == E_STATION_1_SZ)
             &&
            ((stock.category & GROUP_GZXT1) == GROUP_GZXT1)
           );
}

BOOL isSHSZ_SB(id<SKStock> stock) {
    return isSB(stock) || isXSB(stock);
}



///MARK: 全球
BOOL isGlobal(id<SKStock> stock) {
    return ((stock.exchange == E_STATION_11_WH) ||
            (stock.exchange == E_STATION_11_RMB)||
            isGlobalProductFuture(stock));
}

///MARK: - - 国际商品期货
BOOL isGlobalProductFuture(id<SKStock> stock) {
    return ((stock.exchange == E_STATION_8_WPQH) ||
            (stock.exchange/1000 == E_STATION_8_WPQH));
}

///
BOOL isGlobalIndex(id<SKStock> stock) {
    return ((stock.exchange  == E_STATION_6_WI) ||
            (stock.exchange/1000 == E_STATION_6_WI));
}


BOOL isInlandIndex(id<SKStock> stock) {
    return isIndexInland(stock);
}

///MARK: - - 期权
BOOL isOption(id<SKStock> stock) {
    return ((stock.exchange == E_STATION_1_SZ) && ((stock.category & GROUP_OPTIONS) == GROUP_OPTIONS));
}

///MARK: - - 股指期货
BOOL isGZQH(id<SKStock> stock) {
    return ((stock.exchange == E_STATION_4_GZQH) && ((stock.category & GROUP_GZQH) == GROUP_GZQH));
}

///MARK: - - HK
BOOL isHKIndex(id<SKStock> stock) {
    return ((stock.exchange == E_STATION_5_HK) && ((stock.category & GROUP_HK_INDEX) == GROUP_HK_INDEX));
}

BOOL isHKZB(id<SKStock> stock) {    // 香港主板
    return ((stock.exchange == E_STATION_5_HK) && ((stock.category & GROUP_HKZB) == GROUP_HKZB));
}

BOOL isHK(id<SKStock> stock) {      // 不包括HKIndex
    return ((stock.exchange == E_STATION_5_HK) && ((stock.category & GROUP_HK_INDEX) != GROUP_HK_INDEX));
}

BOOL isSHSZ_A(id<SKStock> stock) {
    return (
            (
             (stock.exchange == E_STATION_0_SH)
             && (
                 ((stock.category & GROUP_SH_A) == GROUP_SH_A)
                 || (
                     ((stock.category & GROUP_SH_ST) == GROUP_SH_ST) && (stock.category & GROUP_SH_B) == 0 )
                    )
            )
            ||
            (
             (stock.exchange == E_STATION_1_SZ)
             && (  ((stock.category & GROUP_SZ_A) == GROUP_SZ_A)
                 || ((stock.category & GROUP_SZ_ZXB) == GROUP_SZ_ZXB)
                 || ((stock.category & GROUP_SZ_CYB) == GROUP_SZ_CYB)
                 || (((stock.category & GROUP_SZ_ST) == GROUP_SZ_ST) && ((stock.category & GROUP_SZ_B) == 0) )
                 )
             )
            );
}

BOOL isSHSZ_B(id<SKStock> stock) {
    return (((stock.exchange == E_STATION_0_SH) && ((stock.category & GROUP_SH_B) == GROUP_SH_B)) ||
            ((stock.exchange == E_STATION_1_SZ) && ((stock.category & GROUP_SZ_B) == GROUP_SZ_B)));
}

//MARK: - - 退市整理
BOOL isSHSZ_TSZL(id<SKStock> stock) {
    return isSH_TSZL(stock) || isSZ_TSZL(stock);
}

BOOL isSH_TSZL(id<SKStock> stock) {
    return ((stock.exchange == E_STATION_0_SH) && ((stock.category & GROUP_SH_Z) == GROUP_SH_Z));
}

BOOL isSZ_TSZL(id<SKStock> stock) {
    return ((stock.exchange == E_STATION_1_SZ) && ((stock.category & GROUP_SZ_Z) == GROUP_SZ_Z));
}

//MARK: - - 中概股
BOOL isZGG(id<SKStock> stock) {
    return ((stock.exchange == E_STATION_9_US) || stock.exchange/1000 == E_STATION_9_US);
}

//MARK: - - 外汇
BOOL isForeignExchange(id<SKStock> stock) {
    return stock.exchange == E_STATION_11_WH;
}

//MARK: - - 人民币牌价
BOOL isRMB_PJ(id<SKStock> stock) {
    return stock.exchange == E_STATION_11_RMB;
}

//MARK: - - 国内板块
BOOL isInlandBK(id<SKStock> stock) {
    return stock.exchange == E_STATION_2_BK;
}

//MARK: - - 风险警示
BOOL isST(id<SKStock> stock) {
    return (((stock.exchange == E_STATION_0_SH) && ((stock.category & GROUP_SH_ST) == GROUP_SH_ST)) ||
            ((stock.exchange == E_STATION_1_SZ) && ((stock.category & GROUP_SZ_ST) == GROUP_SZ_ST)));
}
