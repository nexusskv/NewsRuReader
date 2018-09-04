//
//  SettingsViewController+PickerViewProtocols.swift
//  NewsRuReader
//
//  Created by Rost on 03.09.2018.
//  Copyright © 2018 Rost Gress. All rights reserved.
//

import Foundation
import UIKit


extension SettingsViewController:  UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoriesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var categoryTitle = ""
        
        let categoryObject = categoriesArray[row]
        if let category = categoryObject.category {
            categoryTitle = category
        }
        
        return categoryTitle
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaults.standard.set(row, forKey: showCategory)
        UserDefaults.standard.synchronize()
        
        NotificationCenter.default.post(name: Notification.Name(categoryDidChanged), object: nil)
    }

}
