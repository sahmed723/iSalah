//
//  UserData.swift
//  iSalah
//
//  Created by Tharindu Perera on 9/26/20.
//

import Foundation

let schoolOfThoughtKey = "SchoolOfThought"

class UserData {
    
    static let userDefaults = UserDefaults(suiteName: "group.com.shafayDanyal.isalah")!
    
    //////////////////////////////////////////////////////
    //MARK: - UserDefaults Methods
    //////////////////////////////////////////////////////
    
    private static func saveData(value: String?, key: String) {
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
    
    private static func getUserDataString(key: String) -> String? {
        return userDefaults.string(forKey: key)
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

}
