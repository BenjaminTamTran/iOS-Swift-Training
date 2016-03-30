//
//  MyTextField.swift
//  text
//
//  Created by tranquocsang on 3/30/16.
//  Copyright © 2016 tranquocsang. All rights reserved.
//

import UIKit

class MyTextField: UITextField {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 5.0;          
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.borderWidth = 1.5
        self.backgroundColor = UIColor.whiteColor()
        self.textColor = UIColor.blackColor()
        self.tintColor = UIColor.purpleColor()
    }
    
}
