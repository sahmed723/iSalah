//
//  PrayerTimeViewModel.swift
//  iSalah
//
//  Created by Tharindu Perera on 9/27/20.
//

import Foundation

protocol PrayerTimeViewModelDelegate {
    func showMessageLabel(message: String)
    func hideMessageLabel()
    func activityIndicator(show: Bool)
    func reloadTableData()
}

class PrayerTimeViewModel {
    
    private var locationService: LocationService!
    private var isDataLoading = false
    private var delegate: PrayerTimeViewModelDelegate!
    var prayerTimes: [PrayerTime] = []
    
    let aladhanService = AladhanService()
    
    init(delegate: PrayerTimeViewModelDelegate) {
        self.delegate = delegate
        locationService = LocationService(delegate: self)
    }
    
    func loadPrayerTimes() {
        isDataLoading = true
        delegate.activityIndicator(show: true)
        delegate.hideMessageLabel()
        locationService.determineCurrentLocation()
    }
    
    private func fetchPrayerTimes(latitude: Double, longitude: Double) {
        aladhanService.getPrayerTimes(latitude: latitude, longitude: longitude) { (status, message, prayerTimes) in
            self.isDataLoading = true
            self.delegate.activityIndicator(show: false)
            if status, let prayerTimeObjs = prayerTimes {
                if prayerTimeObjs.isEmpty {
                    self.delegate.showMessageLabel(message: Strings.Messagage.noData)
                }
                self.prayerTimes = prayerTimeObjs
            } else {
                self.delegate.showMessageLabel(message: message ?? Strings.Messagage.genericError)
                self.prayerTimes = []
            }
            self.delegate.reloadTableData()
        }
    }
    
    private func clearTableData() {
        prayerTimes = []
        delegate.reloadTableData()
    }
}

extension PrayerTimeViewModel: LocationServiceDelegate {
    
    func didGetAuthorization() {
        if prayerTimes.isEmpty && !isDataLoading {
            guard !isDataLoading else {
                return
            }
            loadPrayerTimes()
        }
    }
    
    func locationFetchDidFail(message: String) {
        delegate.showMessageLabel(message: message)
        isDataLoading = false
        clearTableData()
        delegate.activityIndicator(show: false)
    }
    
    func locationDidFetch(lat: Double, long: Double) {
        fetchPrayerTimes(latitude: lat, longitude: long)
    }
}
