//
//  NewsObject+CoreDataClass.swift
//  NewsRuReader
//
//  Created by Rost on 01.09.2018.
//  Copyright © 2018 Rost Gress. All rights reserved.
//
//

import Foundation
import CoreData
import AERecord


@objc(NewsObject)
public class NewsObject: NSManagedObject {
    @NSManaged public var image_link: String?
    @NSManaged public var news_author: String?
    @NSManaged public var news_description: String?
    @NSManaged public var news_link: String?
    @NSManaged public var news_title: String?
    @NSManaged public var pub_date: NSDate?
    @NSManaged public var category: String?
    @NSManaged public var is_read: Bool
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsObject> {
        return NSFetchRequest<NewsObject>(entityName: "NewsObject")
    }
}

extension NewsObject {

    
    /// ---> Save object <--- ///

    static func saveNewsObject(from item: [String: String]) {
        var newsObject: NewsObject? = nil
        
        if let link = item["link"] {
            newsObject = self.createOrGet(by: link)
        }
        
        if let title = item["title"] {
            newsObject?.news_title = title
        }
        
        if let author = item["author"] {
            newsObject?.news_author = author
        } else {
            if let link = item["link"] {
                if let url = URL(string: link) {
                    if let domain = url.host {
                        newsObject?.news_author = domain.uppercaseFirstLetter()
                    }
                }
            }
        }
        
        if let description = item["description"] {
            newsObject?.news_description = description
        }
        
        if let enclosure = item["enclosure"] {
            newsObject?.image_link = enclosure
        }
        
        if let category = item["category"] {
            newsObject?.category = category
        } else {
            if let link = item["link"] {
                let linkArray           = link.components(separatedBy: "/")
                if linkArray.count > 0 {
                    let category            = linkArray[3]
                    newsObject?.category = category.uppercaseFirstLetter()
                }
            }
        }
        
        if let category = newsObject?.category {
            Category.saveCategory(by: category)
        }
        
        if let date = item["pubDate"] {
            let convertedDate = String.getDateFromString(date)
            newsObject?.pub_date = convertedDate as NSDate
        }
    }
    
    
    /// ---> Creator and Getter <--- ///
    
    static func createOrGet(by link: String) -> NewsObject? {
        if let object = NewsObject.firstWithAttribute(attribute: "news_link", value: link as AnyObject) {
            return object
        } else {
            return NewsObject.createWithAttributes(attributes: ["news_link": link as AnyObject])
        }
    }
    
    
    /// ---> Read mark property setter <--- ///
    
    static func setIsReadNewsObject(by link: String) {
        if let object = NewsObject.firstWithAttribute(attribute: "news_link", value: link as AnyObject) {
            object.is_read = true
            
            AERecord.saveContextAndWait()
        }
    }
}
