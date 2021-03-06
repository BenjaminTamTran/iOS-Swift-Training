//
//  FavoriteViewController.swift
//  Mini-Project
//
//  Created by Nguyen Xuan Thai on 4/11/16.
//  Copyright © 2016 Thai. All rights reserved.
//

import UIKit
import SwiftyDropbox
class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var place: Place?
    @IBOutlet weak var favouriteBarItem: UITabBarItem!
    var places = [Place]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        favouriteBarItem.setFAIcon(FAType.FABookmarkO)
        reloadData()
    }
    
    
    @IBOutlet var favoriteTableView: UITableView!
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! PlacesTableViewCell
        cell.namePlace.text = places[indexPath.row].name
        cell.timeVisit.text = places[indexPath.row].date.toShortTimeString()
        
//        cell.imagePlace.image = UIImage(data: places[indexPath.row].imgTravel)
        
        if let imagePlaceData = places[indexPath.row].imgTravel {
            cell.imagePlace.image = UIImage(data: imagePlaceData)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        place = places[indexPath.row]
        self.performSegueWithIdentifier("favouriteShowPlaceSegue", sender: self)
//        let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("placeViewController") as! PlaceViewController
//        viewController.placePick = place
//        self.presentViewController(viewController, animated: true, completion: nil)

    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let _ = appDelegate.managedObjectContext
            places[indexPath.row].favorite = false
            places.removeAtIndex(indexPath.row)
            favoriteTableView.reloadData()
            appDelegate.saveContext()
          
        }
    }
    func reloadData() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        places = Place.allFavorite(managedObjectContext)
        favoriteTableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "favouriteShowPlaceSegue" {
            if let vc = segue.destinationViewController as? PlaceViewController {
                vc.placePick = place
            }
            
        }
    }

}
