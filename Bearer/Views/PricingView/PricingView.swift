//
//  PricingView.swift
//  Bearer
//
//  Created by zero on 4/9/23.
//

import SwiftUI

struct PricingView: View {
  @EnvironmentObject var stateManager: StateManager
  @StateObject var pricingViewModel = PricingViewViewModel()
  
  var backToParcel: () -> Void
  
  
  var body: some View {
    
    VStack() {
      PopUpsHeaderView(title: "Select yuor preferred option")
      
      HStack(spacing: 16) {
        
        PricingItem(selectedPricing: $pricingViewModel.seletedPricing, pricingObject: pricingViewModel.pricings?.riding, viewType: .riding)
          .onTapGesture {
            pricingViewModel.selectePricing(pricingViewModel.pricings?.riding)
          }
        
        PricingItem(selectedPricing: $pricingViewModel.seletedPricing, pricingObject: pricingViewModel.pricings?.cycling, viewType: .cycling)
          .onTapGesture {
            pricingViewModel.selectePricing(pricingViewModel.pricings?.cycling)
          }
        
        PricingItem(selectedPricing: $pricingViewModel.seletedPricing, pricingObject: pricingViewModel.pricings?.walking, viewType: .walking)
          .onTapGesture {
            pricingViewModel.selectePricing(pricingViewModel.pricings?.walking)
          }
        
      }
      .padding(.horizontal)
      
      
      PopUpsBottomView(backAction: {
        backToParcel()
        pricingViewModel.resetState()
      }, nextAction: {
        
        // TODO: Handle the selcted pricing option
        
      }, isActive: $pricingViewModel.isPricingSelected)
      
      
    }
    .cornerRadius(16)
    .edgesIgnoringSafeArea(.bottom)
    .background(Constants.pupUpsBackgroundColor)
    .onAppear{
      let requirments = stateManager.pricingRequirments
      
      pricingViewModel.getPricing(origin: requirments.origin, destination: requirments.destination, parcel: requirments.parcel)
    }
    .onReceive(pricingViewModel.$isLoading) { loading in
      stateManager.isLoading = loading
    }
    .onReceive(pricingViewModel.$error, perform: { value in
      stateManager.error = value
      stateManager.errorText = pricingViewModel.errorText
    })
    
  }
}

struct PricingView_Previews: PreviewProvider {
  static var previews: some View {
    PricingView(backToParcel: {})
      .environmentObject(StateManager())
    
  }
}
