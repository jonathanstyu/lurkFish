//
//  WeblinkContentVC.swift
//  lurkFish
//
//  Created by Jonathan Yu on 1/31/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WeblinkContentViewController: ContentViewController {
    var webView: WKWebView?
    
    override init(threadVM: ThreadViewModel) {
        super.init(threadVM: threadVM)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webView = WKWebView(frame: view.frame)
        let url = NSURL(string: threadVM!.url!)
        let req = NSURLRequest(URL: url!)
        webView.loadRequest(req)
        view.addSubview(webView)
    }
    
}