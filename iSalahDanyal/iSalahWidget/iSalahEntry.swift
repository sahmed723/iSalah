//
//  iSalahEntry.swift
//  iSalah
//
//  Created by Tharindu Perera on 9/28/20.
//

import Foundation
import WidgetKit

struct iSalahEntry: TimelineEntry {
    let date: Date
    let prayerTimes: [PrayerTime]
    let message: String?
    var relevance: TimelineEntryRelevance? {
        return TimelineEntryRelevance(score: 50)
    }
}

extension iSalahEntry {
    static var stub: iSalahEntry {
        iSalahEntry(date: Date(), prayerTimes: PrayerTime.samples, message: nil)
    }
    
    static var placeholder: iSalahEntry {
        iSalahEntry(date: Date(), prayerTimes: PrayerTime.placeHolders, message: nil)
    }
}
