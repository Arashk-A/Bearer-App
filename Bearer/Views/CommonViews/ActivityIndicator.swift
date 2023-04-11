//
//  SpinerImage.swift
//  Bearer
//
//  Created by zero on 4/9/23.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    var color: UIColor = .gray
    var scale: CGAffineTransform = CGAffineTransform(scaleX: 1, y: 1)
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let Indicator = UIActivityIndicatorView(style: style)
        Indicator.color = color
        Indicator.transform = scale
        return Indicator
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

extension ActivityIndicator {
    func color(_ color: Color) -> ActivityIndicator {
        var view = self
        view.color = UIColor(color)
        return view
    }
    
    func scale(x: CGFloat, y: CGFloat) -> ActivityIndicator {
        var view = self
        view.scale = CGAffineTransform(scaleX: x, y: y)
        return view
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator(isAnimating: .constant(true), style: .large, color: UIColor.gray)
            .color(.red)
            .scale(x: 2, y: 2)
    }
}
