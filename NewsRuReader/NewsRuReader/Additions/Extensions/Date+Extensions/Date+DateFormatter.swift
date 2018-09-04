//
//  Date+DateFormatter.swift
//  NewsRuReader
//
//  Created by Rost on 02.09.2018.
//  Copyright © 2018 Rost Gress. All rights reserved.
//

import Foundation


extension Date {
    
    static func getStringFromDate(_ source: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        let timeStamp = dateFormatter.string(from: source)
        
        return timeStamp
    }

}
