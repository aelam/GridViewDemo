//
//  SKStockGenre.h
//  Pods
//
//  Created by flora on 17/2/28.
//
//

#import <Foundation/Foundation.h>
#import "SKStock.h"

///MARK: - - 国内指数
BOOL isIndexInland(id<SKStock> stock);

///MARK: - - Index
BOOL isInlandIndex(id<SKStock> stock);


///MARK: - - Fund
BOOL isFund(id<SKStock> stock);
BOOL isFundA(id<SKStock> stock);    /// 分级A
BOOL isFundB(id<SKStock> stock);    /// 分级B
BOOL isFundLOF(id<SKStock> stock);  /// LOF
BOOL isFundETF(id<SKStock> stock);  /// ETF:
BOOL isFundCEF(id<SKStock> stock);  /// CEF: Closed End Fund 封闭基金
BOOL isFundOEF(id<SKStock> stock);  /// OEF: Open End Fund   开放基金

///MARK: - - Bond
BOOL isBond(id<SKStock> stock);             // 包含下面三个
BOOL isBondRepurchase(id<SKStock> stock);   // 上证深圳回购
BOOL isBondConvertible(id<SKStock> stock);  // 可转债
BOOL isBondSHSZ(id<SKStock> stock);         // 上证深证债券


///MARK: - - 期权
BOOL isOption(id<SKStock> stock);

///MARK: - - 股指期货
BOOL isGZQH(id<SKStock> stock);

///MARK: - - HK
BOOL isHKIndex(id<SKStock> stock);
BOOL isHKZB(id<SKStock> stock);    // 香港主板
BOOL isHK(id<SKStock> stock);      // 不包括HKIndex

///MARK: - - 三板 新三板
BOOL isXSB(id<SKStock> stock);
BOOL isSB(id<SKStock> stock); //深市-股转系统-两网及退市（三板）

BOOL isSHSZ_SB(id<SKStock> stock) __deprecated;  //深市-股转系统-两网及退市（三板）


///MARK: - - 所有A股
BOOL isSHSZ_A(id<SKStock> stock);
BOOL isSHSZ_B(id<SKStock> stock);

//MARK: - - 所有B股
BOOL isSHSZ_B(id<SKStock> stock);

//MARK: - - 退市整理
BOOL isSHSZ_TSZL(id<SKStock> stock);
BOOL isSH_TSZL(id<SKStock> stock);
BOOL isSZ_TSZL(id<SKStock> stock);

//MARK: - - 风险警示
BOOL isST(id<SKStock> stock);

//MARK: - - 中概股
BOOL isZGG(id<SKStock> stock);

///================================================================================
///MARK: - - 全球
BOOL isGlobal(id<SKStock> stock); // 人民币, 外汇, 国际商品

///MARK: - - 国际商品期货
BOOL isGlobalProductFuture(id<SKStock> stock); // 国际商品期货

///MARK: - -  国际指数
BOOL isGlobalIndex(id<SKStock> stock);

//MARK: - - 外汇
BOOL isForeignExchange(id<SKStock> stock);

//MARK: - - 人民币牌价
BOOL isRMB_PJ(id<SKStock> stock);

//MARK: - - 国内板块
BOOL isInlandBK(id<SKStock> stock);

///================================================================================
