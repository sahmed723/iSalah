//
//  View.swift
//  iSalah
//
//  Created by Tharindu Perera on 9/26/20.
//

import UIKit

extension UIView {
    
    func asBackground(corner: CGFloat, color: UIColor) -> UIView {
        layer.masksToBounds = true
        layer.cornerRadius = corner
        backgroundColor = color
        return self
    }
}
