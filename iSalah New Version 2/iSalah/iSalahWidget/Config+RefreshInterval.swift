//
//  Config+RefreshInterval.swift
//  iSalah
//
//  Created on 9/28/20.
//

import Foundation

extension RefreshInterval {
    
    static let buffer = 10
    // Return refresh interval with a buffer
    var valueInMins: Int {
        switch self {
        case .oneHr:
            return (60 * 1) - RefreshInterval.buffer
        case .twoHrs:
            return (60 * 2) - RefreshInterval.buffer
        case .fourHrs:
            return (60 * 4) - RefreshInterval.buffer
        case .sixHrs:
            return (60 * 6) - RefreshInterval.buffer
        case .halfDay:
            return (60 * 12) - RefreshInterval.buffer
        case .day:
            return (60 * 24) - RefreshInterval.buffer
        case .unknown :
            return (60 * 4) - RefreshInterval.buffer
        }
    }
}
