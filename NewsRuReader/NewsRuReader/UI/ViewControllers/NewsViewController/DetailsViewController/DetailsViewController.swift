//
//  DetailsViewController.swift
//  NewsRuReader
//
//  Created by Rost on 02.09.2018.
//  Copyright © 2018 Rost Gress. All rights reserved.
//

import Foundation
import UIKit
import WebKit


class DetailsViewController: UIViewController {
    @IBOutlet weak var postWebView: WKWebView!
    @IBOutlet weak var offlineImageView: UIImageView!
    @IBOutlet weak var offlineTextView: UITextView!
    
    var selectedNews: NewsObject!
    var offlineImage: UIImage!
    var isOnline: Bool!
    
    
    /// ---> View life cycle <--- ///
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true

        if let title = selectedNews.news_title {
            self.title = title
        }
        
        if isOnline {
            postWebView.isHidden        = false
            offlineImageView.isHidden   = true
            offlineTextView.isHidden    = true
            
            if let link = selectedNews.news_link {
                if let url = URL(string: link) {
                    postWebView.load(URLRequest(url: url))
                    postWebView.allowsBackForwardNavigationGestures = true
                }
            }
        } else {
            postWebView.isHidden        = true
            offlineImageView.isHidden   = false
            offlineTextView.isHidden    = false
            
            if let image = offlineImage {
                offlineImageView.image   = image
            }
            
            if let description = selectedNews.news_description {
                offlineTextView.text    = description
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

