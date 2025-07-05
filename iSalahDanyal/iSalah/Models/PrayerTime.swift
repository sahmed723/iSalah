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
    
    static var samples: [PrayerTime] {
        let fajr = PrayerTime(salah: "Fajr", time: "05:25 AM (TZ)")
        let dhuhr = PrayerTime(salah: "Dhuhr", time: "12:59 PM (TZ)")
        let asr = PrayerTime(salah: "Asr", time: "04:55 PM (TZ)")
        let maghrib = PrayerTime(salah: "Maghrib", time: "08:12 PM (TZ)")
        let isha = PrayerTime(salah: "Isha", time: "10:02 PM (TZ)")
        return [fajr, dhuhr, asr, maghrib, isha]
    }
    
    static var placeHolders: [PrayerTime] {
        let fajr = PrayerTime(salah: "Fajr", time: "--:-- (--)")
        let dhuhr = PrayerTime(salah: "Dhuhr", time: "--:-- (--)")
        let asr = PrayerTime(salah: "Asr", time: "--:-- (--)")
        let maghrib = PrayerTime(salah: "Maghrib", time: "--:-- (--)")
        let isha = PrayerTime(salah: "Isha", time: "--:-- (--)")
        return [fajr, dhuhr, asr, maghrib, isha]
    }
}
