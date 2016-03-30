//
//  ViewController.swift
//  ImageScrollView
//
//  Created by tranquocsang on 3/28/16.
//  Copyright © 2016 tranquocsang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var imgScrollLeft: UIScrollView!
    @IBOutlet weak var imgScroll: UIScrollView!
    @IBOutlet weak var imgScrollRight: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ScrollViewUpdate()
        //start timer
        NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(ViewController.timerTimeout(_:)), userInfo: nil, repeats: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func timerTimeout(timer : NSTimer){
        imgScrollLeft.contentOffset.x = imgScroll.contentOffset.x
        imgScrollRight.contentOffset.x = imgScroll.contentOffset.x
    }
    
    func ScrollViewUpdate()
    {
        var spaceWidth:CGFloat = 20
        let ImageData = ["img 1", "img 2", "img 3", "img 4","img 5"]
        let ImageDataL = ["img 5", "img 1", "img 2", "img 3", "img 4"]
        let ImageDataR = ["img 2", "img 3", "img 4","img 5", "img 1"]
        
        //init scroll view left
        for img in ImageDataL {
            let imageView = UIImageView (frame: CGRectMake(spaceWidth,10, imgScrollLeft.frame.width - 20, imgScrollLeft.frame.height ))
            imageView.image = UIImage(named: img)
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            imgScrollLeft.addSubview(imageView)
            spaceWidth += imgScrollLeft.frame.width
        }
        var  contentSize = imgScrollLeft.contentSize
        contentSize.width = 5 * imgScrollLeft.frame.width
        imgScrollLeft.contentSize = contentSize
        imgScrollLeft.scrollEnabled = false
        
        //init scroll view right
        spaceWidth = 20
        for img in ImageDataR {
            let imageView = UIImageView (frame: CGRectMake(spaceWidth,10, imgScrollRight.frame.width - 20 , imgScrollRight.frame.height ))
            imageView.image = UIImage(named: img)
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            imgScrollRight.addSubview(imageView)
            spaceWidth += imgScrollRight.frame.width
        }
        contentSize = imgScrollRight.contentSize
        contentSize.width = 5 * imgScrollRight.frame.width
        imgScrollRight.contentSize = contentSize
        imgScrollRight.scrollEnabled = false
        
        //init scroll view center
        spaceWidth = 20
        for img in ImageData {
            let imageView = UIImageView (frame: CGRectMake(spaceWidth,10, imgScroll.frame.width - 20 , imgScroll.frame.height ))
            imageView.image = UIImage(named: img)
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            imgScroll.addSubview(imageView)
            spaceWidth += imgScroll.frame.width
        }
        contentSize = imgScroll.contentSize
        contentSize.width = 5 * imgScroll.frame.width
        imgScroll.contentSize = contentSize
        
    }

}

