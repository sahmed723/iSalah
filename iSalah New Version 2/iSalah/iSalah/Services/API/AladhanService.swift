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
    
    func getPrayerTimes(latitude: Double, longitude: Double, completion: @escaping (Bool, String?, [PrayerTime]?) -> Void) {
        let sot = UserData.getSelectedSchoolOfThought().rawValue
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let  currentDate = dateFormatter.string(from: Date())
        
        let endpoint = "\(baseUrl)/\(apiVersion)/timings/\(currentDate)?latitude=\(latitude)&longitude=\(longitude)&method=\(sot)"
        let request = AF.request(endpoint)
        request.responseJSON { (response) in
            let error = response.error
            if error == nil, let json = response.value as? [String: Any], let data = json["data"] as? NSDictionary, let timings = data["timings"] as? [String: String] {
                var prayerTimes: [PrayerTime] = []
                prayerTimes.append(PrayerTime(salah: "Fajr", time: self.get12HTime(time: timings["Fajr"])))
                prayerTimes.append(PrayerTime(salah: "Dhuhr", time: self.get12HTime(time: timings["Dhuhr"])))
                prayerTimes.append(PrayerTime(salah: "Asr", time: self.get12HTime(time: timings["Asr"])))
                prayerTimes.append(PrayerTime(salah: "Maghrib", time: self.get12HTime(time: timings["Maghrib"])))
                prayerTimes.append(PrayerTime(salah: "Isha", time: self.get12HTime(time: timings["Isha"])))
                completion(true, nil, prayerTimes)
            } else {
                var errorMessage: String?
                switch response.error {
                case .sessionTaskFailed(error: let sessionError):
                    errorMessage = sessionError.localizedDescription
                default: break
                }
                completion(false, errorMessage, nil)
            }
        }
    }
    
    private func get12HTime(time: String?) -> String {
        var formattedTime = time ?? "N/A"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        if let date24H = dateFormatter.date(from: String(time ?? "")) {
            dateFormatter.dateFormat = "hh:mm a"
            let time12H = dateFormatter.string(from: date24H)
            formattedTime = "\(time12H)"
        }
        return formattedTime
    }
    
}
