//
//  CustomDate.swift
//  RRRExtensionDemo
//
//  Created by 任敬 on 2019/8/29.
//  Copyright © 2019 任敬. All rights reserved.
//

import UIKit



public extension Date {
    
    enum Formate {
        case yMdHms
        case yMd
        case Hms
        case Md
        case Hm
    }
    /// string -> date
    ///
    /// - Parameters:
    ///   - string: string
    ///   - format: Formate
    /// - Returns: date
    func dateFromString(string:String, _ format:Formate?) -> Date? {
        let dateFormat = DateFormatter.init()
        if let _ = format {
            var formatStr :String!
            switch format! {
            case .yMdHms:
                formatStr = "yyyy-MM-dd HH:mm:ss"
            case .yMd:
                formatStr = "yyyy-MM-dd"
            case .Hms:
                formatStr = "HH:mm:ss"
            case .Md:
                formatStr = "MM-dd"
            case .Hm:
                formatStr = "HH:mm"
            }
            
            dateFormat.dateFormat = formatStr
        }else{
            dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }
        return dateFormat.date(from: string)
    }

    /// date -> string
    ///
    /// - Parameter format: Formate
    /// - Returns: string
    func stringFromDate(_ format:Formate?) -> String {
        let dateFormat = DateFormatter.init()
        if let _ = format {
            var formatStr :String!
            switch format! {
            case .yMdHms:
                formatStr = "yyyy-MM-dd HH:mm:ss"
            case .yMd:
                formatStr = "yyyy-MM-dd"
            case .Hms:
                formatStr = "HH:mm:ss"
            case .Md:
                formatStr = "MM-dd"
            case .Hm:
                formatStr = "HH:mm"
            }
            dateFormat.dateFormat = formatStr
        }else{
            dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }
        return dateFormat.string(from: self)
    }
    /// 和当前时间比较
    ///
    /// - Parameter time: 比较的时间
    /// - Returns:
    func compareTime(time:String) -> String {
        let dateFormat = DateFormatter.init()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let expireDate = dateFormat.date(from: time)
        if let _ = expireDate {
            let nowDate = Date()
            let calendar = Calendar.current
            let unit : Set<Calendar.Component> = [Calendar.Component.year,Calendar.Component.month,Calendar.Component.day]
            
            let dateCom = calendar.dateComponents(unit, from: nowDate, to: expireDate!)
            
            if let _ = dateCom.year{
                dateFormat.dateFormat = "yyyy-MM-dd"
                return dateFormat.string(from: expireDate!)
            }
            if let _ = dateCom.month{
                dateFormat.dateFormat = "MM-dd"
                return dateFormat.string(from: expireDate!)
            }
            if let _ = dateCom.day{
                dateFormat.dateFormat = "MM-dd HH:mm"
                return dateFormat.string(from: expireDate!)
            }
            dateFormat.dateFormat = "HH:mm"
            return dateFormat.string(from: expireDate!)
        }else{
            return time
        }
    }
    /**
     获取时间戳 毫秒级
     */
    func timestamp() -> String {
       let  time = self.timeIntervalSince1970 * 1000
        return String(time)
    }
    
    /// 根据时间戳获取时间 毫秒级
    ///
    /// - Parameter tims: 毫秒级时间戳
    /// - Returns: 时间
    func dateFromTimestamp(tims:Double) -> Date {
        let interval = tims / 1000
        
        return Date.init(timeIntervalSince1970: interval)
    }
    
    

}

public extension Date {
    
    func year() -> Int {
        return Calendar.current.component(Calendar.Component.year, from: self)
    }
    
    func month() -> Int {
        return Calendar.current.component(Calendar.Component.month, from: self)
    }
    
    func day() -> Int {
        return Calendar.current.component(Calendar.Component.day, from: self)
    }
    
    func weekDay() -> Int {
        return Calendar.current.component(Calendar.Component.weekday, from: self)
    }
    /// 今年第几周
    ///
    /// - Returns: Int
    func weekOfYear() -> Int {
        return Calendar.current.component(Calendar.Component.weekOfYear, from: self)
    }
    /// 本月第几周
    ///
    /// - Returns: Int
    func weekOfMonth() -> Int {
        return Calendar.current.component(Calendar.Component.weekOfMonth, from: self)
    }
    /// 当月有几天
    ///
    /// - Returns: Int
    func daysOfMonth() -> Int {
        return Calendar(identifier: Calendar.Identifier.gregorian).range(of: Calendar.Component.day, in: Calendar.Component.month, for: self)?.count ?? 0
    }
    
    func isToday() -> Bool {
        if fabs(self.timeIntervalSinceNow) >= 3600 * 24 {
            return false
        }else{
            return Date().day() == self.day()
        }
    }
    
    
    
}
