//
//  ViewController.swift
//  CocaPods
//
//  Created by tranquocsang on 4/8/16.
//  Copyright © 2016 tranquocsang. All rights reserved.
//

import UIKit
import RFAboutView_Swift
import AutocompleteField
import Font_Awesome_Swift
import SwiftAddressBook

class ViewController: UIViewController {

    
    @IBOutlet weak var textGroupName: UITextField!
    @IBOutlet weak var textPhoneNumber: UITextField!
    @IBOutlet weak var textLastName: UITextField!
    @IBOutlet weak var textFirstName: UITextField!
    @IBOutlet weak var btnOut: UIButton!
    @IBOutlet weak var uiSegment: UISegmentedControl!
    
    let addressBook : SwiftAddressBook? = swiftAddressBook
    
    @IBAction func onRead(sender: AnyObject) {
        if let people : [SwiftAddressBookPerson]? = swiftAddressBook?.allPeople {
            for person in people! {
                let numbers = person.phoneNumbers
                print("%@", numbers?.map( {$0.value} ))
            }
        }
    }
    @IBAction func onAddPerson(sender: AnyObject) {

        let person = SwiftAddressBookPerson.create()
        
        //set the simple properties just like usual
        person.firstName = textFirstName.text
        person.lastName = textLastName.text
        person.organization = "ACME, Inc."
        
        let email = MultivalueEntry(value: "someone@gmail.com", label: "home", id: 0)
        let email2 = MultivalueEntry(value: "someone2@gmail.com", label: "work", id: 0)
        person.emails = [email, email2]
        let phone = MultivalueEntry(value: textPhoneNumber.text!, label: "mobile", id: 0)
        person.phoneNumbers = [phone]

        swiftAddressBook?.addRecord(person)
        swiftAddressBook?.save()
        // MARK: -Reload table view
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)

        // MARK: -Remove contact
        //swiftAddressBook?.removeRecord(person)
        //swiftAddressBook?.save()
    }
    @IBAction func onAddGroup(sender: AnyObject) {
        let group = SwiftAddressBookGroup.create()
        
        //You should give the group a name
        group.name = textGroupName.text
        
        //special on address book:
        //it is necessary to save before adding people to the group
        swiftAddressBook?.addRecord(group)
        swiftAddressBook?.save()
        
        //save again with new people contained
        swiftAddressBook?.save()
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
    }
    
    @IBAction func onAbout(sender: AnyObject) {
        
        let aboutNav = UINavigationController()
        
        // MARK: - Initialise the RFAboutView:
        
        let aboutView = RFAboutViewController(appName: "The simple studio App", appVersion: "2.0 (2)", appBuild: nil, copyrightHolderName: "ExampleApp, Inc.", contactEmail: "mail@example.com", contactEmailTitle: "Contact us", websiteURL: NSURL(string: "http://example.com"), websiteURLTitle: "Our Website", pubYear: nil)
        
        // Set some additional options:
        
        aboutView.headerBackgroundColor = .blackColor()
        aboutView.headerTextColor = .whiteColor()
        aboutView.blurStyle = .Dark
        aboutView.headerBackgroundImage = UIImage(named: "img 1")
        
        // Add an additional button:
        aboutView.addAdditionalButton("Privacy Policy", content: "Here's the privacy policy")
        aboutView.addAdditionalButton("Test 123", content: "abcdef !!")
        
        // Add the aboutView to the NavigationController:
        aboutNav.setViewControllers([aboutView], animated: false)
        
        // Present the navigation controller:
        self.presentViewController(aboutNav, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // MARK: - AutoComplete TextField
        let textField = AutocompleteField(frame: CGRectMake(10, 10, 200, 40), suggestions: ["Abraham Lincoln", "George Michael", "Franklin"])
        textField.autocompleteType = .Sentence
        view.addSubview(textField)
      
        // MARK: - Set button ICON
        btnOut.setFAIcon(FAType.FAGithub, forState: .Normal)
        
        //or if you want to set an icon size, use:
        btnOut.setFAIcon(FAType.FAGithub, iconSize: 35, forState: .Normal)
        
        //changing the color:
//        btnOut.titleLabel?.textColor = UIColor.greenColor()
//        
//        
//        btnOut.setFAText(prefixText: "follow", icon: FAType.FATwitter, postfixText: ". Thanks!", size: 25, forState: .Normal)
        
        //to have bigger icon, use:
        //btnOut.setFAText(prefixText: "follow me on ", icon: FAType.FATwitter, postfixText: ". Thanks!", size: 25, forState: .Normal, iconSize: 30)
        
        // MARK: - Set Segment ICON
        uiSegment.setFAIcon(FAType.FATwitter, forSegmentAtIndex: 0)
        uiSegment.setFAIcon(FAType.FAGithub, forSegmentAtIndex: 1)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

