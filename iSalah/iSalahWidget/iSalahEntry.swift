//
//  iSalahEntry.swift
//  iSalah
//
//  Created by Tharindu Perera on 9/28/20.
//

import Foundation
import WidgetKit

enum PrayerTimeDisplayType {
    case currentPrayerTime, nextPrayerTime, nextDayPrayerTime
}

struct iSalahEntry: TimelineEntry {
    let date: Date
    let prayerTimes: [PrayerTime]
    let city: String?
    let islamicDate: String?
    let message: String?
    var isPlaceholder = false
    var relevance: TimelineEntryRelevance? {
        return TimelineEntryRelevance(score: 50)
    }
}

extension iSalahEntry {
    static var stub: iSalahEntry {
        let timeline = WidgetUtils.getTimelineForSnapshot(prayerTimes: PrayerTime.samples)
        return iSalahEntry(date: timeline, prayerTimes: PrayerTime.samples, city: "City", islamicDate: AppUtils.getCurrentDate(), message: nil)
    }
    
    static var placeholder: iSalahEntry {
        iSalahEntry(date: Date(), prayerTimes: PrayerTime.placeHolders, city: " City ", islamicDate: AppUtils.getCurrentDate(), message: nil, isPlaceholder: true)
    }
}

extension iSalahEntry {
    
    var displayablePrayerTime: (PrayerTime?, PrayerTimeDisplayType) {
        let timeline = self.date
        
        if timeline < prayerTimes.first?.timeObject ?? Date() {
            return (prayerTimes.first, .nextPrayerTime)
        }
        
        for prayerTime in prayerTimes {
            if prayerTime.timeObject == timeline {
                return (prayerTime, .currentPrayerTime)
            }
        }
        
        var returnNextPrayerTime = false
        for prayerTime in prayerTimes {
            if returnNextPrayerTime {
                return (prayerTime, .nextPrayerTime)
            }
            
            let currentEndingTime = Calendar.current.date(byAdding: .minute, value: WidgetUtils.currentParyerTimeShowTime, to: prayerTime.timeObject)!
            if currentEndingTime == timeline {
                returnNextPrayerTime = true
            }
        }
        
        return (prayerTimes.first, .nextDayPrayerTime)
    }
}
