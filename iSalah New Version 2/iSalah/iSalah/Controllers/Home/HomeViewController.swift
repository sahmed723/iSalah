//
//  HomeViewController.swift
//  iSalah
//
//  Created on 9/25/20.
//

import UIKit
import WidgetKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var schoolThoughSelectBtn: UIButton!
    @IBOutlet weak var sotSelectBtn: UIButton!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var prayerTimesTableView: UITableView!
    
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
        schoolThoughSelectBtn.titleLabel?.numberOfLines = 2
        sotSelectBtn.setTitle(selectedSot.name, for: .normal)
        prayerTimesTableView.alwaysBounceVertical = false
        prayerTimesTableView.dataSource = self
        prayerTimesTableView.delegate = self
        viewModel = PrayerTimeViewModel(delegate: self)
        viewModel.loadPrayerTimes()
    }

    //MARK: Events
    @IBAction func showSchoolOfThoughtSelect(_ sender: Any) {
        PopupViewer.showSchoolOfThoughtSelect(vc: self, selectedSchoolOfThought: selectedSot, delegate: self)
    }
    
    @IBAction func reload(_ sender: UIBarButtonItem) {
        viewModel.loadPrayerTimes()
        WidgetCenter.shared.reloadAllTimelines()
    }
}

extension HomeViewController: SchoolOfThoughtSelectDelegate {
    
    func SchoolOfThoughtDidChange(_ sot: SchoolOfThought) {
        selectedSot = sot
        sotSelectBtn.setTitle(sot.name, for: .normal)
        viewModel.loadPrayerTimes()
        WidgetCenter.shared.reloadAllTimelines()
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
