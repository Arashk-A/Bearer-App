//
//  Parcel.swift
//  Bearer
//
//  Created by zero on 4/9/23.
//

import FirebaseFirestoreSwift


struct Parcel: Codable, Identifiable {
    @DocumentID var id: String?
    let parcelMaxWeight: Double
    let parcelDescription: String
    let parcelMinWeight: Double
    let vehicleType: VehicleType
    let parcelImgUrl: String
    let parcelType: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case parcelMaxWeight = "parcel_max_weight"
        case parcelDescription = "parcel_description"
        case vehicleType = "vehicle_type"
        case parcelMinWeight = "parcel_min_weight"
        case parcelImgUrl = "parcel_img_url"
        case parcelType = "parcel_type"
        
    }
    
    var minMaxWeight: String {
        let min = String(format: "%.1f", parcelMinWeight)
        let max = String(format: "%.1f", parcelMaxWeight)
        return "\(min)-\(max) Kg max"
    }
    
    static var DommyParcel: Parcel {
        let vehicleType = VehicleType(driving: true, walking: true, bicycling: true)
        
        return Parcel(parcelMaxWeight: 2.5, parcelDescription: "35 x 27 x 4 cm ---", parcelMinWeight: 0.10000000000000001, vehicleType: vehicleType, parcelImgUrl: "parcelsImage/AEK5G5Y5QyxWw37IvJXd.png", parcelType: "Envelope3")
    }
    
}
