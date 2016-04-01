//
//  TableTableViewController.swift
//  de
//
//  Created by The Simple Studio on 31/3/16.
//  Copyright © 2016 The Simple Studio. All rights reserved.
//

import UIKit

class TableTableViewController: UITableViewController {
    var a = ["cafe","gym","di an sang","di hoc", "an", "ngu"]

    override func viewDidLoad() {
        
        super.viewDidLoad()
            // Make the row height dynamic
            tableView.estimatedRowHeight = tableView.rowHeight
            tableView.rowHeight = UITableViewAutomaticDimension
            
            // the first screen of the app
            // if walkthroughs haven't been shown, let's show the walkthroughs
            displayWalkthroughs()
        }
        
        func displayWalkthroughs()
        {
            // check if walkthroughs have been shown
            let userDefaults = NSUserDefaults.standardUserDefaults()
            let displayedWalkthrough = userDefaults.boolForKey("DisplayedWalkthrough")
            
            // if we haven't shown the walkthroughs, let's show them
            if !displayedWalkthrough {
                // instantiate neew PageVC via storyboard
                if let pageViewController = storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as? PageViewController {
                    self.presentViewController(pageViewController, animated: true, completion: nil)
                }
            }
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


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
