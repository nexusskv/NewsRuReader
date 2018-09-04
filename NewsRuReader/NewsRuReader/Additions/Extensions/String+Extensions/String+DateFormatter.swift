//
//  String+DateFormatter.swift
//  NewsRuReader
//
//  Created by Rost on 02.09.2018.
//  Copyright © 2018 Rost Gress. All rights reserved.
//

import Foundation


extension String {
    
    static func getDateFromString(_ source: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        
        guard let timeStamp = dateFormatter.date(from: source) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }

        return timeStamp
    }
}
