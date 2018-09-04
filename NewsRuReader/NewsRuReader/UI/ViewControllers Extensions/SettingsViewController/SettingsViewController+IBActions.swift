//
//  SettingsViewController+IBActions.swift
//  NewsRuReader
//
//  Created by Rost on 03.09.2018.
//  Copyright © 2018 Rost Gress. All rights reserved.
//

import Foundation
import UIKit


extension SettingsViewController {
    
    
    /// ---> SegmentedControl action <--- ///
    
    @IBAction func changeInterval(_ sender: UISegmentedControl) {
        var notificationName = ""

        switch sender.tag {
            case SettingsSections.ShowInterval.rawValue:
                UserDefaults.standard.set(sender.selectedSegmentIndex, forKey: showInterval)
                notificationName = showTimeDidChanged

            case SettingsSections.RefreshInterval.rawValue:
                UserDefaults.standard.set(sender.selectedSegmentIndex, forKey: refreshInterval)
                notificationName = refreshTimeDidChanged
            
            default:
                break
        }
        
        UserDefaults.standard.synchronize()
        
        NotificationCenter.default.post(name: Notification.Name(notificationName), object: nil)
    }
}
