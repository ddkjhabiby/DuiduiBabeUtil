//
//  TimeUtil.swift
//  Bobo
//
//  Created by ddkj007 on 2019/10/21.
//  Copyright © 2019 duiud. All rights reserved.
//

import Foundation

public class TimeUtil {
    public static var sessionFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        formatter.locale = Locale(identifier: Language.currentLanguage().rawValue)
        return formatter
    }()
    
    public static var messageDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: Language.currentLanguage().rawValue)
        return formatter
    }()
    
    public static var messageTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: Language.currentLanguage().rawValue)
        return formatter
    }()
    
    
    
    public static func compareCurrentTimeDay(date: Date) -> String {
        var timeInterval = date.timeIntervalSinceNow
        timeInterval = -timeInterval
        let count = max(1, Int(timeInterval/60/60/24))
        return "\(count) 天前"
    }
    
    public static func timeFormater(totalSecond: Int) -> String {
        let second = totalSecond%60
        let minute = (totalSecond/60)%60
        let hour = totalSecond/60/60
        if hour > 0 {
            return String(format: "%02d:%02d:%02d", hour, minute, second)
        }
        return String(format: "%02d:%02d", minute, second)
    }
}
