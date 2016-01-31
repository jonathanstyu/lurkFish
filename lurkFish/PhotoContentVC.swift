//
//  PhotoContentVC.swift
//  lurkFish
//
//  Created by Jonathan Yu on 1/31/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit

class PhotoContentViewController: ContentViewController {
    var imageViewer: UIImageView?
    var swipeDismiss: UISwipeGestureRecognizer?
    
    init(threadVM: ThreadViewModel, image: UIImage) {
        super.init(threadVM: threadVM)
        self.imageViewer?.image = image
        swipeDismiss = UISwipeGestureRecognizer(target: self, action: "swipeDownDismiss:")
        swipeDismiss!.direction = UISwipeGestureRecognizerDirection.Down
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageViewer?.frame = self.view.frame
        view.addSubview(imageViewer!)
        imageViewer!.addGestureRecognizer(swipeDismiss!)
    }
    
    func swipeDownDismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}