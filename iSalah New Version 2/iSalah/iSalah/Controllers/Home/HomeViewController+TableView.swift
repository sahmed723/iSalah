//
//  HomeViewController+TableView.swift
//  iSalah
//
//  Created on 9/26/20.
//

import UIKit

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.prayerTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrayerTimeTableViewCell") as! PrayerTimeTableViewCell
        let prayerTime = viewModel.prayerTimes[indexPath.row]
        cell.salahLbl.text = prayerTime.salah
        cell.timeLbl.text = "Time: \(prayerTime.time)"
        return cell
    }
}
