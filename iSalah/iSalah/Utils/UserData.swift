//
//  UserData.swift
//  iSalah
//
//  Created by Tharindu Perera on 9/26/20.
//

import Foundation
import CoreLocation

let schoolOfThoughtKey = "SchoolOfThought"
let lastDataSyncedTimeKey = "LastDataSyncedTime"
let hanafiCheckedStatusKey = "HanafiCheckedStatus"
let lastLatitudeKey = "lastUserLatitude"
let lastLongitudeKey = "lastUserLongitude"

class UserData {
    
    static let userDefaults = UserDefaults(suiteName: "group.com.shafayDanyal.isalah")!
    
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
}
