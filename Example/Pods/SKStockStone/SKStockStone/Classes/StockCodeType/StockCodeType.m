//
// Created by ryan on 01/02/2018.
//

#import "StockCodeType.h"

BOOL Stock_isIndex(NSUInteger nGoodsID) {
    return ((nGoodsID > 0 && nGoodsID < 9000)
            || nGoodsID / 100000 == 8
            || nGoodsID / 10000 == 139
            || nGoodsID == 5500001);
}

BOOL Stock_isQQZS(NSUInteger code) {
    //第七位是6的为全球指数
    NSUInteger n = code / 1000000;
    return (6 == n);
}

//国内期货
BOOL Stock_isGNQH(NSUInteger code) {
    //第七位是7的为国内期货（上海 大连 郑州）
    return (7 == code / 1000000);
}

//深证证券
BOOL Stock_isSZZQ(NSUInteger code) {
    //	return ( (code / 100000 == 11 || code / 10000 == 121 ||
    //              code / 10000 == 131 ) && code / 10000 != 139);
    return (code >= 1100000 && code < 1140000);
}

//上证证券
BOOL Stock_isSHZQ(NSUInteger code) {
    return (code > 9000 && code < 200000);
}

/////////////////////////////////////////////////////////////
//外汇
BOOL Stock_isWH(NSUInteger code) {
    //第七位是11的为外汇
    NSUInteger n = code / 1000000;
    return (11 == n);
}

//是否港股
BOOL Stock_isHK(NSUInteger code) {
    return (code / 1000000 == 3 || code / 1000000 == 5 || 5500001 == code);
}

BOOL Stock_isAH(NSUInteger code) {
    return (code / 1000000) == 3;
}

BOOL Stock_isZS(NSUInteger code) {
    return ((code > 0 && code < 9000) || code / 100000 == 8 || code / 10000 == 139 || code == 5500001);
}

//债券
BOOL Stock_isZQ(NSUInteger code) {
    //	return (Stock_isSHZQ(code) || Stock_isSZZQ(code));
    //此处代码是从ANDROID组复制过来的 服务器也没有此判定 不知道来源处！
    //    NSUInteger nVal = code / 10000;
    //    return ((code > 9000 && code < 299999)
    //            || (12 == nVal || 20 == nVal || 11 == nVal)
    //            || (111 == nVal || 112 == nVal || 110 == nVal || 108 == nVal || 113 == nVal));

    if (Stock_isIndex(code)) {
        return 0;
    } else if (code < 1000000l) {
        NSUInteger n6 = code / 100000;
        if (n6 < 3)
            return 1;
    } else {
        NSUInteger n4 = code / 10000;
        if (n4 >= 110 && n4 < 114)
            return 1;
    }
    return 0;
}

BOOL Stock_isGC(NSUInteger code) {
    return code >= 201000 && code <= 204999;
}

//权证
BOOL Stock_isQZ(NSUInteger code) {
    return (code / 10000 == 58 || code / 10000 == 103);
}

//外盘期货
BOOL Stock_isWPQH(NSUInteger code) {
    //第七位是8的为外盘期货
    return code / 1000000 == 8;
}

BOOL Stock_isFund(NSUInteger code) {
    return (code / 100000 == 5 && !Stock_isQZ(code)) || (code / 10000 >= 115 && code / 10000 <= 118) || (code / 1000000 == 9);
}

BOOL Stock_isOpenFund(NSUInteger code) {
    return (code >= 519000 && code <= 519999) &&
            (code >= 1150000 && code <= 1169999 && code / 1000 != 1159) &&
            (code / 100000 == 5 && code / 10000 != 58) && (code / 10000 >= 15 && code / 10000 <= 18);
}


BOOL Stock_isSHB(NSUInteger code) {
    return (code / 100000 == 9 || code / 100000 == 5 || (code / 10000 >= 115 &&
            code / 10000 <= 118) || code / 10000 == 103);
}

//#endif
////////////////////////////////////////////////////////
BOOL Stock_isSWZS(NSUInteger code) {
    return (code / 100000 == 28);
}

//中国概念
BOOL Stock_isZGZN(NSUInteger code) {
    //第七位是9, 10的为中国概念
    NSUInteger n = code / 1000000;
    return (9 == n) || (10 == n);
}

BOOL Stock_isSHStock(NSUInteger code) {
    return code / 100000 == 6;
}

BOOL Stock_isSHSZB(NSUInteger code) {
    return code / 100000 == 9 || code / 10000 == 120;
}

BOOL Stock_isSHSZA(NSUInteger code) {
    return code / 100000 == 6 || code / 10000 == 130 || code / 10000 == 100;
}

BOOL Stock_isXSB(NSUInteger code) {
    NSUInteger res = code / 10000;
    return 143 == res || 183 == res;
}

//是否是期货
BOOL Stock_isQH(NSUInteger code) {
    return Stock_isGZQH(code) || Stock_isTF(code) || Stock_isIC(code) || Stock_isIH(code);
}

// 期货包含国债期货,需注意
// 是否是国债期货
BOOL Stock_isGuoZhaiQH(NSUInteger code) {
    NSUInteger res = code / 10000;
    return (401 == res) || (res >= 431 && res <= 460);
}


BOOL Stock_isTF(NSUInteger code) {
    return (code / 10000 == 401);
}

BOOL Stock_isT(NSUInteger code) {
    return (code / 10000 == 431);
}

BOOL Stock_isIH(NSUInteger code) {
    return (code / 10000 == 402);
}

BOOL Stock_isIC(NSUInteger code) {
    return (code / 10000 == 403);
}

BOOL Stock_isGZQH(NSUInteger code) {
    return (code / 10000 == 400);
}

BOOL Stock_isGZ(NSUInteger code) {
    return (code / 1000000 == 4);
}

//板块
BOOL Stock_isBK(NSUInteger code) {
    return ((code / 1000 >= 2001 && code / 1000 <= 2006) || code == 959);
}

//2004xxx 三级概念 44
BOOL Stock_isBKForXanJiGaiNian(NSUInteger code) {
    return 2004 == (code / 1000);
}

//2005xxx 小行业   46
BOOL Stock_isBKForSmallIndustries(NSUInteger code) {
    return 2005 == (code / 1000);
}

//2006xxx 小概念   45
BOOL Stock_isBKForXiaoGaiNian(NSUInteger code) {
    return 2006 == (code / 1000);
}
