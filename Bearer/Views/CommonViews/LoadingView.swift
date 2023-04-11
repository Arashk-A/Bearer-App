//
//  LoadingView.swift
//  Bearer
//
//  Created by zero on 4/10/23.
//

import SwiftUI

struct LoadingView: View {
    
    @Binding var isAnimating: Bool
    
    var body: some View {
        ZStack(alignment: .center) {
            
            VStack(alignment: .center, spacing: 20) {

                ActivityIndicator(isAnimating: $isAnimating, style: .large)
                    .color(Constants.listsBackgroundColor)
                    .scale(x: 1.2, y: 1.2)

                Text("Please wait")
                    .font(.title2)
            }
            .padding(20)
            .padding(.top, 8)
            .background(BackgroundBlurView())
            .cornerRadius(16)
            
        }
        .background(TransparentView())
        .edgesIgnoringSafeArea(.all)
    }
}
struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isAnimating: .constant(true))
    }
}
