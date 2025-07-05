//
//  iSalahTimelineProvider.swift
//  iSalah
//
//  Created by Tharindu Perera on 9/28/20.
//

import Foundation
import WidgetKit
import CoreLocation

struct iSalahTimelineProvider: IntentTimelineProvider {
    var widgetLocationService = WidgetLocationService()
    let aladhanService = AladhanService()
    let isLiveSnapshot = false
    
    func placeholder(in context: Context) -> iSalahEntry {
        .placeholder
    }

    func getSnapshot(for configuration: RefreshIntervalIntent, in context: Context, completion: @escaping (iSalahEntry) -> ()) {
        if context.isPreview {
            completion(.stub)
        } else {
            fetchPrayerTimes { (result) in
                switch result {
                case .success(let entry):
                    completion(entry)
                case .failure(let error):
                    if let message = (error as NSError).userInfo["Message"] as? String, message != Strings.Messagage.locationManagerError {
                        let entry = iSalahEntry(date: Date(), prayerTimes: [], message: message)
                        completion(entry)
                    } else {
                        completion(.placeholder)
                    }
                }
            }
        }
    }

    func getTimeline(for configuration: RefreshIntervalIntent, in context: Context, completion: @escaping (Timeline<iSalahEntry>) -> ()) {
        fetchPrayerTimes { (result) in
            switch result {
            case .success(let entry):
                // Refresh as user configuration, default every 4 hrs
                let interval = configuration.interval 
                let refreshDate = Calendar.current.date(byAdding: .minute, value: interval.valueInMins, to: Date())!
                let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
                completion(timeline)
            case .failure(let error):
                // Refresh after 10 mins
                let refreshDate = Calendar.current.date(byAdding: .minute, value: 10, to: Date())!
                var entries: [iSalahEntry] = []
                if let message = (error as NSError).userInfo["Message"] as? String, message != Strings.Messagage.locationManagerError {
                    let entry = iSalahEntry(date: Date(), prayerTimes: [], message: message)
                    entries.append(entry)
                } else {
                    entries.append(.placeholder)
                }
                let timeline = Timeline(entries: entries, policy: .after(refreshDate))
                completion(timeline)
            }
        }
    }
    
    private func fetchPrayerTimes(completion: @escaping (Result<iSalahEntry, Error>) -> ()) {
        if widgetLocationService.locationManager == nil {
            widgetLocationService.locationManager = CLLocationManager()
            widgetLocationService.locationManager!.requestWhenInUseAuthorization()
        }
        
        widgetLocationService.fetchLocation { (message, location) in
            var entryMessage: String?
            var entryPrayerTimes: [PrayerTime] = []
            if let userLocation = location {
                aladhanService.getPrayerTimes(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude) { (status, message, prayerTimes) in
                    if status, let prayerTimeObjs = prayerTimes {
                        if prayerTimeObjs.isEmpty {
                            entryMessage = Strings.Messagage.noData
                        } else {
                            entryPrayerTimes = prayerTimeObjs
                        }
                        let entry = iSalahEntry(date: Date(), prayerTimes: entryPrayerTimes, message: entryMessage)
                        completion(.success(entry))
                    } else {
                        completion(.failure(NSError()))
                    }
                }
            } else {
                let error = NSError(domain: "", code: 99, userInfo: ["Message" : message as Any])
                completion(.failure(error))
            }
        }
    }
}
