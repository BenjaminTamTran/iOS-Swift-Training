//
//  ViewController.swift
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
class ViewController: UIViewController, HSDatePickerViewControllerDelegate {
    var placePicker: GMSPlacePicker?
    @IBOutlet var favoritePlace: BFPaperButton!
    @IBOutlet var searchPlaceButton: BFPaperButton!
    @IBOutlet var addMorePicture: BFPaperButton!
    @IBOutlet var addPlaceDate: BFPaperButton!
    @IBOutlet var saveInfor: BFPaperButton!
    @IBOutlet var imagesScrollView: UIScrollView!
    
    @IBOutlet var placeLabel: UILabel!
    var test: Bool?
    var selectedImages = [UIImage]()
    var imageNames = [String]()
    var favorite: Bool?
    var dateVisit: NSDate?
    var namePlace: String?
    var addressPlace: String?
    var places = [Place]()
    var nameImagesData = [String]()
    @IBOutlet var imageView: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton()
        //set image
        imageView.image = UIImage(named: "cover")
//        initStackView()
//         status button when no search
        saveInfor.enabled = false
        addMorePicture.enabled = false
        addPlaceDate.enabled = false
        favorite = false
    }
    
//    func initStackView() {
//        self.stackImagePicked.axis = .Horizontal
//        self.stackImagePicked.distribution = .FillEqually
//        self.stackImagePicked.alignment = .Fill
//        self.stackImagePicked.spacing = 10
//        self.stackImagePicked.translatesAutoresizingMaskIntoConstraints = false
//    }
    
    func searchPlace() {
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
                self.addMorePicture.enabled = true
                self.saveInfor.enabled = true
                self.addPlaceDate.enabled = true
            } else {
                self.placeLabel.text = "No place selected"
                self.addMorePicture.enabled = false
                self.clearScrollView()
                self.saveInfor.enabled = false
                self.addPlaceDate.enabled = false
            }
        })
    }
    

    func showDatePicker() {
        let hsdpvc: HSDatePickerViewController = HSDatePickerViewController()
        hsdpvc.mainColor = UIColor.yellowColor()
        hsdpvc.delegate = self
        self.presentViewController(hsdpvc, animated: true, completion: { _ in })
    }
    
    func hsDatePickerPickedDate(date: NSDate!) {
       dateVisit = date
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        favoritePlace.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        favoritePlace.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
        favoritePlace.backgroundColor = UIColor(red: 1, green: 0, blue: 0.1, alpha: 0.5)
        favoritePlace.tapCircleColor = UIColor(red: 1, green: 0, blue: 1, alpha: 0.6)
        favoritePlace.isRaised = true
        favoritePlace.cornerRadius = favoritePlace.frame.size.width / 2
        favoritePlace.rippleFromTapLocation = false
        favoritePlace.rippleBeyondBounds = true
        
        
        searchPlaceButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        searchPlaceButton.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
        searchPlaceButton.backgroundColor = UIColor(red: 0.3, green: 0, blue: 1, alpha: 1)
        searchPlaceButton.tapCircleColor = UIColor(red: 1, green: 0, blue: 1, alpha: 0.6)
        searchPlaceButton.isRaised = true
        searchPlaceButton.cornerRadius = favoritePlace.frame.size.width / 2
        searchPlaceButton.rippleFromTapLocation = false
        searchPlaceButton.rippleBeyondBounds = true
        searchPlaceButton.addTarget(self, action: #selector(ViewController.searchPlace), forControlEvents: .TouchUpInside)
        
        addMorePicture.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.1, alpha: 0.3)
        addMorePicture.setTitleColor(UIColor.blueColor(), forState: .Normal)
        addMorePicture.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
        
        addPlaceDate.backgroundColor = UIColor(red: 0.8, green: 0.1, blue: 0.7, alpha: 0.3)
        addPlaceDate.setTitleColor(UIColor.blueColor(), forState: .Normal)
        addPlaceDate.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
        addPlaceDate.addTarget(self, action: #selector(ViewController.showDatePicker), forControlEvents: .TouchUpInside)
        
        saveInfor.cornerRadius = favoritePlace.frame.size.width / 2
        saveInfor.setTitleColor(UIColor.blueColor(), forState: .Normal)
        saveInfor.backgroundColor = UIColor(red: 0.8, green: 0.6, blue: 0.7, alpha: 0.3)
        saveInfor.rippleFromTapLocation = false
        
    }
    
    //# MARK: - remove all sub view from scroll view
    func clearScrollView() {
        for view in self.imagesScrollView.subviews {
            view.removeFromSuperview()
        }
    }
    
    //# MARK: -Action when touch up inside AddMorePicture button
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
    
    //#MARK: Event save touch up inside
    @IBAction func saveEventAction(sender: AnyObject) {
        let currentDate = String(NSDate().timeIntervalSince1970)
        let currenDateArr = currentDate.characters.split{$0 == "."}.map(String.init)
            if let client = Dropbox.authorizedClient {
                for i in 0 ... self.selectedImages.count - 1 {
                    let fileData = UIImageJPEGRepresentation(self.selectedImages[i], 1)
                     client.files.upload(path: "/\(self.namePlace!)/ \(currenDateArr[0])_\(self.imageNames[i])", body: fileData!)
                    let nameImageData = "\(self.namePlace!)/ \(currenDateArr[0])_\(self.imageNames[i])"
                    print("\(nameImageData)")
                    let plainData = (nameImageData as NSString).dataUsingEncoding(NSUTF8StringEncoding)
                    let base64String = plainData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
                    self.nameImagesData.append(base64String)
                }
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let managedObjectContext = appDelegate.managedObjectContext
                Place.onCreateManagedObjectContext(managedObjectContext, name: namePlace!, address: self.addressPlace!, date: self.dateVisit!, images: self.nameImagesData, favorite: self.favorite!)
                appDelegate.saveContext()
        
            }
            else {
                   Dropbox.authorizeFromController(self)
            }
    }
    
    @IBAction func favoriteAction(sender: AnyObject) {
        favorite = true
    }
    
}


extension PHAsset {
    
    var originalFilename: String? {
        
        var fname:String?
        
        if #available(iOS 9.0, *) {
            let resources = PHAssetResource.assetResourcesForAsset(self)
            if let resource = resources.first {
                fname = resource.originalFilename
            }
        }
        
        if fname == nil {
            // this is an undocumented workaround that works as of iOS 9.1
            fname = self.valueForKey("filename") as? String
        }
        
        return fname
    }
}
