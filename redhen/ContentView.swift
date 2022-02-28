//
//  ContentView.swift
//  Menew
//
//  Created by Luca Beetz on 18.02.22.
//

import SwiftUI
import Amplify

struct ContentView: View {
    @StateObject var restaurantProvider = RestaurantProvider()
    
    @StateObject var placementSettings = PlacementSettings()
    @StateObject var sessionSettings = SessionSettings()
    @StateObject var modelDeletionManager = ModelDeletionManager()
    
    var body: some View {
        MapView()
            .environmentObject(placementSettings)
            .environmentObject(sessionSettings)
            .environmentObject(modelDeletionManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
