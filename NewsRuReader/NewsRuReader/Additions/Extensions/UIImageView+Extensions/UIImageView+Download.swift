//
//  UIImageView+Download.swift
//  NewsRuReader
//
//  Created by Rost on 02.09.2018.
//  Copyright © 2018 Rost Gress. All rights reserved.
//

import Foundation
import UIKit


/// ---> Extension for download image asyncronously <--- ///

public extension UIImageView {
    func downloadImage(by link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        
        guard let url = URL(string: link) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
        }.resume()
    }
}

