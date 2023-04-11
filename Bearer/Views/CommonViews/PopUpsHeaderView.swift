//
//  PopUpsHeaderView.swift
//  Bearer
//
//  Created by zero on 4/9/23.
//

import SwiftUI

struct PopUpsHeaderView: View {
    let title: String
    
    var body: some View {
        HStack() {
            VStack(alignment: .center) {
                Capsule()
                    .foregroundColor(Color(.systemGray2))
                    .frame(width: 80, height: 6)
                
                Text(title)
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .foregroundColor(.white)
        .padding()
        .padding(.bottom, -12)
    }
}

struct PopUpsHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpsHeaderView(title: "Choose the parcel's type 2")
            .background(Color.black)
    }
}
