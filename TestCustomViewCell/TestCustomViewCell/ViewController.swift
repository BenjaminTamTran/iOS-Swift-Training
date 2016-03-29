//
//  ViewController.swift
//  TestCustomViewCell
//
//  Created by Nguyen Xuan Thai on 3/28/16.
//  Copyright © 2016 Thai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomCell
        cell.photo.image = UIImage(named: "\(indexPath.row)")
        let backButton = tableView.viewWithTag(1)
        backButton?.hidden = false
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! CustomCell
        cell.superview?.bringSubviewToFront(cell)
        UIView.animateWithDuration(0.2, animations: {
        cell.frame = tableView.frame
            let backButton = tableView.viewWithTag(1)
            backButton?.hidden = false
           
        })
    }
}

