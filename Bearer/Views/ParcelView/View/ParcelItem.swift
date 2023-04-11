//
//  ParcelItem.swift
//  Bearer
//
//  Created by zero on 4/9/23.
//

import SwiftUI

struct ParcelItem: View {
    @EnvironmentObject var imageCacher: FireBaseImageCacher
    
    @Binding var selectedParcel: Parcel?
    
    var parcel: Parcel
    
    var body: some View {
        
            HStack(spacing: 20) {
                FireBaseImage(imageURL: parcel.parcelImgUrl)
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                
                    .padding()
                    .background(Constants.pupUpsBackgroundColor)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(6)
                    .onAppear {
                        imageCacher.catchImage(parcel.parcelImgUrl)
                    }
                
                
                Text(parcel.parcelType)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                    VStack(alignment: .center, spacing: 8) {
                        
                        Text(parcel.minMaxWeight)
                        Text(parcel.parcelDescription)
                    }
                    .foregroundColor(Color(.systemGray5))
                    .font(.system(size: 16))

            }
            
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(selectedParcel?.parcelType == parcel.parcelType ? Constants.pupUpsBackgroundColor.opacity(0.6) : Constants.listsBackgroundColor)
        
    }
}

struct ParcelItem_Previews: PreviewProvider {
    static var previews: some View {
        ParcelItem(selectedParcel: .constant(nil), parcel: Parcel.DommyParcel)
            .environmentObject(FireBaseImageCacher())
            .background(Color.black)
    }
}
