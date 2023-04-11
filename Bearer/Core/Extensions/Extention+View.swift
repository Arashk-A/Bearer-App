//
//  Extention+View.swift
//  Bearer
//
//  Created by zero on 4/10/23.
//

import SwiftUI

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    ///
    ///   ````
    ///   Text("Hello, world!")
    ///     .padding()
    ///        .if(shouldApplyBackground) { view in
    ///        // We only apply this background color if shouldApplyBackground is true
    ///             view.background(Color.red)
    ///        }
    ///        ````
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
