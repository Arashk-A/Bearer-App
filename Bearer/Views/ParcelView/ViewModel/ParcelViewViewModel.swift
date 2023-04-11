//
//  ParcelViewViewModel.swift
//  Bearer
//
//  Created by zero on 4/9/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class ParcelViewViewModel: ObservableObject {
  private let db = Firestore.firestore()
  
  @Published var selectedParcel: Parcel?
  @Published var isSelectedParcel: Bool = false
  
  @Published var parcels: [Parcel] = []
  
  @Published var isLoading: Bool = false
  @Published var error: Bool = false
  var errorText: String = "Could not reach to web service please try again!"

  
  func selectParcel(_ parcel: Parcel) {
    selectedParcel = parcel
    isSelectedParcel = true
  }
  
  
  func resetState() {
    selectedParcel = nil
    isSelectedParcel = false
    parcels = []
  }
  
  func getParcel(_ doc: DocumentType) {
    isLoading = true
    
    db.collection(doc.path).getDocuments() { (querySnapshot, error) in
      if let error = error {
        debugPrint("Error getting documents: \(error)")
        
        DispatchQueue.main.async {
          self.error = true
          self.isLoading = false
        }
        
      } else {
        guard let docs = querySnapshot?.documents else { return }
        
        let parcels = docs.compactMap { doc in
          let parcel = try? doc.data(as: Parcel.self)
          return parcel
        }
        
        DispatchQueue.main.async {
          self.parcels = parcels
          self.isLoading = false
        }
        
      }
    }
    
  }
  
  
  
}
