//
//  HistoryViewController.swift
//  Mini-Project
//
//  Created by Nguyen Xuan Thai on 4/15/16.
//  Copyright © 2016 Thai. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var historyTableView: UITableView!
    var historyPlace = [Place]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyPlace.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = historyPlace[indexPath.row].name
        return cell
    }
    
    func reloadData() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        historyPlace = Place.allPlace(managedObjectContext)
        historyTableView.reloadData()
    }
}
