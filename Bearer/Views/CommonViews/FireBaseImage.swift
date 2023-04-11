//
//  FireBaseImage.swift
//  Bearer
//
//  Created by zero on 4/9/23.
//

import SwiftUI

struct FireBaseImage: View {
    @EnvironmentObject var imageLoader: FireBaseImageCacher
    var imageURL: String
    
    init(imageURL: String) {
        self.imageURL = imageURL
    }
    
    var body: some View {
        if let image = imageLoader.imageCache.object(forKey: imageURL as NSString) {
            Image(uiImage:  image)
        } else {
          ActivityIndicator(isAnimating: .constant(true), style: .medium, color: .white)
                .scale(x: 1.2, y: 1.2)
        }
    }
}

struct FireBaseImage_Previews: PreviewProvider {
    static var previews: some View {
        FireBaseImage(imageURL: "parcelsImage/AEK5G5Y5QyxWw37IvJXd.png")
            .environmentObject(FireBaseImageCacher())
    }
}
