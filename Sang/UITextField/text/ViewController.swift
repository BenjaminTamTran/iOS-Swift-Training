//
//  ViewController.swift
//  text
//
//  Created by tranquocsang on 3/29/16.
//  Copyright © 2016 tranquocsang. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate
{
 
    @IBOutlet weak var textEntered: UITextField!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var textID: UITextField!
    
    @IBAction func btnPressed(sender: AnyObject) {
        //textEntered.resignFirstResponder()
        if(textEntered.text == "12345" && textID.text == "12345")
        {
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("settingsVC") as!     LoginResultFormViewController
            self.presentViewController(vc, animated: true, completion: nil)
        }else
        {
            label1.text = "Wrong ID or Password !!"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

// UITextField Delegates
    func textFieldDidBeginEditing(textField: UITextField) {
        print("TextField did begin editing method called")
    }
    func textFieldDidEndEditing(textField: UITextField) {
            print("TextField did end editing method called")
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        print("TextField should begin editing method called")
        return true;
        }
    func textFieldShouldClear(textField: UITextField) -> Bool {
        print("TextField should clear method called")
        return true;
    }
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        print("TextField should snd editing method called")
        return true;
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        print("While entering the characters this method gets called")
        return true;
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("TextField should return method called")
        textField.resignFirstResponder();
        return true;
    }
}