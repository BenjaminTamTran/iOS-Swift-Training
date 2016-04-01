//
//  InfoBook.swift
//  TestwithCoreData
//
//  Created by Nguyen Xuan Thai on 3/29/16.
//  Copyright © 2016 Thai. All rights reserved.
//

import UIKit

class InfoBook: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var infoBookTable: UITableView!
    var books = [Book]()
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadDataBook()
    }
    
    override func viewDidAppear(animated: Bool) {
        reloadDataBook()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! BookCell
            cell.book = books[indexPath.row]
        return cell
    }
    
    func reloadDataBook() {
            let managedObjectContext = appDelegate.managedObjectContext
            books = Book.allBook(managedObjectContext)
            infoBookTable.reloadData()
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let moc = appDelegate.managedObjectContext
                moc.deleteObject(books[indexPath.row])
                appDelegate.saveContext()
                books.removeAtIndex(indexPath.row)
                infoBookTable.reloadData()
        }
    }
    
    func updateEntity(index:Int, updateName: String, updateAuthor: String, updateDate: String, updatePrice: Float){
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                books[index].name = updateName
                books[index].author = updateAuthor
                books[index].date = updateDate
                books[index].price = updatePrice
            appDelegate.saveContext()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        _ = tableView.cellForRowAtIndexPath(indexPath)
        let alert = UIAlertController(title: "Update", message: "Please update the new book", preferredStyle: .Alert)
                alert.addTextFieldWithConfigurationHandler{(updateName: UITextField) -> Void in
                    updateName.placeholder = "Update Name"
                }
                alert.addTextFieldWithConfigurationHandler{(updateAuthor: UITextField) -> Void in
                    updateAuthor.placeholder = "Update Author"
                }
                alert.addTextFieldWithConfigurationHandler{(updateDate: UITextField) -> Void in
                    updateDate.placeholder = "Update Date"
                }
                alert.addTextFieldWithConfigurationHandler{(updatePrice: UITextField) -> Void in
                    updatePrice.placeholder = "Update Price"
                }
        let updateAction = UIAlertAction(title: "Update", style: .Default){(_) in
                let updateName = alert.textFields![0]
                let updateAuthor = alert.textFields![1]
                let updateDate = alert.textFields![2]
                let updatePrice = alert.textFields![3]
                let priceBook = updatePrice.text?.floatValue
                self.updateEntity(indexPath.row, updateName: updateName.text!, updateAuthor: updateAuthor.text!, updateDate: updateDate.text!, updatePrice: priceBook!)
                self.infoBookTable.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alert.addAction(updateAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}


