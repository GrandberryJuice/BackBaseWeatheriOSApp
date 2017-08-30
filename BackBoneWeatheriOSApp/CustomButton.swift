//
//  CustomButton.swift
//  My Favorite Books
//
//  Created by KENNETH GRANDBERRY on 8/29/17.
//  Copyright © 2017 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton:UIButton {
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            setUpView()
        }
    }
    
    @IBInspectable var fontColor:UIColor = UIColor.white {
        didSet {
            self.tintColor = fontColor
        }
    }
    
    override func awakeFromNib() {
        setUpView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    func setUpView() {
        self.layer.cornerRadius = cornerRadius
    }
}
