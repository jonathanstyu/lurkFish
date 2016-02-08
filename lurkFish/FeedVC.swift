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
import Whisper

class FeedViewController: UIViewController, ASTableViewDataSource, ASTableViewDelegate {
    var type: String!
    var threadTable: ASTableView!
    var threadArray: [Thread]
    var dataSource: FeedItemManager!
    let downloadingMessage = Message(title: "Downloading Stories ...", textColor: UIColor.whiteColor(), backgroundColor: UIColor.flatYellowColorDark(), images: nil)
    
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
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hidesNavigationBarHairline = true
        self.title = "Hot"
        view.backgroundColor = UIColor.flatWhiteColor()
        
        setUpTable()
        downloadRedditData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            threadTable.frame = CGRectMake(view.frame.width * 0.05, 0, view.frame.width * 0.9, view.frame.height)
            threadTable.showsVerticalScrollIndicator = false
        } else {
            threadTable.frame = self.view.bounds
        }
    }
    
}