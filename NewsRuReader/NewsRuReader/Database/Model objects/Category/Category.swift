//
//  Category+CoreDataClass.swift
//  
//
//  Created by Rost on 03.09.2018.
//
//

import Foundation
import CoreData
import AERecord


@objc(Category)
public class Category: NSManagedObject {
    @NSManaged public var category: String?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }
}


extension Category {
    
    
    /// ---> Save object <--- ///
    
    static func saveCategory(by source: String) {
        if !source.isEmpty {
            if let _ = self.create(by: source) {
                DispatchQueue.main.async {
                    AERecord.saveContextAndWait()
                }
            }
        }
    }
    
    
    /// ---> Constructor <--- ///
    
    static func create(by source: String) -> Category? {
        if let _ = Category.firstWithAttribute(attribute: "category", value: source as AnyObject) {
            return nil
        } else {
            return Category.createWithAttributes(attributes: ["category": source as AnyObject])
        }
    }
    
    
    /// ---> Constructor for sorted categories <--- ///
    
    static func createSortedCategories() -> [Category]? {
        let categoriesPredicate = NSPredicate(format: "category != %@", allNews)
        
        if let categories = Category.allWithPredicate(predicate: categoriesPredicate) as? [Category] {
            var categoriesArray: [Category] = categories.sorted(by: { $0.category?.compare($1.category!) == .orderedAscending })
            
            if let allNewsCategory: Category = Category.firstWithAttribute(attribute: "category", value: allNews as AnyObject) {
                categoriesArray.insert(allNewsCategory, at: 0)
            }
            
            return categoriesArray
        }
        
        return nil
    }

}
