//
//  NewsViewController+Functions.swift
//  NewsRuReader
//
//  Created by Rost on 02.09.2018.
//  Copyright © 2018 Rost Gress. All rights reserved.
//

import Foundation
import UIKit
import ReachabilitySwift
import AERecord


extension NewsViewController {

    
    /// ---> News page title setter <--- ///
    
    func setNewsPageCategoryTitle() {
        if let category = CategoryHelper.getCurrentCategoryTitle() {
            self.navigationController?.navigationBar.topItem?.title = category
        }
    }
    
    
    /// ---> News loader from server API <--- ///
    
    func loadNewsFromApi() {
        ApiConnector.shared.loadNews(by: gazetaUrl) { [weak self] (result) in
            ApiConnector.shared.loadNews(by: lentaUrl) { [weak self] (result) in
                DispatchQueue.main.async { [weak self] in
                    self?.setNewsPageCategoryTitle()
                    
                    self?.getLocalNews()
                }
            }
        }
    }
    
    
    /// ---> News loader from local database <--- ///
    
    func getLocalNews() {
        let savedCurrentCategory    = UserDefaults.standard.integer(forKey: showCategory)
        
        if savedCurrentCategory == 0 {
            if let news = NewsObject.all() {
                if news.count > 0 {
                    self.dataArray = news as! [NewsObject]
                    self.dataArray = self.dataArray.sorted(by: { $0.pub_date?.compare($1.pub_date! as Date) == .orderedDescending })
                }
            }
        } else {
            if let category = CategoryHelper.getCurrentCategoryTitle() {
                if let news = NewsObject.allWithAttribute(attribute: "category", value: category as AnyObject) {
                    if news.count > 0 {
                        self.dataArray = news as! [NewsObject]
                        self.dataArray = self.dataArray.sorted(by: { $0.pub_date?.compare($1.pub_date! as Date) == .orderedDescending })
                    }
                }
            }
        }

        if self.dataArray.count > 0 {
            let savedInterval = NewsHelper.getShowNewsInterval()
            
            if savedInterval > 0 {      // Filter news by show time interval from settings
                var newsSortedArray: [NewsObject] = []
                
                for newsObject in self.dataArray {
                    if let date = newsObject.pub_date {
                        let newsDateDifference = NewsHelper.calcNewsDateDifference(from: date as Date)

                        switch savedInterval {
                            case TimeInSeconds.HalfHourSeconds.rawValue: // 1800
                                if newsDateDifference > 0 && newsDateDifference <= TimeInSeconds.HalfHourSeconds.rawValue {
                                    newsSortedArray.append(newsObject)
                                }
                            case TimeInSeconds.HourSeconds.rawValue:    // 3600
                                if newsDateDifference > 0 && newsDateDifference <= TimeInSeconds.HourSeconds.rawValue {
                                    newsSortedArray.append(newsObject)
                                }
                            case TimeInSeconds.DaySeconds.rawValue:     // 86400
                                if newsDateDifference > 0 && newsDateDifference <= TimeInSeconds.DaySeconds.rawValue {
                                    newsSortedArray.append(newsObject)
                                }
                            default:
                                break
                        }
                    }
                }
                
                if newsSortedArray.count > 0 {
                    self.dataArray = newsSortedArray.sorted(by: { $0.pub_date?.compare($1.pub_date! as Date) == .orderedDescending })
                } else {
                    print("News dataSource is empty")
                    self.dataArray = []
                }
            }

            self.newsTableView.reloadData()
        }
    }
    
    
    /// ---> Refresh interval setter for timer <--- ///
    
    func setRefreshNewsTimer() {
        let savedSettingsInterval = UserDefaults.standard.integer(forKey: refreshInterval)
        
        var refreshTime: Double = 60.0
        switch savedSettingsInterval {
            case RefreshIntervals.FiveMinutes.rawValue:
                refreshTime = 300.0
            case RefreshIntervals.FithteenMinutes.rawValue:
                refreshTime = 900.0
            case RefreshIntervals.HalfHour.rawValue:
                refreshTime = 1800.0
            case RefreshIntervals.OneHour.rawValue:
                refreshTime = 3600.0
            default:
                break
        }
        
        refreshTimer = Timer.scheduledTimer(timeInterval: refreshTime,
                                            target: self,
                                            selector: #selector(refreshData),
                                            userInfo: nil,
                                            repeats: true)
    }
    
    
    /// ---> Refresh timer selector <--- ///
    
    @objc func refreshData() {
        if isOnline {
            loadNewsFromApi()
        }
    }
    
    
    /// ---> Internet connection checker <--- ///
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        
        switch reachability.currentReachabilityStatus {
            case .reachableViaWiFi, .reachableViaWWAN:
                print("Connection is available")
                isOnline = true
                loadNewsFromApi()
            case .notReachable:
                print("Connection is unavailable")
                isOnline = false
                DispatchQueue.main.async {
                    self.getLocalNews()
                }
        }
    }
}
