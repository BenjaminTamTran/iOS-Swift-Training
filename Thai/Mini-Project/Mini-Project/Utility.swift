//
//  Utility.swift
//  Anymex
//
//  Created by Sonivy Development on 2/25/16.
//  Copyright © 2016 Sonivy Development. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds

class Utility {
    
    class func borderRadiusView(radius : CGFloat, view : UIView) {
        view.layer.cornerRadius = radius
        view.layer.masksToBounds = true
    }
    
    class func showAlertWithMessage(message: String) {
        dispatch_async(dispatch_get_main_queue(),{
           let alert = UIAlertView(title: "Info", message: message, delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
        })
    }
    
    
    class func showAlertWithMessageOKCancel(message: String,title: String,sender: UIViewController, doneAction: ( () -> Void )?, cancelAction: ( () -> Void )? ) {
        dispatch_async(dispatch_get_main_queue(), {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
                if let action = doneAction {
                    action()
                }
            }
            alert.addAction(okAction)
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) {
                action -> Void in
                if let action = cancelAction {
                    action()
                }
            }
            alert.addAction(cancelAction)
            sender.presentViewController(alert, animated: true, completion: { () in  })
        })
    }
    
    
    class func navigateToVC(from : UIViewController, vc : UIViewController, direction : String = kCATransitionFromRight) {
        
        vc.view.frame = from.view.frame
        from.addChildViewController(vc)
        from.view.addSubview(vc.view)
        // Move the view move in fromvare right
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.3)
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = direction
        vc.view.layer .addAnimation(transition, forKey: kCATransition)
        vc.didMoveToParentViewController(from)
        CATransaction.commit()
    }
    
    class func openAuthenticatedFlow() {
        let authenticationSB = UIStoryboard(name: "Authenticated", bundle: NSBundle.mainBundle())
        let initVC = authenticationSB.instantiateInitialViewController()
        appDelegate.window?.rootViewController = initVC
    }
    
    class func openAuthenticationFlow() {
        let authenticationSB = UIStoryboard(name: "Authentication", bundle: NSBundle.mainBundle())
        let initVC = authenticationSB.instantiateInitialViewController()
        appDelegate.window?.rootViewController = initVC
    }
    
