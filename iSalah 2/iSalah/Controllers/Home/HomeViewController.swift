//
//  HomeViewController.swift
//  iSalah
//
//  Created by Tharindu Perera on 9/25/20.
//

import UIKit
import WidgetKit
import BEMCheckBox

class HomeViewController: BaseViewController {

    @IBOutlet weak var schoolThoughSelectBtn: UIButton!
    @IBOutlet weak var sotSelectBtn: UIButton!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var prayerTimesTableView: UITableView!
    @IBOutlet weak var hanafiCheckContainerView: UIView!
    @IBOutlet weak var hanafiCheckbox: BEMCheckBox!
    
    var selectedSot: SchoolOfThought!
    var viewModel: PrayerTimeViewModel!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    //MARK: Private Methods
    private func setUp() {
        selectedSot = UserData.getSelectedSchoolOfThought()
        setHanafiCheck()
        schoolThoughSelectBtn.titleLabel?.numberOfLines = 2
        sotSelectBtn.setTitle(selectedSot.name, for: .normal)
        prayerTimesTableView.alwaysBounceVertical = false
        prayerTimesTableView.dataSource = self
        prayerTimesTableView.delegate = self
        viewModel = PrayerTimeViewModel(delegate: self)
        viewModel.loadPrayerTimes()
    }
    
    private func setHanafiCheck() {
        hanafiCheckbox.on = UserData.isHanafiChecked()
        hanafiCheckContainerView.isHidden = selectedSot != .method3
        hanafiCheckbox.onAnimationType = .bounce
        hanafiCheckbox.offAnimationType = .bounce
        hanafiCheckbox.delegate = self
    }

    //MARK: Events
    @IBAction func showSchoolOfThoughtSelect(_ sender: Any) {
        PopupViewer.showSchoolOfThoughtSelect(vc: self, selectedSchoolOfThought: selectedSot, delegate: self)
    }
    
    @IBAction func reload(_ sender: UIBarButtonItem) {
        viewModel.loadPrayerTimes()
        if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
}

extension HomeViewController: SchoolOfThoughtSelectDelegate {
    
    func SchoolOfThoughtDidChange(_ sot: SchoolOfThought) {
        selectedSot = sot
        sotSelectBtn.setTitle(sot.name, for: .normal)
        hanafiCheckContainerView.isHidden = selectedSot != .method3
        viewModel.loadPrayerTimes()
        if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
}

extension HomeViewController: PrayerTimeViewModelDelegate {
    
    func showMessageLabel(message: String) {
        messageLbl.text = message
        messageLbl.isHidden = false
    }
    
    func hideMessageLabel() {
        messageLbl.isHidden = true
    }
    
    func reloadTableData() {
        prayerTimesTableView.reloadData()
    }
}

extension HomeViewController: BEMCheckBoxDelegate {
    
    func didTap(_ checkBox: BEMCheckBox) {
        UserData.saveHanafiCheckedStatus(value: checkBox.on)
        viewModel.loadPrayerTimes()
        if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
}
