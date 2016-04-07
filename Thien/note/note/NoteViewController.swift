//
//  NoteViewController.swift
//  note
//
//  Created by The Simple Studio on 7/4/16.
//  Copyright © 2016 The Simple Studio. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {

    @IBOutlet weak var tittleField: UITextField!
    @IBOutlet weak var DatePickerField: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAction(sender: AnyObject) {
        let noteItem = NoteItem(deadline: DatePickerField.date, title: tittleField.text! , UUID: NSUUID().UUIDString)
        NoteList.sharedInstance.addItem(noteItem) // schedule a local notification to persist this item
        self.navigationController?.popToRootViewControllerAnimated(true) // return to list view
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
