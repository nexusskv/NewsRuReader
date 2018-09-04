//
//  NewsViewController+Segues.swift
//  NewsRuReader
//
//  Created by Rost on 02.09.2018.
//  Copyright © 2018 Rost Gress. All rights reserved.
//

import Foundation
import UIKit


extension NewsViewController {

    
    /// ---> News view controller segue <--- ///
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails" {
            if let detailsVC: DetailsViewController = segue.destination as? DetailsViewController {
                if let selectedIndex = self.newsTableView.indexPathForSelectedRow {
                
                    let selectedNews        = self.dataArray[(selectedIndex.row)]
                    selectedNews.is_read    = true
                    
                    self.dataArray[selectedIndex.row] = selectedNews
                    self.newsTableView.reloadRows(at: [selectedIndex], with: .none)

                    detailsVC.selectedNews  = selectedNews
                    detailsVC.isOnline  = isOnline
                    
                    if !isOnline {
                        if let cell = self.newsTableView.cellForRow(at: selectedIndex) as? NewsCell {
                            if (cell.logoImageView.image != nil) {
                                detailsVC.offlineImage = cell.logoImageView.image
                            }
                        }
                    }
                    
                    if let link = selectedNews.news_link {
                        NewsObject.setIsReadNewsObject(by: link)
                    }
                }
            }
        }
    }
}

