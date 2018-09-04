//
//  NewsViewController+Observers.swift
//  NewsRuReader
//
//  Created by Rost on 03.09.2018.
//  Copyright © 2018 Rost Gress. All rights reserved.
//

import Foundation
import UIKit


extension NewsViewController {
    
    
    /// ---> Observers setter <--- ///
    
    func addSettingsObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changedCategory),
                                                name: Notification.Name(categoryDidChanged),
                                                object: nil)
        
        NotificationCenter.default.addObserver(self,
                                                selector: #selector(changedShowTime),
                                                name: Notification.Name(showTimeDidChanged),
                                                object: nil)
        
        NotificationCenter.default.addObserver(self,
                                                selector: #selector(changedRefreshTime),
                                                name: Notification.Name(refreshTimeDidChanged),
                                                object: nil)
    }
        
    
    /// ---> Observers selectors <--- ///
        
    @objc func changedShowTime(_ notification: Notification) {
        getLocalNews()
    }
    
    @objc func changedRefreshTime(_ notification: Notification) {
        refreshTimer.invalidate()
        setRefreshNewsTimer()
    }
        
    @objc func changedCategory(_ notification: Notification) {
        getLocalNews()
    }
}
