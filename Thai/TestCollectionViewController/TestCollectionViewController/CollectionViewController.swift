//
//  CollectionViewController.swift
//  TestCollectionViewController
//
//  Created by Nguyen Xuan Thai on 3/27/16.
//  Copyright © 2016 Thai. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionViewCell
        cell.image("\(indexPath.row).png")
        let backButton = cell.viewWithTag(1) as! UIButton
        backButton.hidden = true
        return cell
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        cell!.superview!.bringSubviewToFront(cell!)
        UIView.animateWithDuration(0.2, animations: {
        let backButton = cell!.viewWithTag(1) as! UIButton
        backButton.hidden = false
        cell?.frame = collectionView.frame
        backButton.addTarget(self, action: "backAction", forControlEvents: UIControlEvents.TouchUpInside)
        })
    }
    func backAction() {
       let indexPath = (collectionView?.indexPathsForSelectedItems())! as [NSIndexPath]
        collectionView?.reloadItemsAtIndexPaths(indexPath)
        
    }
}
