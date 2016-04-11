//
//  ViewController.swift
//  Mini-Project
//
//  Created by Nguyen Xuan Thai on 4/11/16.
//  Copyright © 2016 Thai. All rights reserved.
//

import UIKit
import GoogleMaps
import BFPaperButton
import HSDatePickerViewController
class ViewController: UIViewController, HSDatePickerViewControllerDelegate {
    var placePicker: GMSPlacePicker?
    @IBOutlet var favoritePlace: BFPaperButton!
    @IBOutlet var searchPlaceButton: BFPaperButton!
    @IBOutlet var placeLabel: UILabel!
    var test: Bool?
    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchPlace()
        // Mark custom Button 
        favoritePlace.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        favoritePlace.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
        favoritePlace.backgroundColor = UIColor(red: 1, green: 0, blue: 0.1, alpha: 0.5)
        favoritePlace.tapCircleColor = UIColor(red: 1, green: 0, blue: 1, alpha: 0.6)
        favoritePlace.isRaised = true
        favoritePlace.cornerRadius = favoritePlace.frame.size.width / 2
        favoritePlace.rippleFromTapLocation = false
        favoritePlace.rippleBeyondBounds = true
        favoritePlace.addTarget(self, action: #selector(ViewController.showDatePicker), forControlEvents: .TouchUpInside)
        
        searchPlaceButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        searchPlaceButton.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
        searchPlaceButton.backgroundColor = UIColor(red: 0.3, green: 0, blue: 1, alpha: 1)
        searchPlaceButton.tapCircleColor = UIColor(red: 1, green: 0, blue: 1, alpha: 0.6)
        searchPlaceButton.isRaised = true
        searchPlaceButton.cornerRadius = favoritePlace.frame.size.width / 2
        searchPlaceButton.rippleFromTapLocation = false
        searchPlaceButton.rippleBeyondBounds = true
        searchPlaceButton.addTarget(self, action: #selector(ViewController.searchPlace), forControlEvents: .TouchUpInside)
        //set image 
        imageView.image = UIImage(named: "cover")
        test = false
    }
    
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
                self.loadFirstPhotoForPlace(place.placeID)
            } else {
                self.placeLabel.text = "No place selected"
            }
        })
    }
    

    func showDatePicker() {
        if test == true {
        let hsdpvc: HSDatePickerViewController = HSDatePickerViewController()
        hsdpvc.mainColor = UIColor.yellowColor()
        hsdpvc.delegate = self
        self.presentViewController(hsdpvc, animated: true, completion: { _ in })
        }
    }
    
    func hsDatePickerPickedDate(date: NSDate!) {
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "hh:mm:ss"
        
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
                    self.test = true
                }
                else {
                    let alert = UIAlertController(title: "Search Image", message: "Don't have image for this place", preferredStyle: .Alert)
                    let action = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                    alert.addAction(action)
                    self.test = false
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
                                 //   self.attributionTextView.attributedText = photoMetadata.attributions;
                                }
        }
    }

}

