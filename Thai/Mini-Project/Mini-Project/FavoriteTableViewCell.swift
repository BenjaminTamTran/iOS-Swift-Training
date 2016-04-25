//
//  FavoriteTableViewCell.swift
//  Travel Sticky
//
//  Created by Nguyen Xuan Thai on 4/25/16.
//  Copyright © 2016 Thai. All rights reserved.
//

import UIKit
class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet var imagePlace: UIImageView!
    @IBOutlet var namePlace: UILabel!
    @IBOutlet var timeVisit: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
