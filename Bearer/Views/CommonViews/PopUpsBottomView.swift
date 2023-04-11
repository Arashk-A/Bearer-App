//
//  PopUpsBottomView.swift
//  Bearer
//
//  Created by zero on 4/9/23.
//

import SwiftUI

struct PopUpsBottomView: View {
    var backAction: () -> Void
    var nextAction: () -> Void
    @Binding var isActive: Bool
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 16) {
            
            Button(action:backAction){
                Text("Back")
                    .modifier(ButtonText())
                    .bold()
            }

            
            Button(action: nextAction) {
                Text("Next")
                    .frame(width: 160, alignment: .center)
                    .padding()
                    .background(isActive ? Constants.enabledColor : Constants.disabledColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .font(.title3)
                    
            }
            .disabled(!isActive)
             
        }
        .foregroundColor(.white)
        .padding(18)
        .frame(maxWidth: .infinity)
    }
}

struct PopUpsBottomView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpsBottomView(backAction: {}, nextAction: {}, isActive: .constant(false))
            .background(Color.black)
    }
}
