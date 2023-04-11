//
//  DocumentType.swift
//  Bearer
//
//  Created by zero on 4/9/23.
//

import Foundation

enum DocumentType: String {
    case bearerParcels
    
    var path: String {
        switch self {
            case .bearerParcels:
                return "bearerParcels"
        }
    }
}

