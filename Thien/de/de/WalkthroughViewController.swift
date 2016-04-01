//
//  WalkthroughViewController.swift
//  de
//
//  Created by The Simple Studio on 31/3/16.
//  Copyright © 2016 The Simple Studio. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - Data model for each walkthrough screen
    var index = 0               // the current page index
    var headerText = ""
    var imageName = ""
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return .LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.text = headerText
        imageView.image = UIImage(named: imageName)
        pageControl.currentPage = index
        
        // customize the next and start button
        startButton.hidden = (index == 3) ? false : true
        nextButton.hidden = (index == 3) ? true : false
        startButton.layer.cornerRadius = 5.0
        startButton.layer.masksToBounds = true
    }
    
    @IBAction func startAction(sender: AnyObject) {
        // we're good with the walk through.
        // also, don't forget to update userdefaults
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(true, forKey: "DisplayedWalkthrough")
        
        // but wait, how did you know that we displayed the PageVC via a modal segue? We didn't! Let's display the PageVC before doing anything else
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func nextAction(sender: AnyObject) {
        let pageViewController = self.parentViewController as! PageViewController
        pageViewController.nextPageWithIndex(index)

    }
}
