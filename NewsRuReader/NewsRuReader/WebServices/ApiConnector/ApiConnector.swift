//
//  ApiConnector.swift
//  NewsRuReader
//
//  Created by Rost on 01.09.2018.
//  Copyright © 2018 Rost Gress. All rights reserved.
//

import Foundation
import SWXMLHash
import AERecord


class ApiConnector {
    
    
    /// ---> Shared Instance <--- ///
    
    static let shared : ApiConnector = {
        let instance = ApiConnector()
        
        return instance
    } ()
    
    
    /// ---> Function for load data from API <--- ///
    
    func loadNews(by url: String, completion: ((_ response: AnyObject) -> Void)?) {
        
        guard let resultUrl = URL(string: url) else {
            print("Error: cannot create URL")
            return
        }
        
        let urlRequest = URLRequest(url: resultUrl)

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else {
                print(error ?? "Unknown error")
                return
            }

            let parsedXml = SWXMLHash.parse(data)
            if parsedXml.element?.children != nil {
                DispatchQueue.main.async {
                    XMLMapper().saveObjects(by: parsedXml)
                
                    AERecord.saveContextAndWait()
                    completion!(true as AnyObject)
                }
            } else {
                completion!(false as AnyObject)
            }
        })
        
        task.resume()
    }
}
