//
//  fgh.swift
//  demoTableView2
//
//  Created by The Simple Studio on 30/3/16.
//  Copyright © 2016 The Simple Studio. All rights reserved.
//

import UIKit

class PhotosTableViewController: UITableViewController
{
    // MARK: - Data Source
    var photos = Photo.downloadAllPhotos()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 250.0
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print(photos.count)
        return photos.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! PhotoTableViewCell
        let photo = photos[indexPath.row]
      
        cell.photo = photo
        //    cell.updateUI()
        
        
        return cell
    }
    
}
