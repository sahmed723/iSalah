//
//  iSalahTimelineProvider.swift
//  iSalah
//
//  Created by Tharindu Perera on 9/28/20.
//

import Foundation
import WidgetKit
import CoreLocation

struct iSalahTimelineProvider: TimelineProvider {
    var widgetLocationService = WidgetLocationService()
    let aladhanService = AladhanService()
    let isLiveSnapshot = false
    
    func placeholder(in context: Context) -> iSalahEntry {
        .placeholder
    }

    func getSnapshot(in context: Context, completion: @escaping (iSalahEntry) -> ()) {
        if context.isPreview {
            completion(.stub)
        } else {
            fetchPrayerTimes { (result) in
                switch result {
                case .success(let entry):
                    completion(entry)
                case .failure(let error):
                    if let message = (error as NSError).userInfo["Message"] as? String, message != Strings.Messagage.locationManagerError {
                        let tempEntry = iSalahEntry(date: Date(), prayerTimes: [], city: nil, islamicDate: nil, message: message)
                        let timeline = WidgetUtils.getTimelineForSnapshot(prayerTimes: tempEntry.prayerTimes)
                        let entry = iSalahEntry(date: timeline, prayerTimes: tempEntry.prayerTimes, city: tempEntry.city, islamicDate: tempEntry.islamicDate, message: tempEntry.message)
                        completion(entry)
                    } else {
                        completion(.stub)
                    }
                }
            }
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<iSalahEntry>) -> ()) {
        fetchPrayerTimes { (result) in
            switch result {
            case .success(let entry):
                let midnight = WidgetUtils.getMidNightDate()
                let nextMidnight = Calendar.current.date(byAdding: .day, value: 1, to: midnight)!
                let nextMidnightAfterBuffer = Calendar.current.date(byAdding: .minute, value: 2, to: nextMidnight)!
                
                guard entry.message == nil else {
                    let timeline = Timeline(entries: [entry], policy: .after(nextMidnightAfterBuffer))
                    completion(timeline)
                    return
                }
                
                var entries: [iSalahEntry] = []
                let prayerTimes = entry.prayerTimes
                let city = entry.city
                let islamicDate = entry.islamicDate
                
                entries.append(iSalahEntry(date: midnight, prayerTimes: prayerTimes, city: city, islamicDate: islamicDate, message: nil))
                
                for prayerTime in prayerTimes {
                    let currentPrayerTimeEntry = iSalahEntry(date: prayerTime.timeObject, prayerTimes: prayerTimes, city: city, islamicDate: islamicDate, message: nil)
                    let nextDisplayableTime = Calendar.current.date(byAdding: .minute, value: WidgetUtils.currentParyerTimeShowTime, to: prayerTime.timeObject)!
                    let nextPrayerTimeEntry = iSalahEntry(date: nextDisplayableTime, prayerTimes: prayerTimes, city: city, islamicDate: islamicDate, message: nil)
                    entries.append(currentPrayerTimeEntry)
                    entries.append(nextPrayerTimeEntry)
                }
                
                let timeline = Timeline(entries: entries, policy: .after(nextMidnightAfterBuffer))
                completion(timeline)
            case .failure(let error):
                // Refresh after 10 mins
                let refreshDate = Calendar.current.date(byAdding: .minute, value: 10, to: Date())!
                var entries: [iSalahEntry] = []
                if let message = (error as NSError).userInfo["Message"] as? String, message != Strings.Messagage.locationManagerError {
                    let entry = iSalahEntry(date: Date(), prayerTimes: [], city: nil, islamicDate: nil, message: message)
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
        
        widgetLocationService.fetchLocation { (message, location, city) in
            var entryMessage: String?
            var entryPrayerTimes: [PrayerTime] = []
            if let userLocation = location {
                aladhanService.getPrayerTimes(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude) { (status, message, prayerTimes, islamicDate) in
                    if status, let prayerTimeObjs = prayerTimes {
                        if prayerTimeObjs.isEmpty {
                            entryMessage = Strings.Messagage.noData
                        } else {
                            entryPrayerTimes = prayerTimeObjs
                        }
                        let entry = iSalahEntry(date: Date(), prayerTimes: entryPrayerTimes, city: city, islamicDate: islamicDate, message: entryMessage)
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
