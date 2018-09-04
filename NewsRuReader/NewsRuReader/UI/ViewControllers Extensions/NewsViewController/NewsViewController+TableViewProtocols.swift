//
//  NewsViewController+TableViewProtocols.swift
//  NewsRuReader
//
//  Created by Rost on 02.09.2018.
//  Copyright © 2018 Rost Gress. All rights reserved.
//

import Foundation
import UIKit


extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell
        
        let newsObject: NewsObject = self.dataArray[indexPath.row]
        
        if let image = newsObject.image_link {
            if !isOnline {
                if cell?.logoImageView.image == nil {
                    cell?.logoImageView.image = UIImage(named: "emptyImage")
                }
            }
            
            cell?.logoImageView.downloadImage(by: image)
        }
        
        if let title = newsObject.news_title {
            cell?.titleLabel.text = title
        }
        
        if let author = newsObject.news_author {
            cell?.sourceLabel.text = author
        }
        
        cell?.isReadImageView.isHidden = true
        
        let isRead = newsObject.is_read
        if isRead {
            cell?.isReadImageView.isHidden  = false
            cell?.isReadImageView.image     = UIImage(named: "readIcon")
        }

        switch showTableMode {
            case NewsShowModes.UsualMode.rawValue:
                cell?.dateLabel.isHidden        = true
                cell?.descriptionLabel.isHidden = true
            case NewsShowModes.ExtendedMode.rawValue:
                cell?.dateLabel.isHidden        = false
                cell?.descriptionLabel.isHidden = false
                
                if let description = newsObject.news_description {
                    cell?.descriptionLabel.text = description
                }
            
                if let date = newsObject.pub_date {
                    cell?.dateLabel.text = Date.getStringFromDate(date as Date)
                }

            default:
                break
        }

        return cell ?? NewsCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch showTableMode {
            case NewsShowModes.UsualMode.rawValue:
                return 90.0
            case NewsShowModes.ExtendedMode.rawValue:
                return 140.0
            default:
                break
        }
        
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
