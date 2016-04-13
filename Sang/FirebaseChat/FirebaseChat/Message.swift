//
//  File.swift
//  FirebaseChat
//
//  Created by The Simple Studio on 13/4/16.
//  Copyright © 2016 The Simple Studio. All rights reserved.
//

import Foundation

class Message : NSObject {
    var text_: String
    var sender_: String
    var date_: NSDate
    
    init(text: String?, sender: String?) {
        self.text_ = text!
        self.sender_ = sender!
        self.date_ = NSDate()
    }
    
    func text() -> String! {
        return text_;
    }
    
    func sender() -> String! {
        return sender_;
    }
    
    func date() -> NSDate! {
        return date_;
    }
    
}