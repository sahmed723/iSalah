//
//  AppStoryboard.swift
//  iSalah
//
//  Created by Tharindu Perera on 9/26/20.
//

import UIKit

enum AppStoryboard: String {
    case Main, Popup
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: .main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyBoardID = (viewControllerClass as UIViewController.Type).storyBoardID
        return instance.instantiateViewController(withIdentifier: storyBoardID) as! T
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}
