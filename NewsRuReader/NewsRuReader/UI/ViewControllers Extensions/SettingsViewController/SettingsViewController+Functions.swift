//
//  SettingsViewController+Functions.swift
//  NewsRuReader
//
//  Created by Rost on 03.09.2018.
//  Copyright © 2018 Rost Gress. All rights reserved.
//

import Foundation
import UIKit


extension SettingsViewController {
    
    
    /// ---> SegmentedControl titles setter <--- ///
    
    func setTitles(_ titles: [String], for control: UISegmentedControl) {
        control.removeAllSegments()
        
        var index = 0
        for title in titles {
            control.insertSegment(withTitle: title, at: index, animated: false)
            
            index += 1
        }
    }
    
    
    /// ---> Table data source constructor <--- ///
    
    func createTableDataSource() {
        showControlTitles       = [freshTitle, byHourTitle, byTodayTitle, allTitle]
        refreshControlTitles    = [oneMin, fiveMin, fifteenMin, halfHour, oneHour]
        
        if let sortedCategories = Category.createSortedCategories() {
            categoriesArray = sortedCategories
        }
    }
}
