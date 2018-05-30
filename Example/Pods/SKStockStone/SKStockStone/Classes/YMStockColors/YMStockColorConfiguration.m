//
//  YMStockColorConfiguration.m
//  SKStockStone
//
//  Created by ryan on 08/11/2017.
//

#import "YMStockColorConfiguration.h"
#import "SKStockColorConfiguration.h"

#if !defined(RGBA)
#define RGBA(r,g,b,a) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]
#define RGB(r,g,b)     RGBA(r,g,b,1)
#endif

@implementation YMStockColorConfiguration

+ (void)load {
    [SKStockColorConfiguration setSharedConfiguration:[YMStockColorConfiguration new]];
}

- (UIColor *)raiseColor {
    return [UIColor redColor] ; //RGB(0xff, 0x60, 0x60);
}

- (UIColor *)fallColor {
    return [UIColor greenColor]; //RGB(0x00, 0xff, 0x60);
}

- (UIColor *)equalColor {
    return [UIColor whiteColor];
}

- (UIColor *)stockNameColor {
    return [UIColor whiteColor]; //RGB(125, 205, 243);
}

- (UIColor *)stockCodeColor {
    return RGB(0x00, 0xff, 0xff);
}

- (UIColor *)defaultTextColor {
    return [UIColor whiteColor];
}

- (UIColor *)amountColor {
    return RGB(0x00, 0xff, 0xff);
}

- (UIColor *)volumeColor {
    return RGB(0xff, 0xff, 0x00);
}

- (UIColor *)turnoverRatioColor {
    return [UIColor yellowColor];
}

- (UIColor *)quantityRelativeRatioColor {
    return [UIColor yellowColor];
}



@end

