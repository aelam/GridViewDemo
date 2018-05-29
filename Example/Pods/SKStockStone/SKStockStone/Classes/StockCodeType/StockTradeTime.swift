//
//  StockTradeTime.swift
//  SKStockStone
//
//  Created by Allen on 23/02/2018.
//

import Foundation
import NSDate_Additions

/// 刷新行情数据
public protocol StockRefreshable {
    /// 行情刷新
    func refreshData()
}

/// -------
public struct StockTradeTime {
    
    static var componentFlag: Set<Calendar.Component> = [.year, .day, .month, .weekday, .hour, .minute, .second, .timeZone]
    
    //TODO: 时间部分待处理，做成外面可以配置
    public static func tradeTime(code: UInt) -> [Int]? {
        // 港股
        if Stock_isHK(code) {
            return [915, 1215, 1300, 1516]
        } else if Stock_isGZQH(code) || Stock_isTF(code) || Stock_isT(code) || Stock_isIH(code) || Stock_isIC(code) {
            return [915, 1200, 1300, 1515]
        } else if Stock_isQQZS(code) || Stock_isWPQH(code) {
            return nil
        } else {
            return [915, 1130, 1300, 1505]
        }
    }
    
    public static func isClosed(code: UInt, currentDate date: Date = Date()) -> (closed: Bool, fireDate: Date?) {
        
        var calendar = NSDate.currentCalendar() //Calendar(identifier: .gregorian)
        if let timeZone = TimeZone(abbreviation: "GMT+8") {
            calendar!.timeZone = timeZone
        }
        var dateComponents = calendar!.dateComponents(componentFlag, from: date)
        
        guard let timeSet = tradeTime(code: code) else {
            return (true, nil)
        }
        
        let currentTime = dateComponents.hour! * 100 + dateComponents.minute!
        // 判断timer.fireDate的开盘时间，以及是否收盘，节假日不开盘没考虑
        // 周末或者是下午收盘时间及之后，把fireDate设置成第二天开盘时间
        if 1 == dateComponents.weekday! || 7 == dateComponents.weekday! || currentTime >= timeSet.last! {
            dateComponents.hour = timeSet.first! / 100
            dateComponents.minute = timeSet.first! % 100
            dateComponents.second = 0
            let fireDate = (calendar!.date(from: dateComponents)! as NSDate) .addingDays(1)
            return (true, fireDate)
        } else if currentTime >= timeSet[2] { // 下午开盘中
            return (false, nil)
        } else if currentTime > timeSet[1] { // 中午收盘中
            dateComponents.hour = timeSet[2] / 100;
            dateComponents.minute = timeSet[2] % 100;
            dateComponents.second = 0
            let fireDate = calendar!.date(from: dateComponents)
            return (true, fireDate)
        } else if currentTime >= timeSet.first! { // 上午集合竞价后
            return (false, nil)
        } else { // 上午未集合竞价前
            dateComponents.hour = timeSet.first! / 100;
            dateComponents.minute = timeSet.first! % 100;
            let fireDate = calendar!.date(from: dateComponents)
            return (true, fireDate) //timeSet.first
        }
    }
}
