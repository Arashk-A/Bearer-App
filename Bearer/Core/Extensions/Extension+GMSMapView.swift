//
//  Extension+GMSMapView.swift
//  Bearer
//
//  Created by zero on 4/9/23.
//

import GoogleMaps

/// Helper methods to extend the useability of Google map view
extension GMSMapView {
    
    /// This will draw the arc line between two giving location
    /// - Parameters:
    ///   - startLocation: is the origin point to starting the path
    ///   - endLocation: the destination that path going to end
    func drawArcPolyline(from startLocation: CLLocationCoordinate2D, to endLocation: CLLocationCoordinate2D) {
        
        let distance = GMSGeometryDistance(startLocation, endLocation)
        let midPoint = GMSGeometryInterpolate(startLocation, endLocation, 0.5)
        
        let midToStartLocHeading = GMSGeometryHeading(midPoint, startLocation)
        
        let controlPointAngle = 360.0 - (270.0 - midToStartLocHeading)
        let controlPoint = GMSGeometryOffset(midPoint, distance / 2.0 , controlPointAngle)
        
        let path = GMSMutablePath()
        
        let stepper = 0.05
        let range = stride(from: 0.0, through: 1.0, by: stepper)// t = [0,1]
        
        func calculatePoint(when t: Double) -> CLLocationCoordinate2D {
            let t1 = (1.0 - t)
            let latitude = t1 * t1 * startLocation.latitude + 2 * t1 * t * controlPoint.latitude + t * t * endLocation.latitude
            let longitude = t1 * t1 * startLocation.longitude + 2 * t1 * t * controlPoint.longitude + t * t * endLocation.longitude
            let point = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            return point
        }
        
        range.map { calculatePoint(when: $0) }.forEach { path.add($0) }
        
        
        //  By customizing this arguments you can change the color and also the dots apperince
        
        let polyline = GMSPolyline(path: path)
        
        polyline.strokeWidth = 4
        let styles = [
            GMSStrokeStyle.solidColor(UIColor(red: 0.058, green: 0.201, blue: 0.46, alpha: 1)),
            GMSStrokeStyle.solidColor(.clear)
        ]
        
        let stepLength = NSNumber(value: min(path.length(of: .geodesic).rounded() / 32, 250))
        let lengths: [NSNumber] = [stepLength, stepLength]
        polyline.spans = GMSStyleSpans(polyline.path!, styles, lengths, GMSLengthKind.rhumb)
        
        polyline.map = self
        
    }
    
    
    /// For numbers of giving location points this method create marker and path for all and zoom out the map to fit in bound
    /// - Parameters:
    ///   - locations: array of location points
    ///   - bounds: is the map view bounds and also it uses to create padding in the bottom of map to push zooming area to top
    func zoomOutToFitMarkers(locations: [CLLocationCoordinate2D], bounds: CGRect) {
        let path = GMSMutablePath()
        
        for i in 0 ..< locations.count {
            let marker = GMSMarker()
            
            let lat = locations[i].latitude
            
            let long = locations[i].longitude
            
            marker.position = CLLocationCoordinate2DMake(lat,long)
            path.add(marker.position)
            
            marker.icon = UIImage()
            marker.map = self
            
            marker.map?.bounds = bounds
        }
        
        let paddingBottom = 3 * (bounds.height / 5)
        let padding = UIEdgeInsets(top: 60, left: 30, bottom: paddingBottom, right: 30)
        
        let markersBounds = GMSCoordinateBounds(path: path)
        
        self.animate(with: GMSCameraUpdate.fit(markersBounds, with: padding))
        
    }
    
    
    /// Adds a custom image as marker to giving point on map
    /// - Parameters:
    ///   - position: position where marker is going to replaced
    ///   - icon: the icon that's going to be uses as pin point
    func addPin(on position: CLLocationCoordinate2D, with icon: UIImage?) {
        let marker = GMSMarker(position: position)
        marker.icon = icon // custom your own marker
        marker.map = self
    }
}
