//
//  UIView + Extension.swift
//  VinmoApp
//
//  Created by asif hussain on 3/17/23.
//

import Foundation
import UIKit

extension UIView {
   

    func cornerRadius(radius: CGFloat = 10) {
        layer.cornerRadius = radius
        //layer.masksToBounds = true
    }
    
    func dropShadow() {
        layer.shadowColor = UIColor.link.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
    }
    
    func addBorder(_ width: CGFloat) {
        layer.borderWidth = width
        layer.borderColor = UIColor.link.cgColor
    }
}

