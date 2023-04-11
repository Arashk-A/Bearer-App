//
//  FireBaseImageCacher.swift
//  Bearer
//
//  Created by zero on 4/9/23.
//

import SwiftUI
import FirebaseStorage

final class FireBaseImageCacher: ObservableObject {
    @Published var imageCache = NSCache<NSString, UIImage>()
    @Published var isLoading: Bool = true
    
    func catchImage(_ url: String) {
        guard !url.isEmpty else { return }
        if self.imageCache.object(forKey: url as NSString) == nil {
            self.getImage(url)
        } else {
            isLoading = false
        }
    }
    
    func getImage(_ id: String) {
        isLoading = true
        let storage = Storage.storage()
        let ref = storage.reference().child(id)
        ref.getData(maxSize: 1 * 1024 * 1024) { (data, err) -> Void in
            guard err == nil else { return }
            
            if let image = data.flatMap(UIImage.init) {
                DispatchQueue.main.async {
                    self.imageCache.setObject(image, forKey: id as NSString)
                    self.isLoading = false
                }
                
            }
            
        }
    }
    
}
