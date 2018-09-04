//
//  CategoryHelper.swift
//  NewsRuReader
//
//  Created by Rost on 03.09.2018.
//  Copyright © 2018 Rost Gress. All rights reserved.
//

import Foundation


class CategoryHelper {
    
    
    /// ---> Getter for curent category title <--- ///
    
    static func getCurrentCategoryTitle() -> String? {
        if let sortedCategories = Category.createSortedCategories() {
            let savedCategory    = UserDefaults.standard.integer(forKey: showCategory)
            let selectedCategory = sortedCategories[savedCategory]
            
            if let category = selectedCategory.category {
                return category
            }
        }
        
        return nil
    }
}
