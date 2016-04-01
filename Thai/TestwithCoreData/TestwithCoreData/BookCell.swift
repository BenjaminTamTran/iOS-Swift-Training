//
//  BookCell.swift
//  TestwithCoreData
//
//  Created by Nguyen Xuan Thai on 3/29/16.
//  Copyright © 2016 Thai. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {
   
    @IBOutlet var name: UILabel!
    @IBOutlet var author: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var price: UILabel!
   var book: Book! {
        didSet {
           self.renderUICell()
        }
    }
    
   private func renderUICell() {
        name.text = book?.name
        author.text = book?.author
        date.text = book?.date
        price.text = String(format: "%.2f $", book.price)
    }
}
