//
//  SKStock+VOL.m
//  Pods
//
//  Created by ryan on 10/05/2017.
//
//

#import "SKStock+Utils.h"
#import "SKStock.h"
#import "SKStockGenre.h"

NSInteger VOLValueTranformFactor(id<SKStock> stock) {
    //* 成交量类型（成交量，持仓量等）
    //* 单位精确到股，各品种股手转换倍率如下
    //* 股票：1手=100股
    //* 债券：1手=10股
    //* 期货：1手=1股（合约）
    if (isBond(stock)) {
        return 10;
    } else if (isGZQH(stock) || isGlobalProductFuture(stock)) {
        return 1;
    } else {
        return 100;
    }
}
