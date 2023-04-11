//
//  HomeView.swift
//  Bearer
//
//  Created by zero on 4/9/23.
//

import SwiftUI
import AlertToast

struct HomeView: View {
  @EnvironmentObject var stateManager: StateManager
  
  @State private var isPresented = false
  @State private var showToast = false
  
  
  var body: some View {
    ZStack {
      ZStack(alignment: .bottom) {
        ZStack(alignment: .top) {
          
          MapView().edgesIgnoringSafeArea(.all)
          
          Spacer()
          
          if stateManager.ridersState == .none {
            LocationPickingView(backAction: stateManager.back, pickAction: {
                stateManager.setPin()
            }, isOriginPicked: $stateManager.isOriginPicked)
            
          }
          
        } // END of mapview ZSTACK
        
        if stateManager.ridersState == .parcel {
          
          ParcelView()
            .frame(maxWidth: .infinity, maxHeight: (UIScreen.main.bounds.height / 2))
            .edgesIgnoringSafeArea(.bottom)
            .transition(.move(edge: .bottom))
          
        } else if stateManager.ridersState == .pricing {
          PricingView(backToParcel: stateManager.backFromPricing)
            .frame(maxWidth: .infinity, alignment: .bottom)
            .transition(.move(edge: .bottom))
            .background(Constants.pupUpsBackgroundColor)
            .padding(.bottom, -20)
        }
        
      } // End of container view ZStack
      
      if !stateManager.isDestinationPicked {
        PinView(isOriginPicked: $stateManager.isOriginPicked)
      }
      
    }
    .fullScreenCover(isPresented: $isPresented) {
      LoadingView(isAnimating: $isPresented)
    }
    .onReceive(stateManager.$isLoading, perform: { value in
      isPresented = value
    })
    .onReceive(stateManager.$error, perform: { value in
        showToast = value
    })
    .toast(isPresenting: $showToast, alert: {
      AlertToast(type: .regular, title: stateManager.errorText)
    }, completion:  {
      stateManager.error = false
    })
    
  }
}



struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
      .environmentObject(StateManager())
  }
}
