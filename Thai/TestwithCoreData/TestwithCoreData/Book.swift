//
//  Book.swift
//  TestwithCoreData
//
//  Created by Nguyen Xuan Thai on 3/29/16.
//  Copyright © 2016 Thai. All rights reserved.
//

import Foundation
import CoreData

class Book: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var date: String
    @NSManaged var author: String
    @NSManaged var price: Float
    
    class func onCreateManagedObjectContext(moc: NSManagedObjectContext, name: String, date: String, author: String, price: Float) -> Book {
      let newBook = NSEntityDescription.insertNewObjectForEntityForName("Book", inManagedObjectContext: moc) as! Book
            newBook.name = name
            newBook.date = date
            newBook.author = author
            newBook.price = price
      return newBook
    }
    
    class func allBook(moc: NSManagedObjectContext) -> [Book] {
        let fetchRequest = NSFetchRequest(entityName: "Book")
            if let fetchResults = (try? moc.executeFetchRequest(fetchRequest)) as? [Book] {
                return fetchResults
            }
        return []
    }
    
    class func checkInfoBook(moc: NSManagedObjectContext, name: String, author: String) -> Bool {
        let fetchRequest = NSFetchRequest(entityName: "Book")
        let firstPredicate = NSPredicate(format: "name == '\(name)'")
        fetchRequest.predicate = firstPredicate
            if let fetchResults = (try? moc.executeFetchRequest(fetchRequest) as! [Book]) {
                for result in fetchResults {
                    if result.author == author {
                        return true
                    }
                }
            }
        return false
    }
}
