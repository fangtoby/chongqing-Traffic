//
//  NSDate+Extension.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/23.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    /// 时间戳转日期
    ///
    /// - Parameter timeInterval: 时间戳
    /// - Returns: 结果
    static func timeString(timeInterval: TimeInterval) -> String{
        //如果服务端返回的时间戳精确到毫秒，需要除以1000,否则不需要
        let date = getNowDateFromatAnDate(Date(timeIntervalSince1970: timeInterval/1000))
        
        let formatter = DateFormatter()
        if date.isToday() {
            //是今天
            formatter.dateFormat = "今天HH:mm"
            return formatter.string(from: date)
            
        }else if date.isYesterday(){
            //是昨天
            formatter.dateFormat = "昨天HH:mm"
            return formatter.string(from: date)
        }else if date.isSameWeek(){
            //是同一周
            let week = date.weekdayStringFromDate()
            formatter.dateFormat = "\(week)HH:mm"
            return formatter.string(from: date)
        }else{
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            return formatter.string(from: date)
        }
    }
    
    func isToday() -> Bool {
        let calendar = Calendar.current
        //当前时间
        let nowComponents = calendar.dateComponents([.day,.month,.year], from: Date() )
        //self
        let selfComponents = calendar.dateComponents([.day,.month,.year], from: self as Date)
        
        return (selfComponents.year == nowComponents.year) && (selfComponents.month == nowComponents.month) && (selfComponents.day == nowComponents.day)
    }
    
    func isYesterday() -> Bool {
        let calendar = Calendar.current
        //当前时间
        let nowComponents = calendar.dateComponents([.day], from: Date() )
        //self
        let selfComponents = calendar.dateComponents([.day], from: self as Date)
        let cmps = calendar.dateComponents([.day], from: selfComponents, to: nowComponents)
        return cmps.day == 1
        
    }
    
    func isSameWeek() -> Bool {
        let calendar = Calendar.current
        //当前时间
        let nowComponents = calendar.dateComponents([.day,.month,.year], from: Date() )
        //self
        let selfComponents = calendar.dateComponents([.weekday,.month,.year], from: self as Date)
        
        return (selfComponents.year == nowComponents.year) && (selfComponents.month == nowComponents.month) && (selfComponents.weekday == nowComponents.weekday)
    }
    
    func weekdayStringFromDate() -> String {
        let weekdays:NSArray = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
        var calendar = Calendar.init(identifier: .gregorian)
        let timeZone = TimeZone.init(identifier: "Asia/Shanghai")
        calendar.timeZone = timeZone!
        let theComponents = calendar.dateComponents([.weekday], from: self as Date)
        return weekdays.object(at: theComponents.weekday!) as! String
    }
    
    
    /// 根据本地时区转换
    static func getNowDateFromatAnDate(_ anyDate: Date?) -> Date {
        //设置源日期时区
        let sourceTimeZone = NSTimeZone(abbreviation: "UTC")
        //或GMT
        //设置转换后的目标日期时区
        let destinationTimeZone = NSTimeZone.local as NSTimeZone
        //得到源日期与世界标准时间的偏移量
        var sourceGMTOffset: Int? = nil
        if let aDate = anyDate {
            sourceGMTOffset = sourceTimeZone?.secondsFromGMT(for: aDate)
        }
        //目标日期与本地时区的偏移量
        var destinationGMTOffset: Int? = nil
        if let aDate = anyDate {
            destinationGMTOffset = destinationTimeZone.secondsFromGMT(for: aDate)
        }
        //得到时间偏移量的差值
        let interval = TimeInterval((destinationGMTOffset ?? 0) - (sourceGMTOffset ?? 0))
        //转为现在时间
        var destinationDateNow: Date? = nil
        if let aDate = anyDate {
            destinationDateNow = Date(timeInterval: interval, since: aDate)
        }
        return destinationDateNow!
    }
}