//    class func getSideMenuNavigationC() -> UISideMenuNavigationController {
//        let authenticationSB = UIStoryboard(name: "Authenticated", bundle: NSBundle.mainBundle())
//        let sideMenuNavigationC = authenticationSB.instantiateViewControllerWithIdentifier("SideMenuNavigationControllerID") as! UISideMenuNavigationController
//        return sideMenuNavigationC
//    }
    
    class func blueColor() -> UIColor {
        return UIColor(red: 14.0/255.0, green: 159.0/255.0, blue: 193.0/255.0, alpha: 1.0)
    }
    
    class func lightBlueColor() -> UIColor {
        return UIColor(red: 169.0/255.0, green: 219.0/255.0, blue: 239.0/255.0, alpha: 1.0)
    }
    
    class func purpleColor() -> UIColor {
        return UIColor(red: 158.0/255.0, green: 103.0/255.0, blue: 201.0/255.0, alpha: 1.0)
    }
    
    class func grayColor() -> UIColor {
        return UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
    }
    
    class func facebookColor() -> UIColor {
        return UIColor(red: 70.0/255.0, green: 98.0/255.0, blue: 158.0/255.0, alpha: 1.0)
    }
    
    class func currencyList() -> [String] {
        var myArray = [String]()
        if let path = NSBundle.mainBundle().pathForResource("Currency", ofType: "plist") {
            let dict = NSDictionary(contentsOfFile: path)
            for (_, value) in dict! {
                myArray.append(value as! String)
            }
        }
        return myArray
    }
    
    class func locationList() -> [String] {
        var myArray = [String]()
        if let path = NSBundle.mainBundle().pathForResource("Location", ofType: "plist") {
            let dict = NSDictionary(contentsOfFile: path)
            for (_, value) in dict! {
                myArray.append(value as! String)
            }
        }
        return myArray
    }
    
    
    class func checkInTouch(crd: CGPoint, frame: CGRect) -> Bool {
        if crd.x > frame.minX && crd.x < frame.maxX && crd.y > frame.minY && crd.y < frame.maxY {
            return true
        }
        return false
    }
    
    class func scaleImage(image: UIImage, toSize newSize: CGSize) -> (UIImage) {
        let newRect = CGRectIntegral(CGRectMake(0,0, newSize.width, newSize.height))
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetInterpolationQuality(context, .High)
        let flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height)
        CGContextConcatCTM(context, flipVertical)
        CGContextDrawImage(context, newRect, image.CGImage)
        let newImage = UIImage(CGImage: CGBitmapContextCreateImage(context)!)
        UIGraphicsEndImageContext()
        return newImage
    }
    
    class func nsData2UIImage(data: NSData) -> UIImage? {
        return UIImage(data: data)
    }
    
    class func showIndicatorForView(view: UIView) {
        let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        indicatorView.tag = 2601
        indicatorView.center = view.center
        indicatorView.startAnimating()
        view.userInteractionEnabled = false
        view.addSubview(indicatorView)
    }
    
    class func removeIndicatorForView(view: UIView) {
        dispatch_async(dispatch_get_main_queue(),{
            let view1 = view.viewWithTag(2601) as? UIActivityIndicatorView
            if let indicator = view1 {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
            view.userInteractionEnabled = true
        })
    }
    
    
    //MARK: func
    class func backgroundThread(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
            if(background != nil){ background!(); }
            
            let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, dispatch_get_main_queue()) {
                if(completion != nil){ completion!(); }
            }
        }
    }
    
    class func pinkColor(alpha: Float = 1.0) -> UIColor {
        return UIColor(red: 255.0/255.0, green: 90.0/255.0, blue: 96.0/255.0, alpha: alpha.cgfloat())
    }
    
    class func mainRedColor() -> UIColor {
        return UIColor(red: 208.0 / 255.0, green: 2.0 / 255.0, blue: 27.0 / 255.0, alpha: 1.0)
    }

    
    class func showTutorial(view: UIView, screen: String) {
        let key = "\(kHasTutorial) for \(screen)"
        if !kUserDefault.boolForKey(key) {
            let imageView = UIImageView(frame: view.frame)
            imageView.contentMode = UIViewContentMode.ScaleToFill
            let imageName = "\(screen) iphone 6 plus"
            imageView.image = UIImage(named: imageName)
            imageView.tag = 2507
            view.addSubview(imageView)
            kUserDefault.setBool(true, forKey: key)
            kUserDefault.synchronize()
        }
    }
    
    class func hideTutorial(view: UIView) {
        dispatch_async(dispatch_get_main_queue(),{
            let view = view.viewWithTag(2507) as? UIImageView
            if let tutorial = view {
                tutorial.removeFromSuperview()
            }
        })
    }
    
    class func loadInterstitial(testDevices: String) -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: kInterstitialID)
        let request = GADRequest()
        // Requests test ads on test devices.
        //"1ba0e235b997497c84592f9bc5b11f88"
        request.testDevices = [testDevices]
        interstitial.loadRequest(request)
        return interstitial
    }
    
    class func loadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: kInterstitialID)
        let request = GADRequest()
        // Requests test ads on test devices.
        //"1ba0e235b997497c84592f9bc5b11f88"
        interstitial.loadRequest(request)
        return interstitial
    }
    class func displayInterstitial(inout interstitial: GADInterstitial, vc: UIViewController) {
        if interstitial.isReady {
            interstitial.presentFromRootViewController(vc)
            interstitial = Utility.loadInterstitial(kAdTestDevice)
        } else {
            print("Load ad fail")
        }
    }
}

class DateFormatter: NSDateFormatter {
    
    init(format : String) {
        super.init()
        self.dateFormat = format
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}