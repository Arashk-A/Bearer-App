//
//  Pricing.swift
//  Bearer
//
//  Created by zero on 4/9/23.
//

import Foundation

struct Pricing: Codable {
    var code: Int?
    var status: String?
    var cycling: PricingObject?
    var riding: PricingObject?
    var walking: PricingObject?

    
    init?(_ dict: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: dict, options: [])
        self = try JSONDecoder().decode(Self.self, from: data)
    }
}
