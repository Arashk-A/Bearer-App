//
//  Modifiers.swift
//  Bearer
//
//  Created by zero on 4/10/23.
//

import SwiftUI

struct ButtonText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Constants.enabledColor)
            .foregroundColor(.white)
            .cornerRadius(8)
            .font(.title3)
    }
}
