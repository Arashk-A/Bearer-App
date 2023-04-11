//
//  PricingObject.swift
//  Bearer
//
//  Created by zero on 4/11/23.
//

import Foundation

struct PricingObject: Codable {
    let price: String
    let distance: Double
    let time: String
    let duration: Double
    let type: PricingType
    let length: String
    
    
    static var pricingDummy: PricingObject {
        return PricingObject(price: "10~16", distance: 0.0, time: "0~5 min", duration: 0.0, type: Bearer.PricingType.riding, length: "0 km")
    }
    
    
    var priceText: String {
        return "\(price)$"
    }
}
