//
//  Config.swift
//  Travel Sticky
//
//  Created by Tran Huu Tam on 4/16/16.
//  Copyright © 2016 Thai. All rights reserved.
//

import Foundation
import GoogleMobileAds
import UIKit

let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
let dayOfWeek = [ "1":"SUN", "2":"MON", "3":"TUE", "4":"WED" , "5":"THUR", "6":"FRI", "7":"SAT" ]
let dayOfWeekFull = [ "SUN":"Sunday", "MON":"Monday", "TUE":"Tuesday", "WED":"Wednesday" , "THUR":"Thursday", "FRI":"Firday", "SAT":"Saturday" ]
let monthOfYear = [ "1":"Janaury", "2":"February", "3":"March", "4":"April" , "5":"May", "6":"June", "7":"Jully", "8":"August","9":"September","10":"October","11":"November","12":"December" ]

let kUserDefault = NSUserDefaults.standardUserDefaults()
let kHasTutorial = "kHasTutorial5"

let kDateYYMMDD = DateFormatter(format: "YYYY/MM/dd")
let accessTokenDropbox = "Sz4KEuRFprwAAAAAAAB3TolrxyQg1BMv35XfqP19PW746nMteXE70Ig8ym1Asosj"
let uidDropbox = "241454489"
let destination : (NSURL, NSHTTPURLResponse) -> NSURL = { temporaryURL, response in
    let fileManager = NSFileManager.defaultManager()
    let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
    // generate a unique name for this file in case we've seen it before
    let UUID = NSUUID().UUIDString
    let pathComponent = "\(UUID)-\(response.suggestedFilename!)"
    return directoryURL.URLByAppendingPathComponent(pathComponent)
}
// Mark: AppStore
let FACEBOOK_PERMISSIONS = ["public_profile", "email", "user_friends"]
let kAppId = "539427747"
let kAppStoreLink = "itms-apps://itunes.apple.com/app/id\(kAppId)"
let kAppStoreRateLink = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=\(kAppId)&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software"
let kHttpLinkAppStore = "https://itunes.apple.com/sg/app/english-spanish-in-use-voice/id789660618?mt=8"

var stickyCreate = 0

let kInterstitialID = "ca-app-pub-4577963732050051/1053295723"
let kAdTestDevice = "1ba0e235b997497c84592f9bc5b11f88"