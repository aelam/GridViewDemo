//
// Created by ryan on 07/02/2018.
//

#import "YMStock+Utils.h"
#import "StockCodeType.h"

// TODO: 类型判断检查
NSInteger RawVOLValueTranformFactor(NSUInteger stockId) {
    //* 成交量类型（成交量，持仓量等）
    //* 单位精确到股，各品种股手转换倍率如下
    //* 股票：1手=100股
    //* 债券：1手=10股
    //* 期货：1手=1股（合约）
    if (Stock_isZQ(stockId)) {
        return 10;
    } else if (Stock_isGZQH(stockId) || Stock_isQH(stockId)) {
        return 1;
    } else {
        return 100;
    }
}
