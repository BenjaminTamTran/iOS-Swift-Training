//
//  CustomCell.swift
//  TestCustomViewCell
//
//  Created by Nguyen Xuan Thai on 3/28/16.
//  Copyright © 2016 Thai. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

   
    @IBOutlet var photo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
