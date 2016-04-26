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

class PlaceViewController: UIViewController, HSDatePickerViewControllerDelegate, UITextViewDelegate  {
    
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
    var notePlaceData: String?
    var animationImageViewArray = [UIImageView]()
    // Mark: Application's life cirlce
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    func tap(gesture: UITapGestureRecognizer) {
        notePlace.resignFirstResponder()
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
    
    // Mark: class's private methods
    private func initialize() {
        backButton.setFAIcon(FAType.FAChevronLeft, forState: UIControlState.Normal)
        saveInfor.setFAIcon(FAType.FASave, forState: .Normal)
        favoritePlace.setFAIcon(FAType.FAHeartO, forState: .Normal)
        notePlace.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PlaceViewController.tap(_:)))
        view.addGestureRecognizer(tapGesture)
        placeholderLabel.text = "Enter optional text here..."
        placeholderLabel.font = UIFont.italicSystemFontOfSize(notePlace.font!.pointSize)
        placeholderLabel.sizeToFit()
        notePlace.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPointMake(5, notePlace.font!.pointSize / 2)
        placeholderLabel.textColor = UIColor(white: 0, alpha: 0.3)
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
    var tempImage: [UIImage] = [UIImage]()
    func renderUIWithPlace(place: Place) {
        placeLabel.text = place.name
        imageView.image = UIImage(data: place.imgTravel)
        addPlaceDate.setTitle(kDateYYMMDD.stringFromDate(place.date), forState: .Normal)
        placeholderLabel.hidden = true
        notePlace.text = place.note
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
//                    let imgView = UIImageView(frame: CGRectMake(xCoordinate, 10, self.imagesScrollView.frame.width - 20, self.imagesScrollView.frame.height - 20))
//                    imgView.image = resizedImage
//                    imgView.contentMode = UIViewContentMode.ScaleAspectFit
//                    self.imagesScrollView.addSubview(imgView)
                    

                    let animationImageView = UIImageView(frame: CGRectMake(xCoordinate, 10, self.imagesScrollView.frame.width - 20, self.imagesScrollView.frame.height - 20))
                    animationImageView.image = resizedImage
                    self.animationImageViewArray.append(animationImageView)
                    animationImageView.contentMode = UIViewContentMode.ScaleAspectFit
                    self.imagesScrollView.addSubview(animationImageView)
                    
                    let button = UIButton(frame: animationImageView.frame)
                    button.addTarget(self, action: #selector(self.imageAction(_:)), forControlEvents: .TouchUpInside)
                    button.tag = self.animationImageViewArray.indexOf(animationImageView)!
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
            if button.tag < self.animationImageViewArray.count {
                let imageView = self.animationImageViewArray[button.tag]
                let controller = CPImageViewerViewController()
                controller.transitioningDelegate = CPImageViewerAnimator()
                controller.image = imageView.image
                self.presentViewController(controller, animated: true, completion: nil)
            }
        }
    }
    
//    func initStackView() {
//        self.stackImagePicked.axis = .Horizontal
//        self.stackImagePicked.distribution = .FillEqually
//        self.stackImagePicked.alignment = .Fill
//        self.stackImagePicked.spacing = 10
//        self.stackImagePicked.translatesAutoresizingMaskIntoConstraints = false
//    }
    
    // MARK: -Action when touch up inside
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
        let imgData = UIImageJPEGRepresentation(imageView.image!,1)
        let currentDate = String(NSDate().timeIntervalSince1970)
        let currenDateArr = currentDate.characters.split{$0 == "."}.map(String.init)
        if let dateVisit = dateVisit {
              dispatch_async(dispatch_get_main_queue(),{
                if self.selectedImages.count == 0 {
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    let managedObjectContext = appDelegate.managedObjectContext
                    Place.onCreateManagedObjectContext(managedObjectContext, name: self.namePlace!, address: self.addressPlace!, date: self.dateVisit!, images: [], favorite: self.favorite, imgTravel: imgData!, longitude: self.longitudePlace!, latitude: self.latitudePlace!, web: self.webPlace, note: self.notePlaceData)
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
                                if let metadata = response {
                                    client.files.getMetadata(path: filePath).response { response, error in
                                        print("*** Get file metadata ***")
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
                                    }
                                }
                            }
                            
                        self.nameImagesData.append(filePath)
                        }
                        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        let managedObjectContext = appDelegate.managedObjectContext
                        Place.onCreateManagedObjectContext(managedObjectContext, name: self.namePlace!, address: self.addressPlace!, date: self.dateVisit!, images: self.nameImagesData, favorite: self.favorite, imgTravel: imgData!,longitude: self.longitudePlace!, latitude: self.latitudePlace!, web: self.webPlace, note: self.notePlaceData)
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
//            let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PlaceListViewController")
//            self.navigationController?.pushViewController(secondViewController!, animated: true)
            })
            self.navigationController?.popViewControllerAnimated(true)
       
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
        let center = CLLocationCoordinate2DMake(10.762689, 106.68234)
        let northEast = CLLocationCoordinate2DMake(center.latitude + 0.001, center.longitude + 0.001)
        let southWest = CLLocationCoordinate2DMake(center.latitude - 0.001, center.longitude - 0.001)
        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        let config = GMSPlacePickerConfig(viewport: viewport)
        placePicker = GMSPlacePicker(config: config)
        
