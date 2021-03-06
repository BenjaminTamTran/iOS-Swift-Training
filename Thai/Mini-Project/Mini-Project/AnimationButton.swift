//
//  AnimationButton.swift
//  Anymex
//
//  Created by Sonivy Development on 4/6/16.
//  Copyright © 2016 Sonivy Development. All rights reserved.
//

import Foundation
import UIKit
import BFPaperButton
import QuartzCore

class RectangleButton: BFPaperButton {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.backgroundColor = UIColor.clearColor()
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 1.0
        self.shadowColor = UIColor.clearColor()
        self.tapCircleColor = Utility.blueColor()
        self.tapCircleDiameter = min(self.frame.size.width, self.frame.size.height) * 1.3
    }
}

class SquareButton: BFPaperButton {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.backgroundColor = UIColor.clearColor()
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 1.0
        self.shadowColor = UIColor.clearColor()
        self.tapCircleColor = Utility.blueColor()
        self.backgroundFadeColor = Utility.blueColor()
        self.cornerRadius = self.frame.size.width / 2
        self.rippleBeyondBounds = true
        self.tapCircleDiameter = min(self.frame.size.width, self.frame.size.height) * 1.3
    }
}