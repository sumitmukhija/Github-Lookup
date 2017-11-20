//
//  BorderedButton.swift
//  Penny
//
//  Created by Sumit Mukhija on 16/09/16.
//  Copyright © 2016 Sumit Mukhija. All rights reserved.
//

import UIKit

@IBDesignable public class BorderedButton: UIButton{
    
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
    

    @IBInspectable var width: CGFloat = 2.0{
        didSet{
            updateUI()
        }
    }
    
    func updateUI() {
        self.layer.cornerRadius = radius
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
        self.setTitleColor(color, for: .normal)
    }
    
    
}
