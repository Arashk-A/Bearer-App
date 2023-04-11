//
//  MapView.swift
//  Bearer
//
//  Created by zero on 4/9/23.
//

import SwiftUI
import GoogleMaps

struct MapView: UIViewRepresentable {
    
    let mapView = GMSMapView()
    
    @StateObject var locationManager = LocationManager()
    @EnvironmentObject var stateManager: StateManager
    
    func makeUIView(context: Context) -> some UIView {
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        mapView.delegate = context.coordinator

        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // MARK: - Moving to users location in the start of program
        if let location = locationManager.lastSeenLocation {
            moveToLocation(location)
        }
        
        switch stateManager.pinsState {
            case .addOrigin(let origin):
                context.coordinator.addOrigin(origin.target)
            
            case .addDestination(let origin, let destination):
                context.coordinator.addDestination(origin.target, destination.target)
            
            case .removeDestination(let origin, let destination):
                context.coordinator.removeDestonation(origin.target)
                context.coordinator.parent.mapView.animate(to: destination)
            
            case .rempveOrigin(let origin):
                context.coordinator.parent.mapView.clear()
                context.coordinator.parent.mapView.animate(to: origin)
                
            case .none:
                context.coordinator.parent.mapView.clear()
        }
        

    }
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(self)
    }
    
}


extension MapView {
    class MapViewCoordinator: NSObject, GMSMapViewDelegate {
        var parent: MapView
        
        init(_ mapView: MapView) {
            self.parent = mapView
        }
        

        func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
            if let myLocation = mapView.myLocation {
                parent.moveToLocation(myLocation)
            }
            return true
        }
        
        
        
        func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
            let location = CLLocation(latitude: position.target.latitude, longitude: position.target.longitude)
            debugPrint(location)
            
            parent.stateManager.lastUpdatedPosition = position
            
        }
        
        /*
        // NOTE: - this delegate method can be used but it uses to much resource
        // If the app requires this can be used too
        func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
            let location = CLLocation(latitude: position.target.latitude, longitude: position.target.longitude)
            parent.stateManager.lastUpdatedPosition = position
        }
         */

        
        // MARK: - Helpers method for updationg pins state in map
        func addOrigin(_ origin: CLLocationCoordinate2D) {
            parent.mapView.addPin(on: origin, with: Constants.bluePin)
            
            parent.mapView.animate(with: GMSCameraUpdate.scrollBy(x: 50, y: -100))
        }
        
        func addDestination(_ origin: CLLocationCoordinate2D, _ destination: CLLocationCoordinate2D) {
            parent.mapView.addPin(on: destination, with: Constants.orangePin)
            parent.mapView.drawArcPolyline(from: origin, to: destination)
            
            parent.mapView.zoomOutToFitMarkers(locations: [origin, destination], bounds: UIScreen.main.bounds)
            
            parent.mapView.isUserInteractionEnabled = false
            parent.mapView.settings.myLocationButton = false
        }
        
        func removeDestonation(_ origin: CLLocationCoordinate2D) {
            parent.mapView.clear()
            
            parent.mapView.addPin(on: origin, with: Constants.bluePin)
            
            parent.mapView.isUserInteractionEnabled = true
            parent.mapView.settings.myLocationButton = true
        }
        

        
    }

}

// MARK: - Helper functions for updating MapView
extension MapView {
    func moveToLocation(_ location: CLLocation) {
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude ,longitude: location.coordinate.longitude, zoom: 15)
        mapView.animate(to: camera)
    }

}



