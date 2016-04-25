//
//  Place.swift
//  Mini-Project
//
//  Created by Nguyen Xuan Thai on 4/14/16.
//  Copyright © 2016 Thai. All rights reserved.
//

import Foundation
import CoreData
import GoogleMaps
class Place: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var address: String
    @NSManaged var date: NSDate
    @NSManaged var images: AnyObject
    @NSManaged var favorite: Bool
    @NSManaged var imgTravel: NSData
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var web: String?

    lazy var webURL: NSURL? = {
        if let str = self.web {
            return NSURL(fileURLWithPath: str)
        }
        return nil
    }()
//    lazy var imagesString: [String]? = {
//        if let imagesStr = self.images as? [String] {
//            var strTemp = [String]()
//            for image in imagesStr {
//                let decodedData = NSData(base64EncodedString: image, options: NSDataBase64DecodingOptions(rawValue: 0))
//                let decodedString = NSString(data: decodedData!, encoding: NSUTF8StringEncoding)
//                strTemp.append(decodedString as! String)
//            }
//            return strTemp
//        }
//        return nil
//    }()
    class func onCreateManagedObjectContext(moc: NSManagedObjectContext, name: String, address: String, date: NSDate, images: [String], favorite: Bool, imgTravel: NSData, longitude: Double, latitude: Double, web: NSURL?) -> Place {
        let place = NSEntityDescription.insertNewObjectForEntityForName("Place", inManagedObjectContext: moc) as! Place
            place.name = name
            place.address = address
            place.date = date
            place.images = images
            place.favorite = favorite
            place.imgTravel = imgTravel
            place.latitude = latitude
            place.longitude = longitude
            if let web = web {
                place.web = web.absoluteString
            }
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
    
    class func updatePlace(moc: NSManagedObjectContext, name: String, date: NSDate) -> Place? {
        let fetchRequest = NSFetchRequest(entityName: "Place")
        let predict = NSPredicate(format: "(name == %@) AND (date == %@)","\(name)",date)
        fetchRequest.predicate = predict
        if let fetchResults = (try? moc.executeFetchRequest(fetchRequest)) as? [Place] {
//            print("\(fetchResults.first?.images)")
            print("\(fetchResults.first?.favorite)")
            return fetchResults.first!
        }
        return nil
    }
}
