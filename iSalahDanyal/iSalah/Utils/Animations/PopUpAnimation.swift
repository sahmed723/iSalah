//
//  PopUpAnimation.swift
//  iSalah
//
//  Created by Tharindu Perera on 9/26/20.
//

import UIKit

class PopUpAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    let isPresenting: Bool
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        if (isPresenting) {
            return 0.45
        } else {
            return 0.25
        }
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if (isPresenting) {
            self.presentAnimateTransition(transitionContext: transitionContext)
        } else {
            self.dismissAnimateTransition(transitionContext: transitionContext)
        }
    }
    
    func presentAnimateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let viewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! BaseViewController
        let containerView = transitionContext.containerView
        
        containerView.addSubview(viewController.view)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                       animations: {
                        viewController.overlayView.alpha = 1.0
        },
                       completion: { finished in
                        if (finished) {
                            transitionContext.completeTransition(true)
                        }
        })
    }
    
    func dismissAnimateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let viewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! BaseViewController
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                       animations: {
                        viewController.overlayView.alpha = 0.0
        },
                       completion: { finished in
                        transitionContext.completeTransition(true)
        })
    }
}
