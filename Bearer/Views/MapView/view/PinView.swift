//
//  PinView.swift
//  Bearer
//
//  Created by zero on 4/9/23.
//

import SwiftUI

struct PinView: View {
    @Binding var isOriginPicked: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            Image(isOriginPicked ? "pinOrange":  "pinBlue")
                .frame(width: 40, height: 60)
                .offset(y: -20)
        }
    }
}

struct PinView_Previews: PreviewProvider {
    static var previews: some View {
        PinView(isOriginPicked: .constant(false))
    }
}

