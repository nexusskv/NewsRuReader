//
//  SettingsViewController+TableViewProtocols.swift
//  NewsRuReader
//
//  Created by Rost on 03.09.2018.
//  Copyright © 2018 Rost Gress. All rights reserved.
//

import Foundation
import UIKit


extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsCell

        switch indexPath.section {
            case SettingsSections.ShowInterval.rawValue:
                if let control = cell?.intervalControl {
                    control.isHidden = false
                    control.tag      = indexPath.section
                    setTitles(showControlTitles, for: control)
                    
                    let savedInterval = UserDefaults.standard.integer(forKey: showInterval)
                    control.selectedSegmentIndex    = savedInterval
                }
            case SettingsSections.RefreshInterval.rawValue:
                if let control = cell?.intervalControl {
                    control.isHidden = false
                    control.tag      = indexPath.section
                    setTitles(refreshControlTitles, for: control)
                    
                    let savedInterval = UserDefaults.standard.integer(forKey: refreshInterval)
                    control.selectedSegmentIndex    = savedInterval
                }
            case SettingsSections.Categories.rawValue:
                cell?.categoryPickerView.isHidden = false
                
                cell?.categoryPickerView.reloadAllComponents()
                
                let savedCategory = UserDefaults.standard.integer(forKey: showCategory)
                cell?.categoryPickerView.selectRow(savedCategory, inComponent: 0, animated: false)
            default:
                break
        }
                
        return cell ?? SettingsCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case SettingsSections.ShowInterval.rawValue:
                return showIntervalTitle
            case SettingsSections.RefreshInterval.rawValue:
                return refreshIntervalTitle
            case SettingsSections.Categories.rawValue:
                return categoryNewsTitle
            default:
                break
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            case 0, 1:
                return 80.0
            case 2:
                return 250.0
            default:
                break
        }
        
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
}
