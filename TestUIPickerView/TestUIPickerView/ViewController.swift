//
//  ViewController.swift
//  TestUIPickerView
//
//  Created by Nguyen Xuan Thai on 3/28/16.
//  Copyright © 2016 Thai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var colorArray = ["green","blue","white","brown","yellow","red","purple"]
    // MARK 
    @IBOutlet weak var pickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


     func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return colorArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int,
        forComponent component: Int) -> String? {
            return colorArray[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
        self.view.backgroundColor = UIColor.greenColor()
        } else if row == 1 {
        self.view.backgroundColor = UIColor.blueColor()
        } else if row == 2 {
        self.view.backgroundColor = UIColor.whiteColor()
        } else if row == 3 {
        self.view.backgroundColor = UIColor.brownColor()
        } else if row == 4 {
        self.view.backgroundColor = UIColor.yellowColor()
        } else if row == 5 {
        self.view.backgroundColor = UIColor.redColor()
        } else if row == 6 {
        self.view.backgroundColor = UIColor.purpleColor()
        }
            
    }
}

