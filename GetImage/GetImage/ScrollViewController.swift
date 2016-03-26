//
//  ScrollViewController.swift
//  GetImage
//
//  Created by Nguyen Xuan Thai on 3/24/16.
//  Copyright © 2016 Tran Huu Tam. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var imagesScrollView: UIScrollView!
    @IBOutlet weak var leftScroll: UIScrollView!
    @IBOutlet weak var rightLeft: UIScrollView!
    
    @IBOutlet weak var stateSwichLabel: UILabel!
    @IBAction func switchImage(sender: AnyObject) {
        if changValue.on {
            stateSwichLabel.text = "this is ON"
        } else {
            stateSwichLabel.text = "this is OFF"
        }
    }
    
    @IBOutlet weak var changValue: UISwitch!
    
    let imageLinks = ["https://scontent-hkg3-1.xx.fbcdn.net/hphotos-xlp1/v/t1.0-9/12472749_568466789993652_8216295738541791938_n.jpg?oh=283e23269439f675a773908b62cc4d89&oe=57965F97","https://scontent-hkg3-1.xx.fbcdn.net/hphotos-xat1/v/t1.0-9/12239465_904231149626647_3015878544717036090_n.jpg?oh=0e356192467a273ed420bb22d74c3f9a&oe=578C32BF","https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTkj_TGB_FvCN3u3hO439k6VC6Q7USOKMMh58U-oS5OMKrpSg-f","https://scontent-hkg3-1.xx.fbcdn.net/hphotos-xla1/v/t1.0-9/1937023_1013089402083696_9185283873593392702_n.jpg?oh=c98c68f2087d86b007f5d6448f7612e8&oe=5793D16E","https://scontent-hkg3-1.xx.fbcdn.net/hphotos-xlp1/v/t1.0-9/1689390_524628787742199_3272910022991120694_n.jpg?oh=acf76ea4b3e1a979e755ceff8d412287&oe=57871FB1","https://scontent-hkg3-1.xx.fbcdn.net/hphotos-xpf1/v/t1.0-9/12799400_866825646761787_3500655124581140777_n.jpg?oh=88adf7b6f58d90a0ea88624716477b0c&oe=5785E977","https://scontent-hkg3-1.xx.fbcdn.net/hphotos-xap1/v/t1.0-9/10623115_10207073946500366_6212775012592475720_n.jpg?oh=ca934cef038d57043d57d9458d1a4e2e&oe=5783F3D5","https://scontent-hkg3-1.xx.fbcdn.net/hphotos-xft1/v/t1.0-9/12472366_10207073946140357_9116418827584952418_n.jpg?oh=9b13536e57b38c6d2de978c8f5fa1825&oe=578D0AA2","https://scontent-hkg3-1.xx.fbcdn.net/hphotos-xfa1/v/t1.0-9/10391523_245937075751190_1139408424572713290_n.jpg?oh=acc8d7742ccf84c040d01edc208a6023&oe=57802830","https://scontent-hkg3-1.xx.fbcdn.net/hphotos-xfl1/v/t1.0-9/941060_1062323067157290_1747570421186188962_n.jpg?oh=ae40f0d09bf36b68076be930f4b6d8dc&oe=577E64E6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       loadImage()
        changValue.on = true
        if changValue.on {
            stateSwichLabel.text = "this is ON"
        } else {
            stateSwichLabel.text = "this is OFF"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadImage(){
        var spaceWidth: CGFloat = 20
        for link in imageLinks {
            let imageView = UIImageView (frame: CGRectMake(spaceWidth,10, imagesScrollView.frame.width - 20, imagesScrollView.frame.height - 20))
            let url: NSURL = NSURL(string: link)!
            let data: NSData = NSData(contentsOfURL: url)!
            imageView.image = UIImage(data: data)
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            imagesScrollView.addSubview(imageView)
            spaceWidth += imagesScrollView.frame.width
        }
        var contentSize = imagesScrollView.contentSize
        contentSize.width = 10 * imagesScrollView.frame.width
        imagesScrollView.contentSize = contentSize
        
//        var spaceWidth: CGFloat = 20
//        for link in imageLinks {
//            let imageView = UIImageView (frame: CGRectMake(spaceWidth,10, imagesScrollView.frame.width - 20, imagesScrollView.frame.height - 20))
//            let url: NSURL = NSURL(string: link)!
//            let data: NSData = NSData(contentsOfURL: url)!
//            imageView.image = UIImage(data: data)
//            imageView.contentMode = UIViewContentMode.ScaleAspectFit
//            imagesScrollView.addSubview(imageView)
//            spaceWidth += imagesScrollView.frame.width
//        }
//        var contentSize = imagesScrollView.contentSize
//        contentSize.width = 10 * imagesScrollView.frame.width
//        imagesScrollView.contentSize = contentSize
//        
//        var spaceWidth: CGFloat = 20
//        for link in imageLinks {
//            let imageView = UIImageView (frame: CGRectMake(spaceWidth,10, imagesScrollView.frame.width - 20, imagesScrollView.frame.height - 20))
//            let url: NSURL = NSURL(string: link)!
//            let data: NSData = NSData(contentsOfURL: url)!
//            imageView.image = UIImage(data: data)
//            imageView.contentMode = UIViewContentMode.ScaleAspectFit
//            imagesScrollView.addSubview(imageView)
//            spaceWidth += imagesScrollView.frame.width
//        }
//        var contentSize = imagesScrollView.contentSize
//        contentSize.width = 10 * imagesScrollView.frame.width
//        imagesScrollView.contentSize = contentSize
        
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        //
        print("scrollViewWillBeginDecelerating")
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        print("scrollViewWillBeginDragging")
    }

}



















