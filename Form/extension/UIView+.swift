//
//  UIView+.swift
//  Form
//
//  Created by Kentarou on 2017/03/18.
//  Copyright © 2017年 Kentarou. All rights reserved.
//


import UIKit

extension UIView {
    
    func setBorderLayer(width: CGFloat = 1.0, radius: CGFloat = 0, boarderColor: UIColor = UIColor.clear) {
        self.layer.borderWidth   = width
        self.layer.cornerRadius  = radius
        self.layer.borderColor   = boarderColor.cgColor
        self.layer.masksToBounds = true
    }
}


extension UIView {
    
    // borderColor
    @IBInspectable var borderColor: UIColor? {
        get { return layer.borderColor.map{ UIColor(cgColor: $0) } }
        set (color){ layer.borderColor = color?.cgColor }
    }
    
    // borderwidth
    @IBInspectable var borderwidth: CGFloat {
        get { return layer.borderWidth }
        set(borderWidth) { layer.borderWidth = borderWidth }
    }
    
    // cornerRadius
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set(cornerRadius) { layer.cornerRadius = cornerRadius}
    }
    
    // masksToBounds
    @IBInspectable var masksToBounds: Bool {
        get { return layer.masksToBounds }
        set (masksToBounds) { layer.masksToBounds = masksToBounds}
    }
}
