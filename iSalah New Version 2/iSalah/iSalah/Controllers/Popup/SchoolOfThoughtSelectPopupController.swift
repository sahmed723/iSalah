//
//  SchoolOfThoughtSelectPopupController.swift
//  iSalah
//
//  Created on 9/26/20.
//

import UIKit

protocol SchoolOfThoughtSelectDelegate: class {
    func SchoolOfThoughtDidChange(_ sot: SchoolOfThought)
}

class SchoolOfThoughtSelectPopupController: BaseViewController {
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var constraintPopUpCenterViewY: NSLayoutConstraint!
    @IBOutlet weak var optionsTableView: UITableView!
    
    var selectedSot: SchoolOfThought!
    weak var delegate: SchoolOfThoughtSelectDelegate?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.3) {
            self.visualEffectView.effect = UIBlurEffect(style: .dark)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.effect = nil
        }
    }
    
    //MARK: Private Methods
    private func setUp() {
        visualEffectView.effect = nil
        overlayView.alpha = 0
        optionsTableView.dataSource = self
        optionsTableView.delegate = self
        optionsTableView.selectRow(at: IndexPath(row: selectedSot.rawValue, section: 0), animated: true, scrollPosition: .none)
    }
    
    //MARK: Events
    @IBAction func close(_ sender: UIButton) {
        dismissWithFadeAnimation()
    }
    
}

extension SchoolOfThoughtSelectPopupController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SchoolOfThought.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let sot = SchoolOfThought.init(rawValue: indexPath.row)
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = AppTheme.getRegularFont()
        cell.textLabel?.attributedText = AppTheme.getAttributedTextWithLineSpacing(text: sot?.name ?? "N/A")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sot = SchoolOfThought.init(rawValue: indexPath.row)
        if let sotObj = sot, selectedSot.rawValue != sotObj.rawValue {
            UserData.saveSelectedSchoolOfThought(value: sotObj)
            delegate?.SchoolOfThoughtDidChange(sotObj)
            view.isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.dismissWithFadeAnimation()
            }
        }
    }
}
