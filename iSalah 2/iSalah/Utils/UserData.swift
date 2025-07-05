//
//  UserData.swift
//  iSalah
//
//  Created by Tharindu Perera on 9/26/20.
//

import Foundation
import CoreLocation
import UIKit

let schoolOfThoughtKey = "SchoolOfThought"
let lastDataSyncedTimeKey = "LastDataSyncedTime"
let hanafiCheckedStatusKey = "HanafiCheckedStatus"
let lastLatitudeKey = "lastUserLatitude"
let lastLongitudeKey = "lastUserLongitude"

class UserData {
    
    static let userDefaults = UserDefaults(suiteName: "group.com.ShafayDanyal.isalah")!
    static let defaults = UserDefaults.standard
    //////////////////////////////////////////////////////
    //MARK: - UserDefaults Methods
    //////////////////////////////////////////////////////
    
    private static func saveData(value: String?, key: String) {
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
    
    private static func saveData(value: Date, key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    private static func saveData(value: Bool, key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    private static func saveData(value: Double, key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    private static func getUserDataString(key: String) -> String? {
        return userDefaults.string(forKey: key)
    }
    
    private static func getUserDataDate(key: String) -> Date? {
        return userDefaults.object(forKey:key) as? Date
    }
    
    private static func getUserDataBool(key: String) -> Bool {
        return userDefaults.bool(forKey:key)
    }
    
    private static func getUserDataDouble(key: String) -> Double {
        return userDefaults.double(forKey:key)
    }
    
    
    
    //////////////////////////////////////////////////////
    //MARK: - User Data
    //////////////////////////////////////////////////////
    
    static func saveSelectedSchoolOfThought(value: SchoolOfThought) {
        saveData(value: "\(value.rawValue)", key: schoolOfThoughtKey)
    }
    
    static func getSelectedSchoolOfThought() -> SchoolOfThought {
        guard let value = getUserDataString(key: schoolOfThoughtKey), let intValue = Int(value) else {
            return .method3
        }
        return SchoolOfThought(rawValue: intValue) ?? .method3
    }
    
    static func saveHanafiCheckedStatus(value: Bool) {
        saveData(value: value, key: hanafiCheckedStatusKey)
    }
    
    static func isHanafiChecked() -> Bool {
        getUserDataBool(key: hanafiCheckedStatusKey)
    }
    
    static func setLastDataSyncedTime(value: Date) {
        saveData(value: value, key: lastDataSyncedTimeKey)
    }
    
    static func lastDataSyncedTime() -> Date? {
        return getUserDataDate(key: lastDataSyncedTimeKey)
    }
    
    static func setUserLastLocation(location: CLLocation) {
        saveData(value: location.coordinate.latitude, key: lastLatitudeKey)
        saveData(value: location.coordinate.longitude, key: lastLongitudeKey)
    }
    
    static func getUserLastLocation() -> CLLocation? {
        let lat = getUserDataDouble(key: lastLatitudeKey)
        let long = getUserDataDouble(key: lastLongitudeKey)
        
        if lat != 0 && long != 0 {
            return CLLocation(latitude: lat, longitude: long)
        }
        return nil
    }
    
    static func savePrayerTimesForNotifications(prayerTimes: [PrayerTime]) {
        for prayerTime in prayerTimes {
            print(prayerTime.salah,prayerTime.time,prayerTime.timeObject)
            if prayerTime.salah == "Fajr" {
                setUpnotification(prayerTime: prayerTime.time, prayer: "Fajr", endTime: prayerTime.endPrayerTime)
            }
            if prayerTime.salah == "Dhuhr" {
                setUpnotification(prayerTime: prayerTime.time, prayer: "Dhuhr", endTime: prayerTime.endPrayerTime)
            }
            if prayerTime.salah == "Asr" {
                setUpnotification(prayerTime: prayerTime.time, prayer: "Asr", endTime: prayerTime.endPrayerTime)
            }
            if prayerTime.salah == "Maghrib" {
                setUpnotification(prayerTime: prayerTime.time, prayer: "Maghrib", endTime: prayerTime.endPrayerTime)
            }
            if prayerTime.salah == "Isha" {
                setUpnotification(prayerTime: prayerTime.time, prayer: "Isha", endTime: prayerTime.endPrayerTime)
            }
        }
    }
    
    static func hoursFormate(dateInString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let date = dateFormatter.date(from: dateInString)
        
        dateFormatter.dateFormat = "HH:mm"
        let date24 = dateFormatter.string(from: date!)
        return date24
    }
    
    static func setUpnotification(prayerTime: String, prayer: String, endTime: String) {
        
        let fajrTime = defaults.string(forKey: prayer)
        if fajrTime != nil {
            if fajrTime == prayerTime {
                // no need to set new time
            } else {
                //remove exsisting notication and set new notification
                defaults.setValue(prayerTime, forKey: prayer)
                let center = UNUserNotificationCenter.current()
                center.removeAllPendingNotificationRequests()
                let timeString = hoursFormate(dateInString: prayerTime)
                let HrsMints = timeString.components(separatedBy: ":")
                scheduleNotication(title: "Isalah", body: "Time for \(prayer) prayer.", identifier: prayer, Hours: Int(HrsMints[0])!, Minutes: Int(HrsMints[1])!)
                
                //notification for ending of prayer
                let time = hoursFormate(dateInString: endTime)
                let Hrs = time.components(separatedBy: ":")
                let name = getEndPrayerName(prayer)
                scheduleNotication(title: "Isalah", body: "\(name) time is about to end.", identifier: "end_prayewr", Hours: Int(Hrs[0])!, Minutes: Int(Hrs[1])!)
                
            }
        } else { //didn't have fajr time yet
            defaults.setValue(prayerTime, forKey: prayer)
            let timeString = hoursFormate(dateInString: prayerTime)
            let HrsMints = timeString.components(separatedBy: ":")
            scheduleNotication(title: "Isalah", body: "Time for \(prayer) prayer.", identifier: prayer, Hours: Int(HrsMints[0])!, Minutes: Int(HrsMints[1])!)
            
            //notification for ending of prayer
            let time = hoursFormate(dateInString: endTime)
            let Hrs = time.components(separatedBy: ":")
            let name = getEndPrayerName(prayer)
            scheduleNotication(title: "Isalah", body: "\(name) time is about to end.", identifier: "end_prayewr", Hours: Int(Hrs[0])!, Minutes: Int(Hrs[1])!)
            
        }
    }
    
    static func getEndPrayerName(_ prayerName: String) -> String {
        if prayerName == "Fajr" {
            return "Isha"
        }
        
        if prayerName == "Dhuhr" {
            return "Fajr"
        }
        
        if prayerName == "Asr" {
            return "Dhuhr"
        }
        
        if prayerName == "Maghrib" {
            return "Asr"
        }
        
        if prayerName == "Isha" {
            return "Maghrib"
        }
        
        else {
            return ""
        }
    }
    
    static func scheduleNotication(title: String, body: String, identifier: String, Hours: Int, Minutes: Int) {
        
        let content = UNMutableNotificationContent()
        let notificationCenter = UNUserNotificationCenter.current()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let gregorian = Calendar(identifier: .gregorian)
        let now = Date()
        var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
        
        components.hour = Hours
        components.minute = Minutes
        components.second = 0
        
        let date = gregorian.date(from: components)!
        
        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        
        let identifier = identifier
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
}
