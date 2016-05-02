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
import GoogleMobileAds

class PlaceListViewControllerr: UIViewController, UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate,FBSDKSharingDelegate, UITextFieldDelegate, GADInterstitialDelegate {
    
    // Mark: UI's elements
    @IBOutlet var placesTableView: UITableView!
    @IBOutlet weak var addPlaceButton: UIButton!
    @IBOutlet weak var placeTabBarItem: UITabBarItem!
    
    @IBOutlet var searchTextField: UITextField!
  
    // Mark: Class's properties
    
    var interstitial = Utility.loadInterstitial(kAdTestDevice)
    var historyPlace = [Place]()
    var searchDataPlace = [Place]()
    var placePick: Place?
    var imageShareFB = [FBSDKSharePhoto]()
    var speciesSearchResults = [Place]()
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
        searchTextField.text = ""
        searchTextField.resignFirstResponder()
        reloadData()
    }
    
    // Mark: class's private methods
    private func initialize() {
        addPlaceButton.setFAIcon(FAType.FAPlus, forState: UIControlState.Normal)
        placeTabBarItem.setFAIcon(FAType.FAMapPin)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tap))
        placesTableView.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
        searchTextField.autocorrectionType = .No
    }
    
    func tap(gesture: UITapGestureRecognizer) {
        searchTextField.resignFirstResponder()
    }
    
    private func reloadData() {
        historyPlace = Place.allPlace(appDelegate.managedObjectContext)
        searchDataPlace = historyPlace
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
        return searchDataPlace.count
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! PlacesTableViewCell
        let place = searchDataPlace[indexPath.row]
        cell.delegate = self
        cell.namePlace.text = searchDataPlace[indexPath.row].name
        if let imgPlaceData = searchDataPlace[indexPath.row].imgTravel
        {
            cell.imagePlace.image = UIImage(data: imgPlaceData)
        }
        cell.timeVisit.text = searchDataPlace[indexPath.row].date.toShortTimeString()
        
        if let placeImage = place.images as? [String] {
            if !placeImage.isEmpty || place.imgTravel != nil {
                self.imageShareFB.removeAll()
                var leftButtons: [MGSwipeButton] = [MGSwipeButton]()
                if !placeImage.isEmpty {
                    leftButtons.append(
                        MGSwipeButton(title: "share Facebook", backgroundColor: Utility.facebookColor(), callback: { (sender: MGSwipeTableCell!) -> Bool in
                            //
//                            if let image = placeImage.first {
                            for image in placeImage {
                                Dropbox.authorizedClient!.files.getThumbnail(path: "/\(image)", format: .Jpeg, size: .W1024h768, destination: destination).response { response, error in
                                    if let (_, url) = response, data = NSData(contentsOfURL: url), image = UIImage(data: data) {
                                        self.imageShareFB.append(FBSDKSharePhoto(image: image, userGenerated: true))
//                                        self.shareToFacebook()
                                    }
                                    else
                                    {
                                        print("Error downloading file from Dropbox: \(error!)")
                                    }
                                }
                            }
                            self.shareToFacebook()
                            return true
                        } )
                    )
                } else {
                    leftButtons.append(
                    MGSwipeButton(title: "share Facebook", backgroundColor: Utility.facebookColor(), callback: { (sender: MGSwipeTableCell!) -> Bool in
                        if let imgPlaceData = self.searchDataPlace[indexPath.row].imgTravel {
                            self.imageShareFB.removeAll()
                            self.imageShareFB.append((FBSDKSharePhoto(image: UIImage(data: imgPlaceData), userGenerated: true)))
                            self.shareToFacebook()
                        }
                        return true
                    } )
                    )
                }
                cell.leftButtons = leftButtons
            }
        }
        cell.leftSwipeSettings.transition = MGSwipeTransition.Static
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let moc = appDelegate.managedObjectContext
            moc.deleteObject(searchDataPlace[indexPath.row])
            if let nameImages = searchDataPlace[indexPath.row].images as? [String] {
                if let client = Dropbox.authorizedClient {
                    for nameImage in nameImages {
                        client.files.delete(path: "\(nameImage)")
                    }
                }
            }
            appDelegate.saveContext()
            searchDataPlace.removeAtIndex(indexPath.row)
            placesTableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        placePick = searchDataPlace[indexPath.row]
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
                    //FBSDKLoginManager().logOut()
                    Utility.displayInterstitial(&self.interstitial, vc: self)
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
        Utility.displayInterstitial(&interstitial, vc: self)
        
    }
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        print(error.description)
        Utility.displayInterstitial(&interstitial, vc: self)
    }
    
    func sharerDidCancel(sharer: FBSDKSharing!) {
        print("sharerDidCancel")
        Utility.displayInterstitial(&interstitial, vc: self)
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
    

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let subStr = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        if !subStr.isEmpty {
            searchDataPlace.removeAll()
            for historyData in historyPlace {
                var myString: NSString! = historyData.name
                myString = myString.lowercaseString
                let substringRange: NSRange! = myString.rangeOfString(subStr.lowercaseString)
                if (substringRange.location == 0 ) {
                    searchDataPlace.append(historyData)
                }
            }
            //placesTableView.reloadData()
        } else {
            searchDataPlace = historyPlace
        }
        placesTableView.reloadData()
        return true
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchDataPlace = historyPlace
          placesTableView.reloadData()
        textField.text = ""
        return false

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchDataPlace = historyPlace
        placesTableView.reloadData()
        textField.text = ""
        return false
    }
    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//            textField.resignFirstResponder()
//            searchDataPlace = historyPlace
//            placesTableView.reloadData()
//            return true
//        
//    }
    
//    func filterContentForSearchText(searchText: String) {
//        // Filter the array using the filter method
// 
//        self.speciesSearchResults = self.historyPlace.filter({( aSpecies: Place) -> Bool in
//            // to start, let's just search by name
//            return aSpecies.name.lowercaseString.rangeOfString(searchText.lowercaseString) != nil
//        })
//    }
//    
//    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
//        self.filterContentForSearchText(searchString)
//        return true
//    }
}
