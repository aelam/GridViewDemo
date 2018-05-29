//
//  SKStockColorConfiguration.m
//  SKStockStone
//
//  Created by ryan on 08/11/2017.
//

#import "SKStockColorConfiguration.h"

@implementation SKStockColorConfiguration

static SKStockColorConfiguration *_configuration = nil;

+ (void)setSharedConfiguration:(SKStockColorConfiguration *)configuration {
    _configuration = configuration;
}

+ (instancetype)sharedConfiguration {
    if (_configuration) {
        return _configuration;
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _configuration = [[SKStockColorConfiguration alloc] init];
    });
    return _configuration;
}

- (UIColor *)raiseColor {
    return nil;
}

- (UIColor *)fallColor {
    return nil;
}

- (UIColor *)equalColor {
    return nil;
}

- (UIColor *)stockNameColor {
    return nil;
}

- (UIColor *)stockCodeColor {
    return nil;
}

- (UIColor *)defaultTextColor {
    return nil;
}

- (UIColor *)amountColor {
    return nil;
}


- (UIColor *)volumeColor {
    return nil;
}

- (UIColor *)turnoverRatioColor {
    return nil;
}

- (UIColor *)quantityRelativeRatioColor {
    return nil;
}


@end


UIColor *PriceColor(float price) {
    if (price > 0) {
        return [[SKStockColorConfiguration sharedConfiguration] raiseColor];
    } else if (price < 0) {
        return [[SKStockColorConfiguration sharedConfiguration] fallColor];
    } else {
        return [[SKStockColorConfiguration sharedConfiguration] equalColor];
    }
}

