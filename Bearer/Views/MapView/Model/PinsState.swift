//
//  PinsState.swift
//  Bearer
//
//  Created by zero on 4/9/23.
//

import GoogleMaps

enum PinsState {
    case addOrigin(_ origin: GMSCameraPosition)
    case addDestination(_ origin: GMSCameraPosition, _ destination: GMSCameraPosition)
    case removeDestination(_ origin: GMSCameraPosition, _ destination: GMSCameraPosition)
    case rempveOrigin(_ origin: GMSCameraPosition)
    case none
}
