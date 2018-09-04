//
//  XMLMapper.swift
//  NewsRuReader
//
//  Created by Rost on 02.09.2018.
//  Copyright © 2018 Rost Gress. All rights reserved.
//

import Foundation
import SWXMLHash


class XMLMapper {
    
    var newsItem: [String: String] = [:]
    
    
    /// ---> Save parsed XML items <--- ///
    
    func saveObjects(by xml: XMLIndexer) {
        for child in xml.children {
            if child.element!.name == "item" {
                if self.newsItem.values.count > 0 {
                    if let author = self.newsItem["author"] {
                        if author == "Газета.Ru" {
                            if self.newsItem["enclosure"] != nil {
                                NewsObject.saveNewsObject(from: self.newsItem)
                            }
                        }
                    } else {
                        if self.newsItem["description"] != nil && self.newsItem["enclosure"] != nil {
                            NewsObject.saveNewsObject(from: self.newsItem)
                        }
                    }
                }
                
                self.newsItem = [:]
            }
            
            if child.element!.name == "link" {
                self.newsItem["link"] = child.element!.text
            }
            
            if child.element!.name == "title" {
                self.newsItem["title"] = child.element!.text
            }
            
            if child.element!.name == "author" {
                self.newsItem["author"] = child.element!.text
            }
            
            if child.element!.name == "category" {
                self.newsItem["category"] = child.element!.text
            }
            
            if child.element!.name == "description" {
                self.newsItem["description"] = child.element!.text
            }
            
            if child.element!.name == "pubDate" {
                self.newsItem["pubDate"] = child.element!.text
            }
            
            if child.element!.name == "enclosure" {
                if let url = child.element!.allAttributes["url"] {
                    self.newsItem["enclosure"] = url.text
                }
            }

            saveObjects(by: child)
        }
    }
}
