//
//  NewsViewController+IBActions.swift
//  NewsRuReader
//
//  Created by Rost on 02.09.2018.
//  Copyright © 2018 Rost Gress. All rights reserved.
//

import Foundation
import UIKit


extension NewsViewController {
    
    
    /// ---> SegmentedControl selector <--- ///
    
    @IBAction func changeMode(_ sender: UISegmentedControl) {
        showTableMode = sender.selectedSegmentIndex
        
        self.newsTableView.reloadData()
    }
}

