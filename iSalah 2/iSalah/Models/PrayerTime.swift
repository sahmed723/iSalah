//
//  PrayerTime.swift
//  iSalah
//
//  Created by Tharindu Perera on 9/26/20.
//

import Foundation

struct PrayerTime {
    let salah: String
    let time: String
    let timeObject: Date
    let endPrayerTime: String
    
    static var samples: [PrayerTime] {
        let fajr = PrayerTime(salah: "Fajr", time: "05:25 AM", timeObject: AppUtils.getDateTimeObject(time: "05:25 AM")!, endPrayerTime: "05:15 AM")
        let dhuhr = PrayerTime(salah: "Dhuhr", time: "12:59 PM", timeObject: AppUtils.getDateTimeObject(time: "12:59 PM")!, endPrayerTime: "12:49 PM")
        let asr = PrayerTime(salah: "Asr", time: "04:55 PM", timeObject: AppUtils.getDateTimeObject(time: "04:55 PM")!, endPrayerTime: "04:45 PM")
        let maghrib = PrayerTime(salah: "Maghrib", time: "08:12 PM", timeObject: AppUtils.getDateTimeObject(time: "08:12 PM")!, endPrayerTime: "08:02 PM")
        let isha = PrayerTime(salah: "Isha", time: "10:02 PM", timeObject: AppUtils.getDateTimeObject(time: "10:02 PM")!, endPrayerTime: "09:52 PM")
        return [fajr, dhuhr, asr, maghrib, isha]
    }
    
    static var placeHolders: [PrayerTime] {
        let placeHolderDate = Date()
        let fajr = PrayerTime(salah: "Fajr", time: "--:--", timeObject: placeHolderDate, endPrayerTime: "")
        let dhuhr = PrayerTime(salah: "Dhuhr", time: "--:--", timeObject: placeHolderDate, endPrayerTime: "")
        let asr = PrayerTime(salah: "Asr", time: "--:--", timeObject: placeHolderDate, endPrayerTime: "")
        let maghrib = PrayerTime(salah: "Maghrib", time: "--:--", timeObject: placeHolderDate, endPrayerTime: "")
        let isha = PrayerTime(salah: "Isha", time: "--:--", timeObject: placeHolderDate, endPrayerTime: "")
        return [fajr, dhuhr, asr, maghrib, isha]
    }
}
