//
//  DatePickerViewController.swift
//  TestUIPickerView
//
//  Created by Nguyen Xuan Thai on 3/29/16.
//  Copyright © 2016 Thai. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBAction func seenTime(sender: AnyObject) {
        let timeLeft = datePickerView.date.timeIntervalSinceNow
        timeLabel.text = timeLeft.time
    }
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var datePickerView: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension NSTimeInterval {
    var time:String {
        return String(format:"%02d day %02d hour %02d min  %02d seconds", Int((self/86400)), Int((self/3600.0)%24), Int((self/60.0)%60), Int((self)%60))
    }
}