//
//  ViewController.swift
//  UserActivityandImagePicker
//
//  Created by tranquocsang on 4/6/16.
//  Copyright © 2016 tranquocsang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    @IBOutlet weak var bottomMenu: UIStackView!
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var imageView: UIImageView!

    
    @IBAction func onNewPhoto(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Using Camera", style: .Default, handler: { action in
            self.showCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "From Album", style: .Default, handler: { action in
            self.showAlbum()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
        
        
    }
    
    func showCamera(){
        let CameraPicker = UIImagePickerController()
        CameraPicker.delegate = self
        CameraPicker.sourceType = .Camera
        
        self.presentViewController(CameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum(){
        let ImgPicker = UIImagePickerController()
        ImgPicker.delegate = self
        ImgPicker.sourceType = .PhotoLibrary
        
        self.presentViewController(ImgPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func filterCliked(sender: UIButton) {
        if (sender.selected)
        {
            sender.selected = false
            UIView.animateWithDuration(0.4, animations: {
                self.secondaryMenu.alpha = 0
                }, completion: {completed in
                    self.secondaryMenu.removeFromSuperview()
            })
        }else{
            showSubMenu()
            sender.selected = true
        }
    }
    
    func showSubMenu(){
        
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.5, animations: {
            self.secondaryMenu.alpha = 1
        })
    }
    
    @IBAction func onShare(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil)
//        activityController.excludedActivityTypes = [        //UIActivityTypePostToWeibo,
//                                                            //UIActivityTypeMessage,
//                                                            UIActivityTypeMail,
//                                                            UIActivityTypePrint,
//                                                            //UIActivityTypeCopyToPasteboard,
//                                                            //UIActivityTypeAssignToContact,
//                                                            //UIActivityTypeSaveToCameraRoll,
//                                                            //UIActivityTypeAddToReadingList,
//                                                            UIActivityTypePostToFlickr,
//                                                            //UIActivityTypePostToVimeo,
//                                                            //UIActivityTypePostToTencentWeibo,
//                                                            //UIActivityTypeAirDrop,
//                                                            //UIActivityTypePostToFacebook
//                                                    ];
        
        self.presentViewController(activityController, animated: true, completion: nil)
    }
    
    @IBAction func onRedFilter(sender: AnyObject) {
        let processor: ImageProcessor = ImageProcessor()
        processor.addFilterToSequence("redFilter")
        let image = processor.appyFilters(imageView.image!)
            imageView.image = image
    }
    
    @IBAction func onGreenFilter(sender: AnyObject) {
        let processor: ImageProcessor = ImageProcessor()
        processor.addFilterToSequence("greenFilter")
        let image = processor.appyFilters(imageView.image!)
        imageView.image = image
    }
    
    @IBAction func onBlueFilter(sender: AnyObject) {
        let processor: ImageProcessor = ImageProcessor()
        processor.addFilterToSequence("blueFilter")
        let image = processor.appyFilters(imageView.image!)
        imageView.image = image
    }
    
    @IBAction func onYellowFilter(sender: AnyObject) {
        let processor: ImageProcessor = ImageProcessor()
        processor.addFilterToSequence("yellowFilter")
        let image = processor.appyFilters(imageView.image!)
        imageView.image = image
    }
    
    @IBAction func onAlphaFilter(sender: AnyObject) {
        let processor: ImageProcessor = ImageProcessor()
        processor.addFilterToSequence("alphaFilter")
        let image = processor.appyFilters(imageView.image!)
        imageView.image = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
    }

}

