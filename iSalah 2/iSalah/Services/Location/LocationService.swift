//
//  LocationService.swift
//  iSalah
//
//  Created by Tharindu Perera on 9/26/20.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate: class {
    func didGetAuthorization()
    func locationFetchDidFail(message: String)
    func locationDidFetch(lat: Double, long: Double)
}

class LocationService: NSObject {
    
    private var locationManager: CLLocationManager
    private weak var delegate: LocationServiceDelegate?
    
    init(delegate: LocationServiceDelegate) {
        locationManager = CLLocationManager()
        self.delegate = delegate
    }
    
    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        } else {
            delegate?.locationFetchDidFail(message: Strings.Messagage.locationServiceOffError)
        }
    }
    
}

extension LocationService: CLLocationManagerDelegate {
    
    @available(iOS 14.0, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            delegate?.didGetAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            delegate?.didGetAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
        if userLocation != nil {
            UserData.setUserLastLocation(location: userLocation!)
        }
        delegate?.locationDidFetch(lat: userLocation?.coordinate.latitude ?? 0, long: userLocation?.coordinate.longitude ?? 0)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        var message = Strings.Messagage.genericError
        if #available(iOS 14.0, *) {
            if manager.authorizationStatus == .denied || manager.authorizationStatus == .notDetermined {
                message = Strings.Messagage.locationPermissionError
            }
        } else {
            if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .notDetermined {
                message = Strings.Messagage.locationPermissionError
            }
        }
        delegate?.locationFetchDidFail(message: message)
    }
    
}
