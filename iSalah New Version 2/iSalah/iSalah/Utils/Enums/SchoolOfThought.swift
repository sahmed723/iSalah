//
//  SchoolOfThought.swift
//  iSalah
//
//  Created on 9/26/20.
//

import Foundation

enum SchoolOfThought: Int, CaseIterable {
    case method1
    case method2
    case method3
    case method4
    case method5
    case method6
    case method7
    case method8
    case method9
    case method10
    case method11
    case method12
    case method13
    case method14
    
    var name: String {
        switch self {
        case .method1:
            return "Shia Ithna-Ansari"
        case .method2:
            return "University of Islamic Sciences, Karachi"
        case .method3:
            return "Islamic Society of North America"
        case .method4:
            return "Muslim World League"
        case .method5:
            return "Umm Al-Qura University, Makkah"
        case .method6:
            return "Egyptian General Authority of Survey"
        case .method7:
            return "Institute of Geophysics, University of Tehran"
        case .method8:
            return "Gulf Region"
        case .method9:
            return "Kuwait"
        case .method10:
            return "Qatar"
        case .method11:
            return "Majlis Ugama Islam Singapura, Singapore"
        case .method12:
            return "Union Organization islamic de France"
        case .method13:
            return "Diyanet İşleri Başkanlığı, Turkey"
        case .method14:
            return "Spiritual Administration of Muslims of Russia"
        }
    }
}
