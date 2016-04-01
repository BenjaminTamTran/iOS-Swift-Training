//
//  ViewController.swift
//  TestwithCoreData
//
//  Created by Nguyen Xuan Thai on 3/29/16.
//  Copyright © 2016 Thai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var name: UITextField!
    @IBOutlet var author: UITextField!
    @IBOutlet var date: UITextField!
    @IBOutlet var price: UITextField!

    @IBAction func save(sender: AnyObject) {
        let priceBook = price.text?.floatValue
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        if Book.checkInfoBook(managedObjectContext, name: name.text!, author: author.text!) == true {
                let alert = UIAlertController(title: "Error", message: "this book already exists", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
           }else {
                Book.onCreateManagedObjectContext(managedObjectContext, name: name.text!, date: date.text!, author: author.text!, price: priceBook!)
                appDelegate.saveContext()
            }
        name.text = ""
        author.text = ""
        date.text = ""
        price.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.autocorrectionType = .No
        author.autocorrectionType = .No
        date.autocorrectionType = .No
        price.autocorrectionType = .No
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

    extension String {
        var floatValue: Float {
            return (self as NSString).floatValue
        }
    }

