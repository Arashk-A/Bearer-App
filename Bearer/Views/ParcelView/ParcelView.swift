//
//  ParcelView.swift
//  Bearer
//
//  Created by zero on 4/9/23.
//

import SwiftUI

struct ParcelView: View {
  @EnvironmentObject var stateManager: StateManager
  @StateObject var parcelViewModel = ParcelViewViewModel()
  
  var body: some View {
    
    VStack {
      PopUpsHeaderView(title: "Choose the parcel's type")
      .onAppear{
          parcelViewModel.getParcel(.bearerParcels)
      }
      
      ScrollView(.vertical, showsIndicators: false) {
        ZStack {
          Constants.listsBackgroundColor
          
          VStack(alignment: .leading) {
            
            ForEach(parcelViewModel.parcels, id: \.id) { parcel in
              
              ParcelItem(selectedParcel: $parcelViewModel.selectedParcel, parcel: parcel)
                .onTapGesture {
                  stateManager.selectedParcel = parcel
                  parcelViewModel.selectParcel(parcel)
                }
            }
            
          }
          .background(Constants.listsBackgroundColor)
          .padding(.horizontal, 5)
        }
      }
      .background(Constants.listsBackgroundColor)
      
      // END of scrollView
      
      PopUpsBottomView(backAction: {
        stateManager.back()
        parcelViewModel.resetState()
      }, nextAction: {
        
        stateManager.goToPricing()
        parcelViewModel.resetState()
      }, isActive: $parcelViewModel.isSelectedParcel)
      
      
    }
    .background(Constants.pupUpsBackgroundColor)
    .cornerRadius(16)
    .edgesIgnoringSafeArea(.bottom)
    .onAppear{
        parcelViewModel.getParcel(.bearerParcels)
    }
    .onReceive(parcelViewModel.$isLoading) { loading in
      stateManager.isLoading = loading
    }
    .onReceive(parcelViewModel.$error, perform: { value in
      stateManager.error = value
      stateManager.errorText = parcelViewModel.errorText
    })

    
    
  }
}

struct ParcelView_Previews: PreviewProvider {
  static var previews: some View {
    ParcelView()
      .environmentObject(StateManager())
  }
}
