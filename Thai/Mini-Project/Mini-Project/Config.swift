//
//  Config.swift
//  Travel Sticky
//
//  Created by Tran Huu Tam on 4/16/16.
//  Copyright © 2016 Thai. All rights reserved.
//

import Foundation
import UIKit

let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
let dayOfWeek = [ "1":"SUN", "2":"MON", "3":"TUE", "4":"WED" , "5":"THUR", "6":"FRI", "7":"SAT" ]
let dayOfWeekFull = [ "SUN":"Sunday", "MON":"Monday", "TUE":"Tuesday", "WED":"Wednesday" , "THUR":"Thursday", "FRI":"Firday", "SAT":"Saturday" ]
let monthOfYear = [ "1":"Janaury", "2":"February", "3":"March", "4":"April" , "5":"May", "6":"June", "7":"Jully", "8":"August","9":"September","10":"October","11":"November","12":"December" ]

let kUserDefault = NSUserDefaults.standardUserDefaults()
let kHasTutorial = "kHasTutorial5"

let kDateYYMMDD = DateFormatter(format: "YYYY/MM/dd")