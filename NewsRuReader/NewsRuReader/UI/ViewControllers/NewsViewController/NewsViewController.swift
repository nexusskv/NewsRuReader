//
//  NewsViewController.swift
//  NewsRuReader
//
//  Created by Rost on 31.08.2018.
//  Copyright © 2018 Rost Gress. All rights reserved.
//

import UIKit
import ReachabilitySwift


class NewsViewController: UIViewController {
    @IBOutlet weak var newsTableView: UITableView!
    
    var dataArray: [NewsObject] = []
    var showTableMode: Int      = 0
    let reachability            = Reachability()!
    var isOnline: Bool          = false
    var refreshTimer: Timer!
    
    
    /// ---> View life cycle <--- ///
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.newsTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: ReachabilityChangedNotification, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("Сould not start reachability notifier")
        }
        
        setNewsPageCategoryTitle()
                
        setRefreshNewsTimer()
        
        addSettingsObservers()
    }
    
    deinit {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self)
        
        refreshTimer.invalidate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
