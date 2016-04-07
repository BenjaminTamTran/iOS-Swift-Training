//
//  noteItem.swift
//  note
//
//  Created by The Simple Studio on 7/4/16.
//  Copyright © 2016 The Simple Studio. All rights reserved.
//

import Foundation

struct NoteItem {
    var title: String
    var deadline: NSDate
    var UUID: String
    
    init(deadline: NSDate, title: String, UUID: String) {
        self.deadline = deadline
        self.title = title
        self.UUID = UUID
    }
    
    var isOverdue: Bool {
        return (NSDate().compare(self.deadline) == NSComparisonResult.OrderedDescending) // deadline is earlier than current date
    }
}