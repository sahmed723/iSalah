//
//  PopupViewer.swift
//  iSalah
//
//  Created by Tharindu Perera on 9/26/20.
//

import UIKit

class PopupViewer {
    
    static func showSchoolOfThoughtSelect(vc: UIViewController & UIViewControllerTransitioningDelegate,
                                          selectedSchoolOfThought: SchoolOfThought,
                                          delegate: SchoolOfThoughtSelectDelegate) {
        let popupVC = SchoolOfThoughtSelectPopupController.instantiateFromAppStoryboard(appStoryBoard: .Popup)
        popupVC.modalPresentationStyle = .custom
        popupVC.transitioningDelegate = vc
        popupVC.selectedSot = selectedSchoolOfThought
        popupVC.delegate = delegate
        vc.present(popupVC, animated: true, completion: nil)
    }
    
}
