//
//  PlaceListViewController.swift
//  Mini-Project
//
//  Created by Tran Huu Tam on 4/15/16.
//  Copyright © 2016 The Simple Studio. All rights reserved.
//

import UIKit

class PlaceListViewControllerr: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Mark: UI's elements
    @IBOutlet var historyTableView: UITableView!
    
    
    // Mark: Class's properties
    var historyPlace = [Place]()
    
    
    // Mark: Application's life cirlce
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        reloadData()
    }
    
    // Mark: class's private methods
    private func initialize() {
        
    }
    
    private func reloadData() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        historyPlace = Place.allPlace(managedObjectContext)
        historyTableView.reloadData()
    }
    
    // MARK: Button Action
    
    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyPlace.count
    }
    
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) 
        cell.textLabel?.text = historyPlace[indexPath.row].name
        return cell
    }
}
