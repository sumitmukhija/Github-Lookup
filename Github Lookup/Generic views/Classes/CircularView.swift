//
//  CircularView.swift
//  Github Lookup
//
//  Created by Sumit on 11/20/17.
//  Copyright © 2017 Sumit Mukhija. All rights reserved.
//

import UIKit

@IBDesignable class CircularView: UIView
{
    @IBInspectable var radius: CGFloat = 4.0{
        didSet{
            updateUI()
        }
    }
    
    @IBInspectable var color: UIColor = COLORS.GIT_BLACK{
        didSet{
            updateUI()
        }
    }
    
    func updateUI() {
        self.layer.cornerRadius = radius
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 2.0
        self.backgroundColor = color
    }
}
