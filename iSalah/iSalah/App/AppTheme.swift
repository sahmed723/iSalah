//
//  AppTheme.swift
//  iSalah
//
//  Created by Tharindu Perera on 9/26/20.
//

import UIKit
import SwiftUI

class AppTheme {
    // Colors
    static let primaryColor = UIColor(named: "PrimaryColor")!
    static let backgroundColor = UIColor(named: "BackgroundColor")!
    
    // Labels
    static func getRegularFont(size: CGFloat = 16.0) -> UIFont {
        return UIFont(name: "TrendexSSi", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func getAttributedTextWithLineSpacing(text: String, lineSpacing: CGFloat = 4.0) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        let attributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
}

extension Color {
    static let primaryColor = Color("PrimaryColor")
    static let primaryDarkColor = Color("PrimaryDarkColor")
    static let backgroundColor = Color("BackgroundColor")
}

extension Font {
    static func getWidgetFont(size: CGFloat = 16.0, weight: Weight = .regular) -> Font {
        return Font.system(size: size, weight: weight)
    }
    
    static func getTimerFont(size: CGFloat = 20.0) -> Font {
        return Font.custom("OpenSans-Semibold", size: size)
    }
}
