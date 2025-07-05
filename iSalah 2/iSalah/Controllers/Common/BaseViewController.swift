//
//  BaseViewController.swift
//  iSalah
//
//  Created by Tharindu Perera on 9/26/20.
//

import UIKit
import NVActivityIndicatorView
import SnapKit

class BaseViewController: UIViewController {
    
    @IBOutlet weak var overlayView: UIView!
    private var loadingView: NVActivityIndicatorView?
    private let blockerView = UIView().asBackground(corner: 0, color: AppTheme.backgroundColor)

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func dismissWithFadeAnimation(completion: (() -> Void)? = nil) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        view.window!.layer.add(transition, forKey: nil)
        dismiss(animated: false, completion: completion)
    }
    
    //MARK: Public Methods
    func activityIndicator(show: Bool) {
        show ? showActivityIndicator() : hideActivityIndicator()
    }
    
    //MARK: Private Methods
    private func showActivityIndicator() {
        if loadingView == nil {
            let rect = CGRect(x: 0, y: 0, width: 40, height: 40)
            loadingView = NVActivityIndicatorView(frame: rect, type: .ballRotateChase, color: AppTheme.primaryColor, padding: nil)
            view.addSubview(blockerView)
            blockerView.snp.makeConstraints { (maker) in
                maker.edges.equalToSuperview()
            }
            view.addSubview(loadingView!)
            loadingView!.snp.makeConstraints { (maker) in
                maker.center.equalToSuperview()
            }
            loadingView!.startAnimating()
        }
    }
    
    private func hideActivityIndicator() {
        loadingView?.stopAnimating()
        loadingView?.removeFromSuperview()
        blockerView.removeFromSuperview()
        blockerView.snp.removeConstraints()
        loadingView = nil
    }

}

extension BaseViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopUpAnimation(isPresenting: true)
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopUpAnimation(isPresenting: false)
    }
    
}
