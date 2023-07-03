//
//  UITextField+Extesnion.swift
//  VinmoApp
//
//  Created by asif hussain on 3/17/23.
//

import Foundation
import UIKit
extension UITextField {
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[.foregroundColor: newValue!])
        }
    }
    
}
