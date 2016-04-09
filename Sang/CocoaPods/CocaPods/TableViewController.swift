//
//  TableViewController.swift
//  CocaPods
//
//  Created by tranquocsang on 4/10/16.
//  Copyright © 2016 tranquocsang. All rights reserved.
//

import UIKit
import SwiftAddressBook
import AddressBook

class TableViewController: UITableViewController {

    var groups : [SwiftAddressBookGroup]?
    var people : [SwiftAddressBookPerson]?
    var names : [String?]? = []
    var numbers : [Array<String?>?]? = []
    var birthdates : [NSDate?]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SwiftAddressBook.requestAccessWithCompletion { (b :Bool, _ :CFError?) -> Void in
            if b {
                self.saveObjectsForTableView()
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
                 NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"load", object: nil)
            }
        }
    }
    
    func addNewPerson() {
        let person = SwiftAddressBookPerson.create()
        
        person.firstName = "John"
        person.lastName = "Doe"
        person.organization = "ACME, Inc."

        let email = MultivalueEntry(value: "someone@gmail.com", label: "home", id: 0)
        let email2 = MultivalueEntry(value: "someone2@gmail.com", label: "work", id: 0)
        person.emails = [email, email2]
        let phone = MultivalueEntry(value: "(555) 555-5555", label: "mobile", id: 0)
        person.phoneNumbers = [phone]
        
        swiftAddressBook?.addRecord(person)
        swiftAddressBook?.save()
    }
    
    func addNewGroup() {
        let group = SwiftAddressBookGroup.create()
        
        group.name = "Testgroup"
        
        swiftAddressBook?.addRecord(group)
        
        //it is necessary to save before adding people
        swiftAddressBook?.save()
        
        //add half of the people
        for i in 0..<self.people!.count/2 {
            group.addMember(self.people![i])
        }
        
        swiftAddressBook?.save()
    }
    
   func loadList(notification: NSNotification) {
        self.saveObjectsForTableView()
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
    
    func saveObjectsForTableView() {
        
        people = swiftAddressBook?.allPeople
        groups = []
        
        let sources = swiftAddressBook?.allSources
        for source in sources! {
            //println("\(source.sourceName)") //TODO: This throws an exception
            let newGroups = swiftAddressBook!.allGroupsInSource(source)!
            self.groups = self.groups! + newGroups
        }
        
        self.numbers = self.people?.map { (p) -> (Array<String?>?) in
            return p.phoneNumbers?.map { return $0.value }
        }
        self.names = self.people?.map { (p) -> (String?) in
            return p.compositeName
        }
        self.birthdates = self.people?.map { (p) -> (NSDate?) in
            return p.birthday
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return groups == nil ? 1 : groups!.count+1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if groups == nil || section == groups?.count {
            return people == nil ? 0 : people!.count
        }
        else {
            if let members = groups![section].allMembers {
                return members.count
            }
            else {
                return 0
            }
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("addressCell", forIndexPath: indexPath) as! AddressViewCell
        
        if groups == nil || indexPath.section == groups?.count {
            // Configure the cell...
            cell.nameLabel.text = people![indexPath.row].compositeName
            cell.lastNameLabel.text = people![indexPath.row].lastName
            cell.birthdateLabel.text = birthdates![indexPath.row]?.description
            cell.phoneNumberLabel.text = numbers![indexPath.row]?.first!
        }
        else {
            let group = groups![indexPath.section]
            let member = group.allMembers![indexPath.row]
            let name = member.compositeName
            cell.nameLabel.text = name
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if groups == nil || section == groups?.count {
            return "All people"
        }
        else {
            return groups![section].name
        }
    }

}


