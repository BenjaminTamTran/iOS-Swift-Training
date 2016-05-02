//
//  PlaceViewController.swift
//  Mini-Project
//
//  Created by Nguyen Xuan Thai on 4/11/16.
//  Copyright © 2016 Thai. All rights reserved.
//

import UIKit
import Photos
import BSImagePicker
import GoogleMaps
import BFPaperButton
import HSDatePickerViewController
import SwiftyDropbox
import CPImageViewer
import GoogleMobileAds
import CoreLocation
class PlaceViewController: UIViewController, HSDatePickerViewControllerDelegate, UITextViewDelegate,GADInterstitialDelegate, CLLocationManagerDelegate {
    
    // Mark: UI's elements
    @IBOutlet var favoritePlace: BFPaperButton!
    @IBOutlet var searchPlaceButton: BFPaperButton!
    @IBOutlet var pickPlaceLocation: RectangleButton!
    @IBOutlet var addMorePicture: BFPaperButton!
    @IBOutlet var addPlaceDate: BFPaperButton!
    @IBOutlet var saveInfor: BFPaperButton!
    @IBOutlet var imagesScrollView: UIScrollView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet var placeLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var editPlace: RectangleButton!
    @IBOutlet var done: RectangleButton!
    @IBOutlet var notePlace: UITextView!
    var placeholderLabel: UILabel = UILabel()
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    // Mark: Class's properties
    var test: Bool?
    var selectedImages = [UIImage]()
    var imageNames = [String]()
    var favorite: Bool = false
    var dateVisit: NSDate?
    var namePlace: String?
    var addressPlace: String?
    var places = [Place]()
    var nameImagesData = [String]()
    var placePicker: GMSPlacePicker?
    var placePick: Place?
    var longitudePlace: Double?
    var latitudePlace: Double?
    var webPlace: NSURL?
    var imgPlace: UIImage?
    var interstitial = Utility.loadInterstitial(kAdTestDevice)
    let locationManager = CLLocationManager()
    var placesClient = GMSPlacesClient()
    var checkSuccessDone = 0
    var index: Int?
    var tempImage: [UIImage] = [UIImage]()
    var checkSuccess = 0
    var isPickPlace = false
    
    // Mark: Application's life cirlce
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PlaceViewController.keyboardWillChangeFrameNotification(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
        self.initialize()
        //
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
        // Admod
        interstitial.delegate = self
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
 
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showScrollview" {
            if let vc = segue.destinationViewController as? ScrollViewController {
                vc.imageArray = tempImage
                vc.indext = index
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Mark: class's private methods
    private func initialize() {
        backButton.setFAIcon(FAType.FAChevronLeft, forState: UIControlState.Normal)
        saveInfor.setFAIcon(FAType.FASave, forState: .Normal)
        favoritePlace.setFAIcon(FAType.FAHeartO, forState: .Normal)
        notePlace.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PlaceViewController.tap(_:)))
        view.addGestureRecognizer(tapGesture)

        
//        placeholderLabel.text = "Enter optional text here..."
//        placeholderLabel.font = UIFont.italicSystemFontOfSize(notePlace.font!.pointSize)
//        placeholderLabel.sizeToFit()
//        notePlace.addSubview(placeholderLabel)
//        placeholderLabel.frame.origin = CGPointMake(5, notePlace.font!.pointSize / 2)
//        placeholderLabel.textColor = UIColor(white: 0, alpha: 0.3)
        placeholderLabel.hidden = false
        if let place = placePick {
            addMorePicture.hidden = false
            addMorePicture.enabled = false
            addPlaceDate.hidden = false
            addPlaceDate.enabled = false
            addMorePicture.enabled = false
            favoritePlace.hidden = false
            favoritePlace.enabled = false
            renderUIWithPlace(place)
            pickPlaceLocation.hidden = true
            editPlace.hidden = false
            saveInfor.hidden = true
            done.hidden = true
            notePlace.hidden = false
        }
        else {
            self.searchPlaceAction(self.view)
            imageView.image = UIImage(named: "cover")
            saveInfor.hidden = true
            addMorePicture.hidden = true
            addPlaceDate.hidden = true
            favoritePlace.hidden = true
            favorite = false
            editPlace.hidden = true
            done.hidden = true
            notePlace.hidden = true
        }

    }
    
