//
//  PhotoTableViewCell.swift
//  demoTableView2
//
//  Created by The Simple Studio on 30/3/16.
//  Copyright © 2016 The Simple Studio. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell
{
    @IBOutlet weak var theImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var photographerImageView: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    
    var photo: Photo! {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI()
    {
        self.theImageView.image = UIImage(named: photo.name)
        self.photographerImageView.image = UIImage(named: photo.photographerProfileImageName)
        self.captionLabel.text = photo.caption
    }
    
    
}





