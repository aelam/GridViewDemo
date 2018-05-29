//
//  StringFormat.m
//  Pods
//
//  Created by ryan on 31/12/2016.
//
//

#import "StringFormat.h"

static NSString *const kEmptyGoodsModelString = @"0";
static NSString *const kEmptyPercentageString = @"0%";

// 保留1位小数
NSString *TenthString(NSDecimalNumber *number) {
    NSString *retString;
    if ([number.stringValue isEqualToString:@"0"]) {
        retString = kEmptyGoodsModelString;
    } else {
        NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler
                                            decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                            scale:1
                                            raiseOnExactness:NO
                                            raiseOnOverflow:NO
                                            raiseOnUnderflow:NO
                                            raiseOnDivideByZero:YES];
        retString = [NSString stringWithFormat:@"%.1f", [[number decimalNumberByRoundingAccordingToBehavior:behavior] floatValue]];
    }
    return retString;
}


// 保留两位小数
NSString *HundredthString(NSDecimalNumber *number) {
    
    NSString *retString;
    if ([number.stringValue isEqualToString:@"0"]) {
        retString = kEmptyGoodsModelString;
    } else {
        NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler
                                            decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                            scale:2
                                            raiseOnExactness:NO
                                            raiseOnOverflow:NO
                                            raiseOnUnderflow:NO
                                            raiseOnDivideByZero:YES];
        retString = [NSString stringWithFormat:@"%.2f", [[number decimalNumberByRoundingAccordingToBehavior:behavior] floatValue]];
    }
    return retString;
}

// 保留三位小数
NSString *ThousandthString(NSDecimalNumber *number) {
    NSString *retString;
    if ([number.stringValue isEqualToString:@"0"]) {
        retString = kEmptyGoodsModelString;
    } else {
        NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler
                                            decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                            scale:3
                                            raiseOnExactness:NO
                                            raiseOnOverflow:NO
                                            raiseOnUnderflow:NO
                                            raiseOnDivideByZero:YES];
        retString = [NSString stringWithFormat:@"%.3f", [[number decimalNumberByRoundingAccordingToBehavior:behavior] floatValue]];
    }
    return retString;
}

// 保留四位小数
NSString *TenThousandthString(NSDecimalNumber *number) {
    NSString *retString;
    if ([number.stringValue isEqualToString:@"0"]) {
        retString = kEmptyGoodsModelString;
    } else {
        NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler
                                            decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                            scale:4
                                            raiseOnExactness:NO
                                            raiseOnOverflow:NO
                                            raiseOnUnderflow:NO
                                            raiseOnDivideByZero:YES];
        retString = [NSString stringWithFormat:@"%.4f", [[number decimalNumberByRoundingAccordingToBehavior:behavior] floatValue]];
    }
    return retString;
}

// 百分数保留两位小数
NSString *HundredthPercentageString(NSDecimalNumber *number) {
    NSString *retString;
    if ([number.stringValue isEqualToString:@"0"]) {
        retString = kEmptyPercentageString;
    } else {
        NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler
                                            decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                            scale:2
                                            raiseOnExactness:NO
                                            raiseOnOverflow:NO
                                            raiseOnUnderflow:NO
                                            raiseOnDivideByZero:YES];
        retString = [NSString stringWithFormat:@"%.2f%%", [[number decimalNumberByRoundingAccordingToBehavior:behavior] floatValue]];
    }
    return retString;
}

// 百分数保留三位小数
NSString *ThousandthPercentageString(NSDecimalNumber *number) {
    NSString *retString;
    if ([number.stringValue isEqualToString:@"0"]) {
        retString = kEmptyPercentageString;
    } else {
        NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler
                                            decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                            scale:3
                                            raiseOnExactness:NO
                                            raiseOnOverflow:NO
                                            raiseOnUnderflow:NO
                                            raiseOnDivideByZero:YES];
        retString = [NSString stringWithFormat:@"%.3f%%", [[number decimalNumberByRoundingAccordingToBehavior:behavior] floatValue]];
        
    }
    return retString;
}


NSString *BigNumberString(float number) {
    NSString *unit = @"";
    float value = number;
    if (number > 100000000 || number < -100000000) {
        unit = @"亿";
        value = number / 100000000.0;
    } else if(number > 10000 || number < -10000) {
        unit = @"万";
        value = number / 10000.0;
    } else {
        return [NSString stringWithFormat:@"%.1f", number];
    }
    if ((value >= 0 && value < 10) || (value > -10 && value <= 0)) { //小数点前1位，保留3位小数
        return [NSString stringWithFormat:@"%.3f%@", value,unit];
    }
    else if ((value >= 10 && value < 100) || (value > -100 && value <= -10)) { //小数点前2位，保留2位小数
        return [NSString stringWithFormat:@"%.2f%@", value,unit];
    }
    else if ((value >= 100 && value < 1000) || (value > -1000 && value <= -100)) { //小数点前3位，保留1位小数
        return [NSString stringWithFormat:@"%.1f%@", value,unit];
    }
    else if (value >= 1000 || value <= -1000) { //小数点前4位，保留0位小数
        return [NSString stringWithFormat:@"%.0f%@", value,unit];
    } else {
        return [NSString stringWithFormat:@"%.0f", value];
    }
}

