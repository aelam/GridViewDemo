//
//  StringFormat.h
//  Pods
//
//  Created by ryan on 31/12/2016.
//
//
// TODO 移到UI层次

#import <Foundation/Foundation.h>

// 保留1位小数
NSString *TenthString(NSDecimalNumber *number);

// 保留两位小数
NSString *HundredthString(NSDecimalNumber *number);

// 保留三位小数
NSString *ThousandthString(NSDecimalNumber *number);

// 保留四位小数
NSString *TenThousandthString(NSDecimalNumber *number);

// 百分数保留两位小数
NSString *HundredthPercentageString(NSDecimalNumber *number);

// 百分数保留三位小数
NSString *ThousandthPercentageString(NSDecimalNumber *number);

// 显示亿 保留两位小数/万 保留一位小数
NSString *BigNumberString(float number);

// 显示亿/万 保留2位小数
NSString *BigNumberString2(float number);

NSString *ABRatioString(float number);

NSString *formatDateString(NSString *number);

NSString *BigNumberVOLString(float number);

NSString *BigNumberVOLString2(float number);
//时间戳格式化
NSString *FormatTimestampString(NSString *number,NSString *formatter);
