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
    @IBOutlet var placesTableView: UITableView!
    @IBOutlet weak var addPlaceButton: UIButton!
    @IBOutlet weak var placeTabBarItem: UITabBarItem!
    
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
        addPlaceButton.setFAIcon(FAType.FAPlus, forState: UIControlState.Normal)
        placeTabBarItem.setFAIcon(FAType.FAMapPin)
    }
    
    private func reloadData() {
        let managedObjectContext = appDelegate.managedObjectContext
        historyPlace = Place.allPlace(managedObjectContext)
        placesTableView.reloadData()
    }
    
    // MARK: Button Action
    @IBAction func addPlace(sender: AnyObject) {
        self.performSegueWithIdentifier("showPlaceSegue", sender: self)
    }
    
    
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