        placePicker?.pickPlaceWithCallback({ (place: GMSPlace?, error: NSError?) -> Void in
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
        })
    }
    
    @IBAction func addPlaceDateAction(sender: AnyObject) {
        let hsdpvc: HSDatePickerViewController = HSDatePickerViewController()
        hsdpvc.mainColor = UIColor.whiteColor()
        hsdpvc.delegate = self
        self.presentViewController(hsdpvc, animated: true, completion: { _ in })
    }
    
    func hsDatePickerPickedDate(date: NSDate!) {
        dateVisit = date
        addPlaceDate.setTitle(kDateYYMMDD.stringFromDate(date), forState: .Normal)
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
                                }
        }
    }

    // set button 
    func setButton(){
//        favoritePlace.setTitleColor(UIColor.whiteColor(), forState: .Normal)
//        favoritePlace.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
//        favoritePlace.backgroundColor = UIColor(red: 1, green: 0, blue: 0.1, alpha: 0.5)
//        favoritePlace.tapCircleColor = UIColor(red: 1, green: 0, blue: 1, alpha: 0.6)
//        favoritePlace.isRaised = true
//        favoritePlace.cornerRadius = favoritePlace.frame.size.width / 2
//        favoritePlace.rippleFromTapLocation = false
//        favoritePlace.rippleBeyondBounds = true
        
        
//        searchPlaceButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
//        searchPlaceButton.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
//        searchPlaceButton.backgroundColor = UIColor(red: 0.3, green: 0, blue: 1, alpha: 1)
//        searchPlaceButton.tapCircleColor = UIColor(red: 1, green: 0, blue: 1, alpha: 0.6)
//        searchPlaceButton.isRaised = true
//        searchPlaceButton.cornerRadius = favoritePlace.frame.size.width / 2
//        searchPlaceButton.rippleFromTapLocation = false
//        searchPlaceButton.rippleBeyondBounds = true
//        searchPlaceButton.addTarget(self, action: #selector(PlaceViewController.searchPlace), forControlEvents: .TouchUpInside)
        
//        addMorePicture.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.1, alpha: 0.3)
//        addMorePicture.setTitleColor(UIColor.blueColor(), forState: .Normal)
//        addMorePicture.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
//        
//        addPlaceDate.backgroundColor = UIColor(red: 0.8, green: 0.1, blue: 0.7, alpha: 0.3)
//        addPlaceDate.setTitleColor(UIColor.blueColor(), forState: .Normal)
//        addPlaceDate.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
//        addPlaceDate.addTarget(self, action: #selector(PlaceViewController.showDatePicker), forControlEvents: .TouchUpInside)
        
//        saveInfor.cornerRadius = favoritePlace.frame.size.width / 2
//        saveInfor.setTitleColor(UIColor.blueColor(), forState: .Normal)
//        saveInfor.backgroundColor = UIColor(red: 0.8, green: 0.6, blue: 0.7, alpha: 0.3)
//        saveInfor.rippleFromTapLocation = false
        
    }
    
    //# MARK: - remove all sub view from scroll view
    func clearScrollView() {
        for view in self.imagesScrollView.subviews {
            view.removeFromSuperview()
        }
    }

//    private func resizeImage(image: UIImage) -> UIImage {
//        
//        // Resize and crop to fit Apple watch (square for now, because it's easy)
//        let maxSize: CGFloat = 1080.0
//        var size: CGSize?
//        
//        if image.size.width >= image.size.height {
//            size = CGSizeMake((maxSize / image.size.height) * image.size.width, maxSize)
//        } else {
//            size = CGSizeMake(maxSize, (maxSize / image.size.width) * image.size.height)
//        }
//        
//        let hasAlpha = false
//  
//        
//        UIGraphicsBeginImageContextWithOptions(size!, !hasAlpha, scale)
//        
//        let rect = CGRect(origin: CGPointZero, size: size!)
//        UIRectClip(rect)
//        image.drawInRect(rect)
//        
//        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        return scaledImage
//    }
    
    @IBAction func editInfoPlace(sender: AnyObject) {
        done.hidden = false
        addMorePicture.enabled = true
        favoritePlace.enabled = true
    
    }
    
    @IBAction func doneAction(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        let dataImage = placePick!.images as! [String]
        print(nameImagesData)
        print("\(selectedImages.count)")
        print("\(placePick!.name)")
        if let _ = Place.updatePlace(managedObjectContext, name: (placePick?.name)!, date: (placePick?.date)!) {
            if let client = Dropbox.authorizedClient {
                if selectedImages.count != 0 {
                    for img in dataImage
                    {
                        client.files.delete(path: "\(img)")
                    }
                    
                    let currentDate = String(NSDate().timeIntervalSince1970)
                    let currenDateArr = currentDate.characters.split{$0 == "."}.map(String.init)
                    for i in 0 ... self.selectedImages.count - 1 {
                        let fileData = UIImageJPEGRepresentation(self.selectedImages[i], 1)
                         let fileNamePlaceEncode = self.placePick!.name.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
                        let filePath = "/\(fileNamePlaceEncode!)/\(currenDateArr[0])\(self.imageNames[i])"
                        client.files.upload(path: filePath, body: fileData!)
                        nameImagesData.append(filePath)
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
    
    func textViewDidBeginEditing(textView: UITextView) {
        placeholderLabel.hidden = true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        notePlaceData = notePlace.text
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}
