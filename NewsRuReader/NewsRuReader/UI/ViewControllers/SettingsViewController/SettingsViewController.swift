//
//  SettingsViewController.swift
//  NewsRuReader
//
//  Created by Rost on 31.08.2018.
//  Copyright © 2018 Rost Gress. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var settingsTableView: UITableView!

    var showControlTitles: [String]     = []
    var refreshControlTitles: [String]  = []
    var categoriesArray: [Category]     = []
    
    
    /// ---> View life cycle <--- ///
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTableDataSource()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

