//
//  StockCodeNameUtils.m
//  SKStockStone
//
//  Created by ryan on 02/03/2018.
//

#import "StockCodeNameUtils.h"
#import "StockCodeType.h"

@implementation StockCodeNameUtils

+ (NSString *)prettyCodeName:(NSUInteger)code {
    if (Stock_isXSB(code)) {
        return [NSString stringWithFormat:@"%lu", code % 1000000];
    } else if (Stock_isIC(code)) {
        return [NSString stringWithFormat:@"IC%lu", code % 10000];
    } else if (Stock_isIH(code)) {
        return [NSString stringWithFormat:@"IH%04lu", code % 10000];
    } else if (Stock_isGZQH(code)) {
        return [NSString stringWithFormat:@"IF%04lu", code % 10000];
    } else if (Stock_isTF(code)) {
        return [NSString stringWithFormat:@"TF%04lu", code % 10000];
    } else if (Stock_isT(code)) {
        return [NSString stringWithFormat:@"T%04lu", code % 10000];
    } else if (Stock_isBK(code)) {
        return [NSString stringWithFormat:@"BK%04lu", code % 10000];
    } else if (Stock_isAH(code)) {
        return [NSString stringWithFormat:@"H%04lu", code % 10000];
    } else if (Stock_isHK(code)) {
        return [NSString stringWithFormat:@"HK%04lu", code % 10000];
    } else if (code / 1000000 == 9) {
        return [NSString stringWithFormat:@"%06lu", code % 1000000];
    } else if (code / 1000000 == 1) {
        return [NSString stringWithFormat:@"SZ%06lu", code % 1000000];
    } else if (Stock_isGNQH(code) || Stock_isWH(code) || Stock_isQQZS(code) || code / 1000000 == 8) {//期货 外汇
        NSAssert(1 == 1, @"检查这里的格式化");
        return [NSString stringWithFormat:@"%06lu", code % 1000000];
    } else {
        return [NSString stringWithFormat:@"SH%06lu", code % 1000000];
    }

}

+ (NSString *)plainCodeName:(NSUInteger)code {
    if (Stock_isXSB(code)) {
        return [NSString stringWithFormat:@"%06lu", code % 1000000];
    } else if (Stock_isIC(code)) {
        return [NSString stringWithFormat:@"IC%04lu", code % 10000];
    } else if (Stock_isIH(code)) {
        return [NSString stringWithFormat:@"IH%04lu", code % 10000];
    } else if (Stock_isGZQH(code)) {
        return [NSString stringWithFormat:@"IF%04lu", code % 10000];
    } else if (Stock_isTF(code)) {
        return [NSString stringWithFormat:@"TF%04lu", code % 10000];
    } else if (Stock_isT(code)) {
        return [NSString stringWithFormat:@"T%04lu", code % 10000];
    } else if (Stock_isBK(code)) {
        return [NSString stringWithFormat:@"BK%04lu", code % 10000];
    } else if (Stock_isAH(code)) {
        return [NSString stringWithFormat:@"H%04lu", code % 10000];
    } else if (Stock_isHK(code)) {
        return [NSString stringWithFormat:@"HK%04lu", code % 10000];
    } else if (code / 1000000 == 9) {
        return [NSString stringWithFormat:@"%06lu", code % 1000000];
    } else if (code / 1000000 == 1) {
        return [NSString stringWithFormat:@"%06lu", code % 1000000];
    } else if (Stock_isGNQH(code) || Stock_isWH(code) || Stock_isQQZS(code) || code / 1000000 == 8) {//期货 外汇
        NSAssert(false, @"检查这里的格式化");
        return [NSString stringWithFormat:@"%06lu", code % 1000000];
    } else {
        return [NSString stringWithFormat:@"%06lu", code % 1000000];
    }
}


@end
