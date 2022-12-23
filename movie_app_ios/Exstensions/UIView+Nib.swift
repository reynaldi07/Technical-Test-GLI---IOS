//
//  UIView+Nib.swift
//  movie_app_ios
//
//  Created by Reynaldi Pamungkas on 14/12/22.
//

import Foundation
import UIKit

extension UIView {
    class func instantiateFromNib<T: UIView>(_ viewType: T.Type) -> T {
        let url = URL(string: NSStringFromClass(viewType))
        return Bundle.main.loadNibNamed((url?.pathExtension)!, owner: nil, options: nil)!.first as! T
    }
    class func instantiateFromNib() -> Self {
        return instantiateFromNib(self)
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
}
