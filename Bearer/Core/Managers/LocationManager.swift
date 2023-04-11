//
//  LocationManager.swift
//  Bearer
//
//  Created by zero on 4/9/23.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var lastSeenLocation: CLLocation?
    
    override init() {
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func requestWhenInUseAuthorization() {
      locationManager.requestWhenInUseAuthorization()
    }
    
    func updateAuthorizationStatus() {
      authorizationStatus = locationManager.authorizationStatus
    }
    
    func startUpdatingLocation() {
      locationManager.startUpdatingLocation()
    }
    
}

// MARK: - Location status
extension LocationManager {
  var locationIsDisabled: Bool {
    authorizationStatus == .denied ||
      authorizationStatus == .notDetermined ||
      authorizationStatus == .restricted
  }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
      updateAuthorizationStatus()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !locations.isEmpty else { return }
        
        lastSeenLocation = locations.last
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
      debugPrint("Location retrieving failed due to: \(error.localizedDescription)")
    }
}