    func tap(gesture: UITapGestureRecognizer) {
        notePlace.resignFirstResponder()
    }
    
    func renderUIWithPlace(place: Place) {
        placeLabel.text = place.name
        if let imgPlaceData = place.imgTravel {
            imageView.image = UIImage(data: imgPlaceData)
        }
        else {
            imageView.image = UIImage(named: "cover")
        }
        addPlaceDate.setTitle(kDateYYMMDD.stringFromDate(place.date), forState: .Normal)
        placeholderLabel.hidden = true
        if let notePlaces = place.note {
            notePlace.text = notePlaces
        }
    
        clearScrollView()
        var xCoordinate: CGFloat = 10
        dispatch_async(dispatch_get_main_queue(),{
        if let placeImage = place.images as? [String] {
            self.tempImage.removeAll()
            //
            
        for image in placeImage {
            Dropbox.authorizedClient!.files.getThumbnail(path: "/\(image)", format: .Jpeg, size: .W640h480, destination: destination).response { response, error in
                if let (metadata, url) = response, data = NSData(contentsOfURL: url), image = UIImage(data: data) {
                    
                    print("Dowloaded file name: \(metadata.name)")
                    
                    // Resize image for watch (so it's not huge)
                    //let resizedImage = self.resizeImage(image)
                    let resizedImage = image
                    let imgView = UIImageView(frame: CGRectMake(xCoordinate, 10, self.imagesScrollView.frame.width - 20, self.imagesScrollView.frame.height - 20))
                    imgView.image = resizedImage
                    imgView.contentMode = UIViewContentMode.ScaleAspectFit
                    self.imagesScrollView.addSubview(imgView)
                    self.tempImage.append(image)
//
//                    let animationImageView = UIImageView(frame: CGRectMake(xCoordinate, 10, self.imagesScrollView.frame.width - 20, self.imagesScrollView.frame.height - 20))
//                    animationImageView.image = resizedImage
//                    self.animationImageViewArray.append(animationImageView)
//                    animationImageView.contentMode = UIViewContentMode.ScaleAspectFit
//                    self.imagesScrollView.addSubview(animationImageView)
                    // add
                    let button = UIButton(frame: imgView.frame)
                    button.addTarget(self, action: #selector(self.imageAction(_:)), forControlEvents: .TouchUpInside)
                    button.tag = self.tempImage.indexOf(image)!
                    self.imagesScrollView.addSubview(button)
                    
                    xCoordinate += self.imagesScrollView.frame.width
                } else {
                    print("Error downloading file from Dropbox: \(error!)")
                }
                
            }
        }
            var contentSize = self.imagesScrollView.contentSize
            let width = CGFloat(placeImage.count)
            print("\(placeImage.count)")
            contentSize.width = width * self.imagesScrollView.frame.width
            self.imagesScrollView.contentSize = contentSize
            let scrollPoint = CGPointMake(0.0, 0.0)
            self.imagesScrollView.setContentOffset(scrollPoint, animated: true)
            
            if !place.favorite {
                self.favoritePlace.setFAIcon(FAType.FAHeartO, forState: .Normal)
            }
            else
            {
                self.favoritePlace.setFAIcon(FAType.FAHeart, forState: .Normal)
            }
        }
      })
    }


    func imageAction(sender: AnyObject) {
        if let button = sender as? UIButton
        {
            index = button.tag
            self.performSegueWithIdentifier("showScrollview", sender: self)
        }
  
    }
    
    // MARK: Button Actions
    @IBAction func addMorePicsAction(sender: AnyObject) {
     
        let vc = BSImagePickerViewController()
        //customsize the ImagePicker
        vc.maxNumberOfSelections = 6
        vc.albumButton.tintColor = UIColor.greenColor()
        vc.cancelButton.tintColor = UIColor.redColor()
        vc.doneButton.tintColor = UIColor.purpleColor()
        vc.selectionCharacter = "✓"
        vc.selectionFillColor = UIColor.grayColor()
        vc.selectionStrokeColor = UIColor.yellowColor()
        vc.selectionShadowColor = UIColor.redColor()
        vc.selectionTextAttributes[NSForegroundColorAttributeName] = UIColor.lightGrayColor()
        vc.cellsPerRow = {(verticalSize: UIUserInterfaceSizeClass, horizontalSize: UIUserInterfaceSizeClass) -> Int in
            switch (verticalSize, horizontalSize) {
            case (.Compact, .Regular): // iPhone5-6 portrait
                return 2
            case (.Compact, .Compact): // iPhone5-6 landscape
                return 2
            case (.Regular, .Regular): // iPad portrait/landscape
                return 3
            default:
                return 2
            }
        }
        
        bs_presentImagePickerController(vc, animated: true,
                                        select: { (asset: PHAsset) -> Void in
            }, deselect: { (asset: PHAsset) -> Void in//action when deselect
            }, cancel: { (assets: [PHAsset]) -> Void in//action when cancel
            }, finish: { (assets: [PHAsset]) -> Void in//action when finish
                dispatch_async(dispatch_get_main_queue(),{
                    self.selectedImages.removeAll()
                    self.imageNames.removeAll()
                    self.nameImagesData.removeAll()
                    self.clearScrollView()
                    var xCoordinate: CGFloat = 10
                    
                    for asset in assets {
                        let name = asset.originalFilename
                        self.imageNames.append(name!)
                        let manager = PHImageManager.defaultManager()
                        let option = PHImageRequestOptions()
                        var image = UIImage()
                        option.synchronous = true
                        manager.requestImageForAsset(asset, targetSize: CGSize(width: 1080.0, height: 720.0), contentMode: .AspectFit, options: option, resultHandler: {(result, info)->Void in
                            image = result!
                            self.selectedImages.append(image)
                        })
                        let imageView = UIImageView(frame: CGRectMake(xCoordinate, 10, self.imagesScrollView.frame.width - 20, self.imagesScrollView.frame.height - 20))
                        imageView.image = image
                        imageView.contentMode = UIViewContentMode.ScaleAspectFit
                        self.imagesScrollView.addSubview(imageView)
                        xCoordinate += self.imagesScrollView.frame.width
                        
                    }
                    var contentSize = self.imagesScrollView.contentSize
                    let width = CGFloat(self.imageNames.count)
                    contentSize.width = width * self.imagesScrollView.frame.width
                    self.imagesScrollView.contentSize = contentSize
                    let scrollPoint = CGPointMake(0.0, 0.0)
                    self.imagesScrollView.setContentOffset(scrollPoint, animated: true)
                })
                
            }, completion: nil)
    }

    //Event save touch up inside
    @IBAction func saveEventAction(sender: AnyObject) {
        checkSuccess = 0
        var imgData: NSData?
//        let imgData = UIImageJPEGRepresentation(imageView.image!,1)
        if let imagePlaceTravel = imgPlace {
           imgData = UIImageJPEGRepresentation(imagePlaceTravel,1)
        }
        let currentDate = String(NSDate().timeIntervalSince1970)
        let currenDateArr = currentDate.characters.split{$0 == "."}.map(String.init)
        if let _ = dateVisit {
              dispatch_async(dispatch_get_main_queue(),{
                Utility.showIndicatorForView(self.view)
                if self.selectedImages.count == 0 {
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    let managedObjectContext = appDelegate.managedObjectContext
                    Place.onCreateManagedObjectContext(managedObjectContext, name: self.namePlace!, address: self.addressPlace!, date: self.dateVisit!, images: [], favorite: self.favorite, imgTravel: imgData, longitude: self.longitudePlace!, latitude: self.latitudePlace!, web: self.webPlace, note: self.notePlace.text)
                    appDelegate.saveContext()
                }
                else
                {
                    if let client = Dropbox.authorizedClient {
                        for i in 0 ... self.selectedImages.count - 1 {
                            let fileData = UIImageJPEGRepresentation(self.selectedImages[i], 1)
                            let fileNamePlaceEncode = self.namePlace!.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
                            print(fileNamePlaceEncode!)
                            let filePath = "/\(fileNamePlaceEncode!)/\(currenDateArr[0])\(self.imageNames[i])"
                
                            client.files.upload(path: filePath, body: fileData!).response { response, error in
                                if let _ = response {
                                    client.files.getMetadata(path: filePath).response { response, error in
                                        print("*** Get file metadata ***")
                                        self.checkSuccess += 1
                                        if let metadata = response {
                                            if let file = metadata as? Files.FileMetadata {
                                               
                                                print("This is a file with path: \(file.pathLower)")
                                                print("File size: \(file.size)")
                                                print(file.description)
                                            }
                                            else if let folder = metadata as? Files.FolderMetadata {
                                                print("This is a folder with path: \(folder.pathLower)")
                                            }
                                        }
                                        else
                                        {
                                            print(error!)
                                        }
                                        if self.checkSuccess == self.selectedImages.count  {
                                            Utility.removeIndicatorForView(self.view)
                                            self.navigationController?.popViewControllerAnimated(true)
                                        }
                                    }
                                }
                            }
                            
                        self.nameImagesData.append(filePath)
                        }
                        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        let managedObjectContext = appDelegate.managedObjectContext
                        Place.onCreateManagedObjectContext(managedObjectContext, name: self.namePlace!, address: self.addressPlace!, date: self.dateVisit!, images: self.nameImagesData, favorite: self.favorite, imgTravel: imgData,longitude: self.longitudePlace!, latitude: self.latitudePlace!, web: self.webPlace, note: self.notePlace.text)
                        appDelegate.saveContext()
                    }
                    else
                    {
                        ///Dropbox.authorizeFromController(self)
                        let accessToken = DropboxAccessToken(accessToken: accessTokenDropbox, uid: uidDropbox)
                        Dropbox.authorizedClient = DropboxClient(accessToken: accessToken)
                        DropboxClient.sharedClient = Dropbox.authorizedClient
                    }
                }
//                Utility.removeIndicatorForView(self.view)
//                self.navigationController?.popViewControllerAnimated(true)
              })
            stickyCreate += 1
            if stickyCreate % 2 == 0 {
                Utility.displayInterstitial(&interstitial, vc: self)
            }
            
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Missing Add Date", preferredStyle: .Alert)
                let actionOK = UIAlertAction(title: "OK", style: .Default, handler: { UIAlertAction in
                    let hsdpvc: HSDatePickerViewController = HSDatePickerViewController()
                    hsdpvc.mainColor = UIColor.whiteColor()
                    hsdpvc.delegate = self
                    self.presentViewController(hsdpvc, animated: true, completion: { _ in })
                })
                let actionCancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                alert.addAction(actionOK)
                alert.addAction(actionCancel)
                self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func favoriteAction(sender: AnyObject) {
        if !favorite {
            favorite = true
            favoritePlace.setFAIcon(FAType.FAHeart, forState: .Normal)
        }
        else {
            favorite = false
            favoritePlace.setFAIcon(FAType.FAHeartO, forState: .Normal)
        }
    }
    
    @IBAction func backAction(sender: AnyObject) {
        view.endEditing(true)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func searchPlaceAction(sender: AnyObject) {
        self.view.endEditing(true)
        var center = CLLocationCoordinate2DMake(37.788204, -122.411937)
        placesClient = GMSPlacesClient()
        Utility.showIndicatorForView(self.view)
        placesClient.currentPlaceWithCallback({ (placeLikelihoods, error) -> Void in
            Utility.removeIndicatorForView(self.view)
            if error != nil
            {
                print("Current Place error: \(error!.localizedDescription)")
            } else {
                if let placeLikelihoods = placeLikelihoods {
                    if let place = placeLikelihoods.likelihoods.first?.place {
                        center = CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude)
                    }
                }
            }
            let northEast = CLLocationCoordinate2DMake(center.latitude + 0.001, center.longitude + 0.001)
            let southWest = CLLocationCoordinate2DMake(center.latitude - 0.001, center.longitude - 0.001)
            let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
            let config = GMSPlacePickerConfig(viewport: viewport)
            self.placePicker = GMSPlacePicker(config: config)
            if self.isPickPlace == true {
                return
            } else {
                self.isPickPlace = true
            }
            self.placePicker?.pickPlaceWithCallback({ (place: GMSPlace?, error: NSError?) -> Void in
                self.isPickPlace = false
                
                if let error = error {
                    print("Pick Place error: \(error.localizedDescription)")
                    return
                }
                if let place = place {
                    self.placeLabel.text = place.name
                    print("Place address \(place.formattedAddress)")
                    print("Place attributions \(place.attributions)")
                    self.namePlace = place.name
                    self.addressPlace = place.formattedAddress!
                    self.loadFirstPhotoForPlace(place.placeID)
                    self.longitudePlace = place.coordinate.longitude
                    self.latitudePlace = place.coordinate.latitude
                    self.webPlace = place.website
                    self.addMorePicture.hidden = false
                    self.saveInfor.hidden = false
                    self.addPlaceDate.hidden = false
                    self.favoritePlace.hidden = false
                    self.favorite = false
                    self.notePlace.hidden = false
                    
                }
                else
                {
                    let alert = UIAlertController(title: "Search Place", message: "Please press Pick Place Location to add location ", preferredStyle: .Alert)
                    let action = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                    alert.addAction(action)
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                
                self.isPickPlace = false
            })
        })
    }
    
    @IBAction func addPlaceDateAction(sender: AnyObject) {
        let hsdpvc: HSDatePickerViewController = HSDatePickerViewController()
        hsdpvc.mainColor = UIColor.whiteColor()
        hsdpvc.delegate = self
        self.presentViewController(hsdpvc, animated: true, completion: { _ in })
    }
    
    @IBAction func editInfoPlace(sender: AnyObject) {
        done.hidden = false
        addMorePicture.enabled = true
        favoritePlace.enabled = true
    
    }
    
    @IBAction func doneAction(sender: AnyObject) {
        var checkSuccessDone = 0
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        let dataImage = placePick!.images as! [String]
        print(nameImagesData)
        if let _ = Place.updatePlace(managedObjectContext, name: (placePick?.name)!, date: (placePick?.date)!) {
            if let client = Dropbox.authorizedClient {
                Utility.showIndicatorForView(self.view)
                if selectedImages.count != 0 {
                    for img in dataImage
                    {
                        client.files.delete(path: "\(img)")
                    }
                    
                    let currentDate = String(NSDate().timeIntervalSince1970)
                    let currenDateArr = currentDate.characters.split{$0 == "."}.map(String.init)
                    for i in 0 ... self.selectedImages.count - 1 {
                        checkSuccessDone += 1
                        let fileData = UIImageJPEGRepresentation(self.selectedImages[i], 1)
                         let fileNamePlaceEncode = self.placePick!.name.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
                        let filePath = "/\(fileNamePlaceEncode!)/\(currenDateArr[0])\(self.imageNames[i])"
                        client.files.upload(path: filePath, body: fileData!)
                        nameImagesData.append(filePath)
                        if self.checkSuccessDone == self.selectedImages.count  {
                            Utility.removeIndicatorForView(self.view)
                        }
                    }
                    
                    print(nameImagesData)
                    
                    placePick!.images = nameImagesData
                    print("\(favorite)")
                    print("\(placePick!.favorite)")
                   
                }
                
            }

        }
        placePick!.favorite = favorite
        appDelegate.saveContext()
        view.endEditing(true)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let currentText:NSString = textView.text
        let updatedText = currentText.stringByReplacingCharactersInRange(range, withString:text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGrayColor()
            textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
            
            return false
        }
            
            // Else if the text view's placeholder is showing and the
            // length of the replacement string is greater than 0, clear
            // the text view and set its color to black to prepare for
            // the user's entry
        else if textView.textColor == UIColor.lightGrayColor() && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
        
        return true
    }
    
    func keyboardWillChangeFrameNotification(notification: NSNotification) {
        let n = KeyboardNotification(notification)
        let keyboardFrame = n.frameEndForView(self.view)
        let animationDuration = n.animationDuration
        let animationCurve = n.animationCurve
        let viewFrame = self.view.frame
        let newBottomOffset = viewFrame.maxY - keyboardFrame.minY
        print("newBottomOffset is \(newBottomOffset)")
        self.view.layoutIfNeeded()
        self.scrollView.scrollRectToVisible(CGRectMake(self.scrollView.contentSize.width, self.scrollView.contentSize.height, 1, 1), animated: true)
        UIView.animateWithDuration(animationDuration,
               delay: 0,
               options: UIViewAnimationOptions(rawValue: UInt(animationCurve << 16)),
               animations: {
                if newBottomOffset > 0 {
                    // Keyboard will show
                    self.bottomConstraint.constant = newBottomOffset - 44
                }
                else {
                    // keyboard will hide
                    self.bottomConstraint.constant = 0
                }
                self.view.layoutIfNeeded()
            },
               completion: nil
        )
    }
    
    func interstitialDidFailToReceiveAdWithError(interstitial: GADInterstitial,
                                                 error: GADRequestError) {
        print("\(#function): \(error.localizedDescription)")
    }
    
    func interstitialDidDismissScreen(interstitial: GADInterstitial) {
        print(#function)
       // startNewGame()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError){
        print("error")
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0]
        _ = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
//        locationManager.location = location
//        print(locationManager.location)
    }
    
    func loadFirstPhotoForPlace(placeID: String) {
        GMSPlacesClient.sharedClient().lookUpPhotosForPlaceID(placeID) { (photos, error) -> Void in
            if let error = error {
                print("Error: \(error.description)")
            } else {
                if let firstPhoto = photos?.results.first {
                    self.loadImageForMetadata(firstPhoto)
                }
                else {
                    let alert = UIAlertController(title: "Search Image", message: "Don't have image for this place", preferredStyle: .Alert)
                    let action = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                    alert.addAction(action)
                    self.presentViewController(alert, animated: true, completion: nil)
                    self.imageView.image = UIImage(named: "cover")
                }
            }
        }
    }
    
    func loadImageForMetadata(photoMetadata: GMSPlacePhotoMetadata) {
        GMSPlacesClient.sharedClient()
            .loadPlacePhoto(photoMetadata, constrainedToSize: imageView.bounds.size,
                            scale: self.imageView.window!.screen.scale) { (photo, error) -> Void in
                                if let error = error {
                                    // TODO: handle the error.
                                    print("Error: \(error.description)")
                                    
                                } else {
                                    self.imageView.image = photo;
                                    self.imgPlace = photo
                                }
        }
    }
    
    //# MARK: - remove all sub view from scroll view
    func clearScrollView() {
        for view in self.imagesScrollView.subviews {
            view.removeFromSuperview()
        }
    }
    
    func hsDatePickerPickedDate(date: NSDate!) {
        dateVisit = date
        addPlaceDate.setTitle(kDateYYMMDD.stringFromDate(date), forState: .Normal)
    }
  
}
