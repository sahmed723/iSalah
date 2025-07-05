//
//  ViewController.swift
//  iSalah
//
//  Created on 9/26/20.
//

import UIKit

extension UIViewController {
    
    class var storyBoardID: String {
        return "\(self)"
    }
    
    static func instantiateFromAppStoryboard(appStoryBoard: AppStoryboard) -> Self {
        return appStoryBoard.viewController(viewControllerClass: self)
    }
}
