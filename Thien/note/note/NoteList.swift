//
//  NoteList.swift
//  note
//
//  Created by The Simple Studio on 7/4/16.
//  Copyright © 2016 The Simple Studio. All rights reserved.
//

import Foundation
import UIKit

class NoteList {
    class var sharedInstance : NoteList {
        struct Static {
            static let instance : NoteList = NoteList()
        }
        return Static.instance
    }
    private let ITEMS_KEY = "noteItems"
    
    func addItem(item: NoteItem) { // persist a representation of this todo item in NSUserDefaults
        var noteDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) ?? Dictionary()
        noteDictionary[item.UUID] = ["deadline": item.deadline, "title": item.title, "UUID": item.UUID]
        NSUserDefaults.standardUserDefaults().setObject(noteDictionary, forKey: ITEMS_KEY) // save/overwrite note item list
        
        // create a corresponding local notification
        let notification = UILocalNotification()
        notification.alertBody = "Note Item \"\(item.title)\" Is Overdue" // text that will be displayed in the notification
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        notification.fireDate = item.deadline // todo item due date (when notification will be fired)
        notification.soundName = "alarm.mp3" // play default sound
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func allItems() -> [NoteItem] {
        var todoDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) ?? [:]
        let items = Array(todoDictionary.values)
        return items.map({NoteItem(deadline: $0["deadline"] as! NSDate, title: $0["title"] as! String, UUID: $0["UUID"] as! String!)}).sort({(left: NoteItem, right:NoteItem) -> Bool in
            (left.deadline.compare(right.deadline) == .OrderedAscending)
        })
    }
}