//
//  MoreViewController.swift
//  englishspanish
//
//  Created by Tran Huu Tam on 2/12/16.
//  Copyright © 2016 Tran Huu Tam. All rights reserved.
//

import UIKit
//import RFAboutView_Swift
//import FBSDKLoginKit
//import FBSDKShareKit

class MoreViewController: UIViewController {

    // Mark: UI's elements
    @IBOutlet weak var rateImageView: UIImageView!
    @IBOutlet weak var feedbackImageView: UIImageView!
    @IBOutlet weak var aboutImageView: UIImageView!
    @IBOutlet weak var shareImageView: UIImageView!
    
    
    // Mark: Application's life cirlce
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Mark: class's private methods
    private func initialize() {
        rateImageView.setFAIconWithName(FAType.FAStarHalfEmpty, textColor: UIColor.grayColor())
        feedbackImageView.setFAIconWithName(FAType.FAThumbsUp, textColor: UIColor.grayColor())
        aboutImageView.setFAIconWithName(FAType.FAInfoCircle, textColor: UIColor.grayColor())
        shareImageView.setFAIconWithName(FAType.FAFacebookOfficial, textColor: UIColor.grayColor())
    }
    
    // MARK: Button actions
    @IBAction func rateAppButtonAction(sender: AnyObject) {
//        UIApplication.sharedApplication().openURL(NSURL(string: kAppStoreRateLink)!)
    }
    
    @IBAction func feedbackButtonAction(sender: AnyObject) {
//        UIApplication.sharedApplication().openURL(NSURL(string: kAppStoreRateLink)!)
    }

    @IBAction func shareButtonAction(sender: AnyObject) {
//        if let _ = FBSDKAccessToken.currentAccessToken() {
//            let content = FBSDKShareLinkContent()
//            content.contentURL = NSURL(string: kHttpLinkAppStore)
//            content.contentTitle = "This app is really cool."
//            FBSDKShareDialog.showFromViewController(self, withContent: content, delegate: self)
//        }
//        else {
//            let login = FBSDKLoginManager()
//            login.logInWithReadPermissions(FACEBOOK_PERMISSIONS, fromViewController: self, handler: { (result, error) -> Void in
//                if result.isCancelled {
//                  FBSDKLoginManager().logOut()
//                } else {
//                    // To do
//                    if let er = error {
//                        print(er.description)
//                    }
//                    else {
//                        self.shareButtonAction(sender)
//                    }
//                }
//            })
//        }
    }
    
    @IBAction func aboutButtonAction(sender: AnyObject) {
//        let aboutNav = UINavigationController()
//        let aboutView = RFAboutViewController(appName: nil, appVersion: nil, appBuild: nil, copyrightHolderName: "BenjaminSoft, Inc.", contactEmail: "info.thesimplestudio@gmail.com", contactEmailTitle: "info.thesimplestudio@gmail.com", websiteURL: NSURL(string: "http://benjaminsoft.herokuapp.com"), websiteURLTitle: "http://benjaminsoft.herokuapp.com", pubYear: nil)
//        
//        aboutView.headerBackgroundColor = .blackColor()
//        aboutView.headerTextColor = .whiteColor()
//        aboutView.blurStyle = .Dark
//        aboutView.backgroundColor = Utility.mainRedColor()
////        aboutView.headerBackgroundImage = UIImage(named: "about_header_bg.jpg")
//
//        // Add an additional button:
//        aboutView.addAdditionalButton("Privacy Policy", content: "Take a look at our policy at \n http://benjaminsoft.herokuapp.com")
//                // Add the aboutView to the NavigationController:
//        aboutNav.setViewControllers([aboutView], animated: false)
//        // Present the navigation controller:
//        self.presentViewController(aboutNav, animated: true, completion: nil)
    }
    
    // Mark: FBSDKSharingDelegate's methods
//    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject : AnyObject]!) {
//        print("didCompleteWithResults")
//    }
//    
//    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
//        print(error.description)
//    }
//    
//    func sharerDidCancel(sharer: FBSDKSharing!) {
//        print("sharerDidCancel")
//    }
}

