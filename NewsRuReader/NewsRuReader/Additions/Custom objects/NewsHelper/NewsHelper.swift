//
//  NewsHelper.swift
//  NewsRuReader
//
//  Created by Rost on 04.09.2018.
//  Copyright © 2018 Rost Gress. All rights reserved.
//

import Foundation


class NewsHelper {
    
    static func getShowNewsInterval() -> Int {
        let savedIntervalIndex = UserDefaults.standard.integer(forKey: showInterval)
        
        switch savedIntervalIndex {
            case ShowIntervals.LastNews.rawValue:
                return 1800
            case ShowIntervals.HourlyNews.rawValue:
                return 3600
            case ShowIntervals.DaylyNews.rawValue:
                return 86400
            default:
                break
        }
        
        return 0
    }
    
    static func calcNewsDateDifference(from start: Date) -> NSInteger {
        if let endDate = NewsHelper.getCurrentDate() as? Date {
            let calendar = NSCalendar.current
            let unitFlags = Set<Calendar.Component>([.second])
            let dateComponents = calendar.dateComponents(unitFlags, from: start,  to: endDate)
            
            if let seconds = dateComponents.second {
                return seconds
            }
        }
        
        return 0
    }
    
    static func getCurrentDate() -> AnyObject? {
        let today = Date.getStringFromDate(Date())
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        if let timeStamp = dateFormatter.date(from: today) {
            return timeStamp as AnyObject
        }
        
        return nil
    }
}
