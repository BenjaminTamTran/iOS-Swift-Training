//
//  ViewController.swift
//  GetImage
//
//  Created by Nguyen Xuan Thai on 3/21/16.
//  Copyright © 2016 Tran Huu Tam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    var name: String!
    @IBOutlet weak var slider: UISlider!
    @IBAction func changeValueSlider(sender: AnyObject) {
        let idImage = Int(slider.value)
        name = "\(idImage).png"
        image.image = UIImage(named: name)
    }
    @IBAction func connectImage(sender: AnyObject) {
        let urlImage:NSURL = NSURL(string: "https://scontent-hkg3-1.xx.fbcdn.net/hphotos-xfa1/v/t1.0-9/12733394_742041542596646_260729146166174267_n.jpg?oh=db38c6c5e52134a8834f11e242216dd4&oe=574ADC2B")!
        let dataImage:NSData = NSData(contentsOfURL: urlImage)!
        image.image = UIImage(data: dataImage)
        print(image.image?.accessibilityIdentifier)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        slider.minimumValue = 1
        slider.maximumValue = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

