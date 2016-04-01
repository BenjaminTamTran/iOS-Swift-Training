//
//  TableViewController2.swift
//  de
//
//  Created by The Simple Studio on 31/3/16.
//  Copyright © 2016 The Simple Studio. All rights reserved.
//

import UIKit

class TableViewController2: UITableViewController {

        var a = ["cafe","gym","di an sang","di hoc", "an", "ngu"]
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return a.count
        }
        
        override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1
        }
        
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
            cell.textLabel?.text = a[indexPath.row]
            return cell
        }
}