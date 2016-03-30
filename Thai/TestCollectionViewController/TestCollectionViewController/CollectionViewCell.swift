//
//  CollectionViewCell.swift
//  TestCollectionViewController
//
//  Created by Nguyen Xuan Thai on 3/27/16.
//  Copyright © 2016 Thai. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialize()
        self.visualize()
        self.localize()
        
    }
    func initialize() {
        
    }
    
    func visualize() {
        
    }
    
    func localize() {
        
    }
    
    func image(name: String) {
    image.image = UIImage(named: name)
    }
    func changeColorBackground() {
    image.backgroundColor = UIColor.redColor()
    }
}
