//
//  SKStockColorConfiguration.h
//  SKStockStone
//
//  Created by ryan on 08/11/2017.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol SKStockColorInterface <NSObject>

@required
- (UIColor *)raiseColor;
- (UIColor *)fallColor;
- (UIColor *)equalColor;

// 益盟股票中这三个颜色一样
// 经典版中有不同的颜色
- (UIColor *)stockNameColor;
- (UIColor *)stockCodeColor;
- (UIColor *)defaultTextColor;

// 益盟股票中这两个颜色一样
// 经典版中有不同的颜色
- (UIColor *)amountColor;
- (UIColor *)volumeColor;

// 换手率, 5日换手率颜色
- (UIColor *)turnoverRatioColor;

// 益盟股票为Default, 经典版为黄色
- (UIColor *)quantityRelativeRatioColor; // 量比


@end

@interface SKStockColorConfiguration : NSObject <SKStockColorInterface>

+ (void)setSharedConfiguration:(SKStockColorConfiguration *)configuration;
+ (instancetype)sharedConfiguration;

@end

UIColor *PriceColor(float price);
