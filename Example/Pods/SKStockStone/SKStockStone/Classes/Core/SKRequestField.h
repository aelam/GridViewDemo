//
//  SKRequestField.h
//  Pods
//
//  Created by ryan on 29/12/2016.
//
//

#import <Foundation/Foundation.h>

@interface SKRequestField : NSObject

+ (NSDictionary <NSNumber*, NSString *> *)fieldsIdNameMapping;
+ (NSDictionary <NSString*, NSNumber *> *)fieldsNameIdMapping;
+ (NSArray *)getRequireFieldsWithSectionType:(NSInteger)sectionType;
+ (NSArray <NSString *> *)getShowTitlesByFieldIds:(NSArray *)fieldIds;
+ (NSArray <NSNumber *> *)getShowFieldIDsByFieldIds:(NSArray *)fieldIds;


@end

// TODO: Not finished
@interface SKRequestField (GeneralFields)

// 一级页面类
+ (NSArray <NSNumber *>*)HS;       // 1000 // 沪深
+ (NSArray <NSNumber *>*)BK;       // 1001 // 板块
+ (NSArray <NSNumber *>*)HK;       // 1002 // 港股
+ (NSArray <NSNumber *>*)Global;   // 1003 // 全球
+ (NSArray <NSNumber *>*)More;     // 1004 // 更多

+ (NSArray <NSNumber *>*)HS_HSL;   // 1005 // 沪深_换手率
+ (NSArray <NSNumber *>*)HS_JLC;   // 1008 // 沪深_资金净流出

// 专题
+ (NSArray <NSNumber *>*)HGT;      // 2005 // 沪港通
+ (NSArray <NSNumber *>*)SGT;      // 2006 // 深港通

// 新三板
+ (NSArray <NSNumber *>*)XSB_CX;   // 3000 // 新三板_创新
+ (NSArray <NSNumber *>*)XSB_JC;   // 3001 // 深港通
+ (NSArray <NSNumber *>*)XSB_ZS;   // 3002 // 新三板_做市
+ (NSArray <NSNumber *>*)XSB_XY;   // 3003 // 新三板_协议
+ (NSArray <NSNumber *>*)XSB_YXG;  // 3004,// 新三板_优先股

//+ (NSArray <NSNumber *>*)XSB_CX_CJE;   // 3000 // 新三板_创新



// 更多-期指
+ (NSArray <NSNumber *>*)QZ_GZQH;    // 6000, // 更多_期指_股指期货
+ (NSArray <NSNumber *>*)QZ_GPQH;    // 6001, // 更多_期指_股票期权
+ (NSArray <NSNumber *>*)Fund_FJA;   // 6010, // 更多_基金_分级A
+ (NSArray <NSNumber *>*)Fund_FJB;   // 6011, // 更多_基金_分级B
+ (NSArray <NSNumber *>*)Fund_ETF;   // 6012, // 更多_基金_ETF
+ (NSArray <NSNumber *>*)Fund_LOF;   // 6013, // 更多_基金_LOF
+ (NSArray <NSNumber *>*)Fund_SHFB;// 6014, // 更多_基金_上证封闭基金
+ (NSArray <NSNumber *>*)Fund_SZFB;// 6014, // 更多_基金_深证封闭基金
+ (NSArray <NSNumber *>*)Fund_All;   // 6015, // 更多_基金_全部基金

// 沪深
+ (NSArray <NSNumber *>*)SH_A;   // 6020,      // 更多_沪深_上证A股
+ (NSArray <NSNumber *>*)SH_B;   // 6021,      // 更多_沪深_上证B股
+ (NSArray <NSNumber *>*)SZ_A;   // 6022,      // 更多_沪深_深证A股
+ (NSArray <NSNumber *>*)SZ_B;   // 6023,      // 更多_沪深_深证B股
+ (NSArray <NSNumber *>*)ZXB;    // 6024,      // 更多_沪深_中小板
+ (NSArray <NSNumber *>*)CYB;    // 6025,      // 更多_沪深_创业板
+ (NSArray <NSNumber *>*)RiskTips;// 6026,      // 更多_沪深_风险提示
+ (NSArray <NSNumber *>*)TSZG;   // 6027,      // 更多_沪深_退市整改

// 美股
+ (NSArray <NSNumber *>*)US_ZGG;    // 6030,       // 更多_美股_中概股

// 债券
+ (NSArray <NSNumber *>*)Bond_SHHG;   // 6040,       // 更多_债券_上证回购
+ (NSArray <NSNumber *>*)Bond_SZHG;   // 6041,       // 更多_债券_深证回购
+ (NSArray <NSNumber *>*)Bond_KZZ ;   // 6042,       // 更多_债券_可转债
+ (NSArray <NSNumber *>*)Bond_SHZQ;   // 6043,       // 更多_债券_上证债券
+ (NSArray <NSNumber *>*)Bond_SZZQ;   // 6044,       // 更多_债券_深证债券
+ (NSArray <NSNumber *>*)Bond_ALLZQ;// 6045,       // 更多_债券_全部债权

@end
