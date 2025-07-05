//
//  WidgetLocationService.swift
//  iSalah
//
//  Created by Tharindu Perera on 9/28/20.
//

import Foundation
import CoreLocation

typealias LocationFetchHandler =  ((String?, CLLocation?) -> Void)

class WidgetLocationService: NSObject {
    var lastAvailableLocation: CLLocation?
    var locationManager: CLLocationManager? {
        didSet {
            self.locationManager!.delegate = self
        }
    }
    
    private var handler: LocationFetchHandler?
    
    func fetchLocation(completion: @escaping LocationFetchHandler) {
        self.handler = completion
        if CLLocationManager.locationServicesEnabled() {
            if let lastLocation = locationManager?.location {
                lastAvailableLocation = lastLocation
                handler?(nil, lastAvailableLocation)
            } else {
                locationManager!.requestLocation()
            }
        } else {
            handler?(Strings.Messagage.locationServiceOffError, nil)
        }
    }
}

extension WidgetLocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastAvailableLocation = locations.last!
        handler?(nil, lastAvailableLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        var message = Strings.Messagage.locationManagerError
        if manager.authorizationStatus == .denied || manager.authorizationStatus == .notDetermined {
            message = Strings.Messagage.locationPermissionError
        } else if let lastLocation = lastAvailableLocation {
            handler?(nil, lastLocation)
        } else {
            handler?(message, nil)
        }
    }
}
