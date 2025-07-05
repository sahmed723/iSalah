//
//  WidgetUtils.swift
//  iSalahWidgetExtension
//
//  Created by Tharindu Perera on 11/18/20.
//  Copyright © 2020 Intelcy. All rights reserved.
//

import Foundation

class WidgetUtils {
    
    static var currentParyerTimeShowTime: Int = 5  // In minutes
    
    static func getMonth(date: Date = Date()) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: date)
    }
    
    static func getMidNightDate() -> Date {
        let now = Date()
        let midnight = Calendar.current.startOfDay(for: now)
        return midnight
    }
    
    static func getTimelineForSnapshot(prayerTimes: [PrayerTime]) -> Date {
        let now = Date()
        let endOfCurrentDisplayTimeFromNow = Calendar.current.date(byAdding: .minute, value: 5, to: now)!
        
        if now < prayerTimes.first?.timeObject ?? Date() {
            return WidgetUtils.getMidNightDate()
        }
        
        for prayerTime in prayerTimes {
            if prayerTime.timeObject >= now && prayerTime.timeObject < endOfCurrentDisplayTimeFromNow {
                return prayerTime.timeObject
            }
        }
        var previousPrayerTime: Date?
        for prayerTime in prayerTimes {
            if prayerTime.timeObject > endOfCurrentDisplayTimeFromNow {
                let previousEndingTime = Calendar.current.date(byAdding: .minute, value: WidgetUtils.currentParyerTimeShowTime, to: previousPrayerTime ?? now)!
                return previousEndingTime
            }
            previousPrayerTime = prayerTime.timeObject
        }
        
        return now
    }
}
