//
//  PricingType.swift
//  Bearer
//
//  Created by zero on 4/9/23.
//

import Foundation

enum PricingType: String, CaseIterable, Codable {
    case walking
    case riding
    case cycling
        
    var icon: String {
        switch self {
            case .walking:
                return "walk2"
            case .riding:
                return "motor"
            case .cycling:
                return "bike"
        }
    }
}
