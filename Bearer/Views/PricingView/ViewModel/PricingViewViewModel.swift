//
//  PricingViewViewModel.swift
//  Bearer
//
//  Created by zero on 4/10/23.
//

import Foundation
import FirebaseFunctions
import CoreLocation

class PricingViewViewModel: ObservableObject {
  private lazy var functions = Functions.functions()
  
  @Published var seletedPricing: PricingObject? = nil
  @Published var isPricingSelected: Bool = false
  @Published var pricings: Pricing?
  
  @Published var isLoading: Bool = false
  @Published var error: Bool = false
  var errorText: String = "Could not reach to web service please try again!"

  func selectePricing(_ pricing: PricingObject?) {
    guard pricing != nil else { return }
    seletedPricing = pricing
    
    isPricingSelected = true
  }
  
  func resetState() {
      pricings = nil
      isPricingSelected = false
      seletedPricing = nil
  }
  
  func handlePricing(_ dataBody: [String : Any])  {
    isLoading = true
    functions.httpsCallable("pricing").call(dataBody) { result, error in
      if let error = error as NSError? {
        if error.domain == FunctionsErrorDomain {
          let code = FunctionsErrorCode(rawValue: error.code) ?? .unknown
          let message = error.localizedDescription
          let details = error.userInfo[FunctionsErrorDetailsKey] ?? ""
          debugPrint(code, message, details)
          
          DispatchQueue.main.async {
            self.error = true
            self.isLoading = false
          }
        }
      }
      
      if let data = result?.data as? [String: Any], data["code"] as! Int == 200  {
        let pricings = try? Pricing(data)
        DispatchQueue.main.async {
          self.pricings = pricings
          self.isLoading = false
        }
        
        
      }
    }
    
  }
  
  func getPricing(origin: CLLocationCoordinate2D?, destination: CLLocationCoordinate2D?, parcel: Parcel?) {
    guard let origin, let destination, let parcel else { return }
    
    let dataBody: [String : Any] = [
      "origin": [
        "lat": origin.latitude,
        "lng": origin.longitude
      ],
      "destination": [
        "lat": destination.latitude,
        "lng": destination.longitude
      ],
      "vehicle_type": [
        "walking": parcel.vehicleType.walking,
        "driving": parcel.vehicleType.driving,
        "bicycling": parcel.vehicleType.bicycling
      ],
      "parcel_type": parcel.parcelType,
      "parcel_description": parcel.parcelDescription,
      "parcel_min_weight": parcel.parcelMinWeight,
      "parcel_max_weight": parcel.parcelMaxWeight
    ]
    
    handlePricing(dataBody)
  }
  
}
