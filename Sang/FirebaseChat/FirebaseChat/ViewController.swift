//
//  ViewController.swift
//  FirebaseChat
//
//  Created by The Simple Studio on 13/4/16.
//  Copyright © 2016 The Simple Studio. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textField: UITextField!
    var ref: Firebase!
    
    
    @IBAction func btnSend(sender: AnyObject) {
        ref = Firebase(url: "https://xxaa.firebaseio.com/posts")

        ref.childByAutoId().setValue([
            "author": textField.text,
            "title": textView.text,
            
            ])

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

