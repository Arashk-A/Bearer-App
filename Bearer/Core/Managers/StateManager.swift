//
//  StateManager.swift
//  Bearer
//
//  Created by zero on 4/9/23.
//

import CoreLocation
import GoogleMaps

class StateManager: ObservableObject {
  var startPosition: GMSCameraPosition?
  var endPosition: GMSCameraPosition?
  var lastUpdatedPosition = GMSCameraPosition()
  var selectedParcel: Parcel?
  
  @Published var pinsState: PinsState = .none
  @Published var ridersState: RidersState = .none
  @Published var isOriginPicked: Bool = false
  @Published var isDestinationPicked: Bool = false
  
  @Published var isLoading: Bool = false
  @Published var error: Bool = false
  var errorText: String = "Could not reach to web service please try again!"
  
  func setPin() {
    if startPosition == nil && endPosition == nil {
      startPosition = lastUpdatedPosition
      
      pinsState = .addOrigin(lastUpdatedPosition)
      isOriginPicked = true
      
    } else if endPosition == nil, let start = startPosition {
      endPosition = lastUpdatedPosition
      
      pinsState = .addDestination(start, lastUpdatedPosition)
      
      ridersState = .parcel
      isDestinationPicked = true
    }
  }
  
  func back() {
    if let end = endPosition, let start = startPosition {
      pinsState = .removeDestination(start, end)
      
      ridersState = .none
      
      isDestinationPicked = false
      
      endPosition = nil
    } else if endPosition == nil, let start = startPosition {
      pinsState = .rempveOrigin(start)
      
      isOriginPicked = false
      
      startPosition = nil
    }
    
  }
  
  func goToPricing() {
    ridersState = .pricing
  }
  
  func backFromPricing() {
    ridersState = .parcel
  }
  
  var pricingRequirments: (origin: CLLocationCoordinate2D?, destination: CLLocationCoordinate2D?, parcel: Parcel?) {
    return (origin: startPosition?.target, destination: endPosition?.target, parcel: selectedParcel)
  }
}
