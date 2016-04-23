//
//  PlaceListViewController.swift
//  Mini-Project
//
//  Created by Tran Huu Tam on 4/15/16.
//  Copyright © 2016 The Simple Studio. All rights reserved.
//

import UIKit
import SwiftyDropbox
import MGSwipeTableCell
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

class PlaceListViewControllerr: UIViewController, UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate,FBSDKSharingDelegate {
    
    // Mark: UI's elements
    @IBOutlet var placesTableView: UITableView!
    @IBOutlet weak var addPlaceButton: UIButton!
    @IBOutlet weak var placeTabBarItem: UITabBarItem!
    
    // Mark: Class's properties
    var historyPlace = [Place]()
    var placePick: Place?
    var imageShareFB = [FBSDKSharePhoto]()
    // Mark: Application's life cirlce
    override func viewDidLoad() {
        super.viewDidLoad()
          self.initialize()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        reloadData()
    }
    
    // Mark: class's private methods
    private func initialize() {
        addPlaceButton.setFAIcon(FAType.FAPlus, forState: UIControlState.Normal)
        placeTabBarItem.setFAIcon(FAType.FAMapPin)
    }
    
    private func reloadData() {
        historyPlace = Place.allPlace(appDelegate.managedObjectContext)
        placesTableView.reloadData()
    }
    
    // MARK: Button Action
    @IBAction func addPlace(sender: AnyObject) {
        placePick = nil
        self.performSegueWithIdentifier("showPlaceSegue", sender: self)
    }
    
    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyPlace.count
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MGSwipeTableCell
        cell.textLabel?.text = historyPlace[indexPath.row].name
        cell.delegate = self
        cell.imageView?.image = UIImage(data: historyPlace[indexPath.row].imgTravel)
        cell.leftButtons = [MGSwipeButton(title: "ShareFacebook", backgroundColor: UIColor.redColor(), callback: {
            (sender: MGSwipeTableCell!) -> Bool in
            print("Convenience callback for swipe buttons!")
            // download photo from dropbox
            if let placeImage = self.historyPlace[indexPath.row].images as? [String] {
                self.imageShareFB.removeAll()
                if let image = placeImage.first {
                    Dropbox.authorizedClient!.files.getThumbnail(path: "/\(image)", format: .Jpeg, size: .W640h480, destination: destination).response { response, error in
                        if let (_, url) = response, data = NSData(contentsOfURL: url), image = UIImage(data: data) {
                            self.imageShareFB.append(FBSDKSharePhoto(image: image, userGenerated: true))
                            self.shareToFacebook()
                        }
                        else
                        {
                            print("Error downloading file from Dropbox: \(error!)")
                        }
                    }
                }
            }
            return true
          }
       )]
        cell.leftSwipeSettings.transition = MGSwipeTransition.Static
        cell.detailTextLabel?.text = historyPlace[indexPath.row].date.toShortTimeString()
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let moc = appDelegate.managedObjectContext
            moc.deleteObject(historyPlace[indexPath.row])
            if let nameImages = historyPlace[indexPath.row].images as? [String] {
                if let client = Dropbox.authorizedClient {
                    for nameImage in nameImages {
                        client.files.delete(path: "\(nameImage)")
                    }
                }
            }
            appDelegate.saveContext()
            historyPlace.removeAtIndex(indexPath.row)
            placesTableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        placePick = historyPlace[indexPath.row]
        self.performSegueWithIdentifier("showPlaceSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPlaceSegue" {
            if let vc = segue.destinationViewController as? PlaceViewController {
                vc.placePick = placePick
            }
            
        }
    }
    
    // MARK: Facebook share methods
    private func shareToFacebook() {
        if let _ = FBSDKAccessToken.currentAccessToken() {
            let content = FBSDKSharePhotoContent()
            content.photos = self.imageShareFB
            FBSDKShareDialog.showFromViewController(self, withContent: content, delegate: self)
        }
        else
        {
            let login = FBSDKLoginManager()
            login.logInWithReadPermissions(FACEBOOK_PERMISSIONS, fromViewController: self, handler: { (result, error) -> Void in
                
                if result.isCancelled {
                    FBSDKLoginManager().logOut()
                }
                else
                {
                    // To do
                    if let er = error {
                        print(er.description)
                    }
                    else
                    {
                        let content = FBSDKSharePhotoContent()
                        content.photos = self.imageShareFB
                        FBSDKShareDialog.showFromViewController(self, withContent: content, delegate: self)
                    }
                }
            })
        }
    }
    
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        print("didCompleteWithResults")
    }
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        print(error.description)
    }
    
    func sharerDidCancel(sharer: FBSDKSharing!) {
        print("sharerDidCancel")
    }
    
    private func resizeImage(image: UIImage) -> UIImage {
        
        // Resize and crop to fit Apple watch (square for now, because it's easy)
        let maxSize: CGFloat = 200.0
        var size: CGSize?
        
        if image.size.width >= image.size.height {
            size = CGSizeMake((maxSize / image.size.height) * image.size.width, maxSize)
        } else {
            size = CGSizeMake(maxSize, (maxSize / image.size.width) * image.size.height)
        }
        
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size!, !hasAlpha, scale)
        
        let rect = CGRect(origin: CGPointZero, size: size!)
        UIRectClip(rect)
        image.drawInRect(rect)
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    

}
