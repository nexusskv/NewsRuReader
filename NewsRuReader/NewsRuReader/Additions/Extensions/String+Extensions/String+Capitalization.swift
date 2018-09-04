//
//  String+Capitalization.swift
//  NewsRuReader
//
//  Created by Rost on 02.09.2018.
//  Copyright © 2018 Rost Gress. All rights reserved.
//

import Foundation


extension String {
    
    func uppercaseFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func uppercaseFirstLetter() {
        self = self.uppercaseFirstLetter()
    }
}
