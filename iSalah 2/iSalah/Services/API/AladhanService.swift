//
//  AladhanService.swift
//  iSalah
//
//  Created by Tharindu Perera on 9/26/20.
//

import Foundation
import Alamofire

class AladhanService {
    
    private let baseUrl = "http://api.aladhan.com"
    private let apiVersion = "v1"
    
    func getPrayerTimes(latitude: Double, longitude: Double, completion: @escaping (Bool, String?, [PrayerTime]?, String?) -> Void) {
        let sot = UserData.getSelectedSchoolOfThought()
        
        var endpoint = "\(baseUrl)/\(apiVersion)/timings?latitude=\(latitude)&longitude=\(longitude)&method=\(sot.rawValue)"
        if sot == .method3 && UserData.isHanafiChecked() {
            endpoint += "&school=1"
        }
        let request = AF.request(endpoint)
        request.responseJSON { (response) in
            let error = response.error
            if error == nil, let json = response.value as? [String: Any], let data = json["data"] as? NSDictionary, let timings = data["timings"] as? [String: String] {
                var prayerTimes: [PrayerTime] = []
                
                let fajrTimes = self.get12HTime(time: timings["Fajr"])
                if let fajrTime = fajrTimes.1 {
                    prayerTimes.append(PrayerTime(salah: "Fajr", time: fajrTimes.0, timeObject: fajrTime, endPrayerTime: fajrTimes.2))
                }
                
                let dhuhrTimes = self.get12HTime(time: timings["Dhuhr"])
                if let dhuhrTime = dhuhrTimes.1 {
                    prayerTimes.append(PrayerTime(salah: "Dhuhr", time: dhuhrTimes.0, timeObject: dhuhrTime, endPrayerTime: dhuhrTimes.2))
                }
                
                let asrTimes = self.get12HTime(time: timings["Asr"])
                if let asrTime = asrTimes.1 {
                    prayerTimes.append(PrayerTime(salah: "Asr", time: asrTimes.0, timeObject: asrTime, endPrayerTime: asrTimes.2))
                }
                
                let maghribTimes = self.get12HTime(time: timings["Maghrib"])
                if let maghribTime = maghribTimes.1 {
                    prayerTimes.append(PrayerTime(salah: "Maghrib", time: maghribTimes.0, timeObject: maghribTime, endPrayerTime: maghribTimes.2))
                }
                
                let ishaTimes = self.get12HTime(time: timings["Isha"])
                if let ishaTime = ishaTimes.1 {
                    prayerTimes.append(PrayerTime(salah: "Isha", time: ishaTimes.0, timeObject: ishaTime, endPrayerTime: ishaTimes.2))
                }
                
                var date: String?
                if let dateObject = data["date"] as? [String: Any], let readableDate = dateObject["readable"] as? String {
                    date = readableDate
                }
                
                prayerTimes.sort(by: {$0.timeObject.compare($1.timeObject) == .orderedAscending})
                completion(true, nil, prayerTimes, date)
            } else {
                var errorMessage: String?
                switch response.error {
                case .sessionTaskFailed(error: let sessionError):
                    errorMessage = sessionError.localizedDescription
                default: break
                }
                completion(false, errorMessage, nil, nil)
            }
        }
    }
    
    private func get12HTime(time: String?) -> (String, Date?, String) {
        var formattedTime = time ?? "N/A"
        var endFormattedTime = time ?? "N/A"
        var dateObject: Date?
        let calendar = Calendar.current
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        if let date24H = dateFormatter.date(from: time ?? "") {
            //getting 10 minutes before time
            let tenMinutesLater = Calendar.current.date(byAdding: .minute, value: -15, to: date24H)!
            
            dateFormatter.dateFormat = "hh:mm a"
            let time12H = dateFormatter.string(from: date24H)
            let ten = dateFormatter.string(from: tenMinutesLater)
            formattedTime = "\(time12H)"
            endFormattedTime = "\(ten)"
            
            let startDate = calendar.startOfDay(for: Date())
            let hours = calendar.component(.hour, from: date24H)
            let mins = calendar.component(.minute, from: date24H)
            
            if let correctHour = calendar.date(bySetting: .hour, value: hours, of: startDate) {
                if let todayWithTime = calendar.date(bySetting: .minute, value: mins, of: correctHour) {
                    dateObject = todayWithTime
                }
            }
        }
        return (formattedTime, dateObject, endFormattedTime)
    }
    
}