NSString *BigNumberString2(float number) {
    NSString *unit = @"";
    float value = number;
    if (number > 100000000 || number < -100000000) {
        unit = @"亿";
        value = number / 100000000.0;
    } else if(number > 10000 || number < -10000) {
        unit = @"万";
        value = number / 10000.0;
    } else {
        return [NSString stringWithFormat:@"%.2f", number];
    }
    if ((value >= 0 && value < 10) || (value > -10 && value <= 0)) { //小数点前1位，保留3位小数
        return [NSString stringWithFormat:@"%.3f%@", value,unit];
    }
    else if ((value >= 10 && value < 100) || (value > -100 && value <= -10)) { //小数点前2位，保留2位小数
        return [NSString stringWithFormat:@"%.2f%@", value,unit];
    }
    else if ((value >= 100 && value < 1000) || (value > -1000 && value <= -100)) { //小数点前3位，保留1位小数
        return [NSString stringWithFormat:@"%.1f%@", value,unit];
    }
    else if (value >= 1000 || value <= -1000) { //小数点前大于等于4位，保留0位小数
        return [NSString stringWithFormat:@"%.0f%@", value, unit];
    } else {
        return [NSString stringWithFormat:@"%.0f", value];
    }
}

NSString *BigNumberVOLString(float number) {
    NSString *unit = @"";
    float value = number;
    if (number > 100000000 || number < -100000000) {
        unit = @"亿";
        value = number / 100000000.0;
    } else if(number > 10000 || number < -10000) {
        unit = @"万";
        value = number / 10000.0;
    } else {
        return [NSString stringWithFormat:@"%.0f", number];
    }
    if ((value >= 0 && value < 10) || (value > -10 && value <= 0)) { //小数点前1位，保留3位小数
        return [NSString stringWithFormat:@"%.3f%@", value,unit];
    }
    else if ((value >= 10 && value < 100) || (value > -100 && value <= -10)) { //小数点前2位，保留2位小数
        return [NSString stringWithFormat:@"%.2f%@", value,unit];
    }
    else if ((value >= 100 && value < 1000) || (value > -1000 && value <= -100)) { //小数点前3位，保留1位小数
        return [NSString stringWithFormat:@"%.1f%@", value,unit];
    }
    else if (value >= 1000 || value <= -1000) { //小数点前大于等于4位，保留0位小数
        return [NSString stringWithFormat:@"%.0f%@", value,unit];
    }
    else {
        return [NSString stringWithFormat:@"%.0f", value];
    }
}

NSString *BigNumberVOLString2(float number) {
    NSString *unit = @"";
    float value = number;
    if (number > 100000000 || number < -100000000) {
        unit = @"亿";
        value = number / 100000000.0;
    } else if(number > 10000 || number < -10000) {
        unit = @"万";
        value = number / 10000.0;
    } else {
        return [NSString stringWithFormat:@"%.0f", number];
    }
    if ((value >= 0 && value < 10) || (value > -10 && value <= 0)) { //小数点前1位，保留2位小数
        return [NSString stringWithFormat:@"%.2f%@", value,unit];
    }
    else if ((value >= 10 && value < 100) || (value > -100 && value <= -10)) { //小数点前2位，保留1位小数
        return [NSString stringWithFormat:@"%.1f%@", value,unit];
    }
    else if ((value >= 100 && value < 1000) || (value > -1000 && value <= -100)) { //小数点前3位，保留0位小数
        return [NSString stringWithFormat:@"%.0f%@", value,unit];
    }
    else if (value >= 1000 || value <= -1000) { //小数点前大于等于4位，保留0位小数
        return [NSString stringWithFormat:@"%.0f%@", value,unit];
    }
    else {
        return [NSString stringWithFormat:@"%.0f", value];
    }
}

NSString *ABRatioString(float number) {
    NSString *retString;
    if (number == 0) {
        retString = kEmptyGoodsModelString;
    } else {
        retString = [NSString stringWithFormat:@"%.0f", number];
        retString = [NSString stringWithFormat:@"%@:%@",[retString substringToIndex:1],[retString substringFromIndex:1]];
    }
    return retString;
}

NSString *formatDateString(NSString *number) {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [formatter dateFromString:number];
    NSDateFormatter *toFormatter = [[NSDateFormatter alloc]init];
    [toFormatter setDateFormat:@"yyyy-MM-dd"];
    return [toFormatter stringFromDate:date];
}

NSString *FormatTimestampString(NSString *number,NSString *format) {
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[number integerValue]/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:confromTimesp];
}
