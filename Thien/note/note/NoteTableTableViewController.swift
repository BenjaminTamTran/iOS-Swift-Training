//
//  NoteTableTableViewController.swift
//  note
//
//  Created by The Simple Studio on 7/4/16.
//  Copyright © 2016 The Simple Studio. All rights reserved.
//

import UIKit

class NoteTableTableViewController: UITableViewController {
    var noteItems: [NoteItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

 

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return noteItems.count
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        noteItems = NoteList.sharedInstance.allItems()
        tableView.reloadData()
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell // retrieve the prototype cell (subtitle style)
        
        let noteItem = noteItems[indexPath.row] as NoteItem
        cell.textLabel?.text = noteItem.title as String!
        if (noteItem.isOverdue) { // the current time is later than the to-do item's deadline
            cell.detailTextLabel?.textColor = UIColor.redColor()
        } else {
            cell.detailTextLabel?.textColor = UIColor.blackColor() // we need to reset this because a cell with red subtitle may be returned by dequeueReusableCellWithIdentifier:indexPath:
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "'Due' MMM dd 'at' h:mm a" // example: "Due Jan 01 at 12:00 PM"
        cell.detailTextLabel?.text = dateFormatter.stringFromDate(noteItem.deadline)
        
        return cell

    }
    
   
}
