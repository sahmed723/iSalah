//
//  WidgetLocationService.swift
//  iSalah
//
//  Created by Tharindu Perera on 9/28/20.
//

import Foundation
import CoreLocation

typealias LocationFetchHandler =  ((String?, CLLocation?, String?) -> Void)

class WidgetLocationService: NSObject {
    var lastAvailableCity: String?
    var locationManager: CLLocationManager? {
        didSet {
            self.locationManager!.desiredAccuracy = kCLLocationAccuracyKilometer
            self.locationManager!.delegate = self
            self.handlers = []
        }
    }
    
    private var handlers: [LocationFetchHandler] = []
    
    func fetchLocation(completion: @escaping LocationFetchHandler) {
        if CLLocationManager.locationServicesEnabled() {
            handlers.append(completion)
            locationManager!.requestLocation()
        } else {
            completion(Strings.Messagage.locationServiceOffError, nil, nil)
        }
    }
    
    private func fetchLocalityAndHandleLCFetchCompletion(location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            var city: String?
            if error == nil, let firstLocation = placemarks?.first {
                city = firstLocation.locality
            }
            self.lastAvailableCity = city
            self.handle(messaeg: nil, location: location, city: city)
        }
    }
    
    private func handle(messaeg :String?, location: CLLocation?, city :String?) {
        for handler in handlers {
            handler(messaeg, location, city)
        }
        handlers.removeAll()
    }
}

extension WidgetLocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        fetchLocalityAndHandleLCFetchCompletion(location: locations.last!)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        var message = Strings.Messagage.locationManagerError
        if manager.authorizationStatus == .denied || manager.authorizationStatus == .notDetermined {
            message = Strings.Messagage.locationPermissionError
        } else if let lastLocation = manager.location {
            handle(messaeg: nil, location: lastLocation, city: lastAvailableCity)
        } else if let lastUserLocation = UserData.getUserLastLocation() {
            handle(messaeg: nil, location: lastUserLocation, city: lastAvailableCity)
        } else {
            handle(messaeg: message, location: nil, city: nil)
        }
    }
}
