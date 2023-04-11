//
//  PricingItem.swift
//  Bearer
//
//  Created by zero on 4/10/23.
//

import SwiftUI

struct PricingItem: View {
    
    @Binding var selectedPricing: PricingObject?
    var pricingObject: PricingObject?
    var viewType: PricingType
    let width = (UIScreen.main.bounds.width - 60) / 3
    
    var body: some View {
        VStack() {
            Image(viewType.icon)
              .resizable()
              .scaledToFit()
              .frame(height: 40)

            VStack(spacing: 3) {
                Text(pricingObject?.priceText ?? "")
                Text(pricingObject?.time ?? "")
                
            }
            .font(.caption)
            .bold()
            .padding(.bottom, 6)
            
        }
        .padding(8)
        .frame(width: width, height: 90, alignment: .center)
        .background(selectedPricing?.type == viewType ? Color("pricingSelectedColor") : .white)
        .foregroundColor(selectedPricing?.type == viewType ? .white :  .gray)
        .cornerRadius(16)
        
    }

}

struct PricingItem_Previews: PreviewProvider {
    static var previews: some View {
        PricingItem(selectedPricing: .constant(nil), pricingObject: PricingObject.pricingDummy, viewType: .walking)
    }
}
