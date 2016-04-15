//
//  Place.swift
//  Mini-Project
//
//  Created by Nguyen Xuan Thai on 4/14/16.
//  Copyright © 2016 Thai. All rights reserved.
//

import Foundation
import CoreData
class Place: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var address: String
    @NSManaged var date: NSDate
    @NSManaged var images: AnyObject
    @NSManaged var favorite: Bool
    
    lazy var imagesString: [String]? = {
        if let imagesStr = self.images as? [String] {
            var strTemp = [String]()
            for image in imagesStr {
                let decodedData = NSData(base64EncodedString: image, options: NSDataBase64DecodingOptions(rawValue: 0))
                let decodedString = NSString(data: decodedData!, encoding: NSUTF8StringEncoding)
                strTemp.append(decodedString as! String)
            }
            return strTemp
        }
        return nil
    }()
    class func onCreateManagedObjectContext(moc: NSManagedObjectContext, name: String, address: String, date: NSDate, images: [String], favorite: Bool) -> Place {
        let place = NSEntityDescription.insertNewObjectForEntityForName("Place", inManagedObjectContext: moc) as! Place
            place.name = name
            place.address = address
            place.date = date
            place.images = images
            place.favorite = favorite
        return place
    }
    
    class func allPlace(moc: NSManagedObjectContext) -> [Place] {
        let fetchRequest = NSFetchRequest(entityName: "Place")
        if let fetchResult = (try? moc.executeFetchRequest(fetchRequest)) as? [Place] {
            return fetchResult
        }
        else {
            return []
        }
    }
    
    class func allFavorite(moc: NSManagedObjectContext) -> [Place] {
        let fetchRequest = NSFetchRequest(entityName: "Place")
        let predict = NSPredicate(format: "favorite == true")
        fetchRequest.predicate = predict
        if let fetchResult = (try? moc.executeFetchRequest(fetchRequest)) as? [Place] {
            return fetchResult
        }
        else {
            return []
        }
    }
}
