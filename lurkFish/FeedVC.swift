//
//  FeedVC.swift
//  lurkFish
//
//  Created by Jonathan Yu on 12/27/15.
//  Copyright © 2015 Jonathan Yu. All rights reserved.
//

import UIKit
import ChameleonFramework
import AsyncDisplayKit
import Alamofire

class FeedViewController: UIViewController, ASTableViewDataSource, ASTableViewDelegate {
    var type: String!
    var threadTable: ASTableView!
    var threadArray: [Thread]
    var dataSource: FeedDataItems!
    
    convenience init() {
        self.init(url: "feed")
    }
    
    init(url: String) {
        threadArray = []
        super.init(nibName: nil, bundle: nil)
        self.type = url
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hidesNavigationBarHairline = true
        self.title = "Hot"
        
        setUpTable()
        downloadRedditData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        threadTable.frame = self.view.bounds
    }
    
}