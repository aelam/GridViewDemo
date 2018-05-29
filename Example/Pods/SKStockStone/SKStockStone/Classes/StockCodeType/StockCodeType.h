//
// Created by ryan on 01/02/2018.
//

// !!经典版判断股票类型使用, 勿删
#import <Foundation/Foundation.h>

extern BOOL Stock_isIH(NSUInteger code);

extern BOOL Stock_isIC(NSUInteger code);

extern BOOL Stock_isTF(NSUInteger code);

extern BOOL Stock_isT(NSUInteger code);

extern BOOL Stock_isGZQH(NSUInteger code); // 股指期货
extern BOOL Stock_isGZ(NSUInteger code);
extern BOOL Stock_isBK(NSUInteger code);   // 板块
extern BOOL Stock_isQQZS(NSUInteger code); // 全球指数
extern BOOL Stock_isGNQH(NSUInteger code); // 国内期货
extern BOOL Stock_isSZZQ(NSUInteger code); // 深证证券
extern BOOL Stock_isWH(NSUInteger code);   // 外汇
extern BOOL Stock_isHK(NSUInteger code);   //
extern BOOL Stock_isAH(NSUInteger code);

extern BOOL Stock_isZS(NSUInteger code);  //指数
extern BOOL Stock_isZQ(NSUInteger code);  //债券
extern BOOL Stock_isGC(NSUInteger code);  //GC 
extern BOOL Stock_isQZ(NSUInteger code);

extern BOOL Stock_isWPQH(NSUInteger code); // 外盘期货

extern BOOL Stock_isFund(NSUInteger code);

extern BOOL Stock_isOpenFund(NSUInteger code);

extern BOOL Stock_isSHB(NSUInteger code);

extern BOOL Stock_isSHStock(NSUInteger code);

extern BOOL Stock_isSHSZB(NSUInteger code);

extern BOOL Stock_isSHSZA(NSUInteger code);

extern BOOL Stock_isXSB(NSUInteger code);//新三板
extern BOOL Stock_isIndex(NSUInteger code); //指数

//extern BOOL Stock_isSH(NSUInteger code);

//extern BOOL Stock_isSZ(NSUInteger code);

//是否是期货
extern BOOL Stock_isQH(NSUInteger code);

//是否是国债期货
extern BOOL Stock_isGuoZhaiQH(NSUInteger code);

//2004xxx 三级概念 44
extern BOOL Stock_isBKForXanJiGaiNian(NSUInteger code);

//2005xxx 小行业   46
extern BOOL Stock_isBKForSmallIndustries(NSUInteger code);

//2006xxx 小概念   45
extern BOOL Stock_isBKForXiaoGaiNian(NSUInteger code);
