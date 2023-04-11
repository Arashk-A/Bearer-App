//
//  LocationPickingView.swift
//  Bearer
//
//  Created by zero on 4/10/23.
//

import SwiftUI

struct LocationPickingView: View {
    var backAction: () -> Void
    var pickAction: () -> Void
    @Binding var isOriginPicked: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Spacer()
                
                HStack(spacing: 10) {
                    if isOriginPicked {
                        Button(action:backAction){
                            Text("Back")
                                .modifier(ButtonText())
                        }
                    }
                    
                    Button(action: {
                        withAnimation(.spring(), pickAction)
                    }) {
                        Text(isOriginPicked ? Constants.destination : Constants.origin)
                            .if(!isOriginPicked, transform: { text in
                                text.frame(width: geometry.size.width - 130)
                            })
                                .modifier(ButtonText())
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
   
                }
                .frame(maxWidth: .infinity, alignment: isOriginPicked ? .leading : .center)
                
            }
            
            .offset(y: 10)
            .padding()
        }
    }
    
}

struct LocationPickingView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPickingView(backAction: {}, pickAction: {}, isOriginPicked: .constant(false))
        
    }
}
