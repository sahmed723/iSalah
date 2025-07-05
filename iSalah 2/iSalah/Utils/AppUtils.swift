//
//  AppUtils.swift
//  iSalah
//
//  Created by Tharindu Perera on 11/17/20.
//

import Foundation

class AppUtils {
    
    static func getDateTimeObject(time: String) -> Date? {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
        
        if let date = dateFormatter.date(from: time) {
            
            let startDate = calendar.startOfDay(for: Date())
            let hours = calendar.component(.hour, from: date)
            let mins = calendar.component(.minute, from: date)
            
            if let correctHour = calendar.date(bySetting: .hour, value: hours, of: startDate) {
                if let todayWithTime = calendar.date(bySetting: .minute, value: mins, of: correctHour) {
                    return todayWithTime
                }
            }
        }
        
        return nil
    }
    
    static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        return dateFormatter.string(from: Date())
    }
}
