//
//  TableViewController.swift
//  FirebaseChat
//
//  Created by The Simple Studio on 13/4/16.
//  Copyright © 2016 The Simple Studio. All rights reserved.
//

import UIKit
import Firebase

class TableViewController: UITableViewController {
    var ref : Firebase!
    var messages = [Message]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupFirebase()
        self.tableView.reloadData()
    }
    
    func setupFirebase()
    {
        ref = Firebase(url: "https://xxaa.firebaseio.com/posts")
        ref.onDisconnectRemoveValueWithCompletionBlock({ error, user in
            if error != nil {
                print("Could not establish onDisconnect event: \(error)")
            }
        })
        //Sync data if change
        
        ref.queryLimitedToNumberOfChildren(25).observeEventType(FEventType.ChildAdded, withBlock: { (snapshot) in
        let text = snapshot.value["title"] as? String
        let sender = snapshot.value["author"] as? String
        
        let message = Message(text: text, sender: sender)
        self.messages.append(message)
        self.tableView.reloadData()
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messages.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("chatcell", forIndexPath: indexPath) as! TableViewCell
        cell.labelName.text = messages[indexPath.row].sender()
        cell.labelMess.text = messages[indexPath.row].text()
        
        return cell
    }
}
