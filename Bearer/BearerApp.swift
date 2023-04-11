//
//  BearerApp.swift
//  Bearer
//
//  Created by zero on 4/9/23.
//

import SwiftUI
import GoogleMaps
import Firebase


@main
struct BearerApp: App {
    @StateObject var stateManager = StateManager()
    @StateObject var imageCacher = FireBaseImageCacher()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(stateManager)
                .environmentObject(imageCacher)
        }
    }
    
    init() {
        GMSServices.provideAPIKey("YOUR_API_KEY")
        FirebaseApp.configure()
    }
}
