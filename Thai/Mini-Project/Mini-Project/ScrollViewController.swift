//
//  ScrollViewController.swift
//  Travel Sticky
//
//  Created by Nguyen Xuan Thai on 4/27/16.
//  Copyright © 2016 Thai. All rights reserved.
//

import UIKit
import CPImageViewer
class ScrollViewController: UIViewController, UIScrollViewDelegate {
    
    
   @IBOutlet var scrollView: UIScrollView!
    
    var imageArray = [UIImage]()
    var indext: Int?
    @IBAction func backButton(sender: AnyObject) {
       self.navigationController?.popViewControllerAnimated(true)
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        loadImage()
    }
    
    func loadImage() {
      clearScrollView()
      var xCoordinate: CGFloat = 10
      for image in imageArray {
        let animationImageView = UIImageView(frame: CGRectMake(xCoordinate, 10, self.scrollView.frame.width - 20, self.scrollView.frame.height - 20))
        animationImageView.image = image
        animationImageView.contentMode = UIViewContentMode.ScaleAspectFit
        animationImageView.layer.cornerRadius = 11.0
        animationImageView.clipsToBounds = false
        self.scrollView.addSubview(animationImageView)
        
        xCoordinate += self.scrollView.frame.width
        }
        let position = CGFloat(indext!) * scrollView.frame.width
        let scrollPoint = CGPointMake(position, 0.0)
        self.scrollView.setContentOffset(scrollPoint, animated: false)
        var contentSize = self.scrollView.contentSize
        let width = CGFloat(imageArray.count)
        contentSize.width = width * self.scrollView.frame.width
        self.scrollView.contentSize = contentSize
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.flashScrollIndicators()
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 10.0
        
    }
    
    func clearScrollView() {
        for view in self.scrollView.subviews {
            view.removeFromSuperview()
        }
    }
//    
//    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
//        
////        self.
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
