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
    
    var body: some View {
//        RealityKitView()
//        MenuARView()
        MapView()
            .environmentObject(placementSettings)
            .environmentObject(sessionSettings)
//        VStack {
//            if restaurantProvider.nearestRestaurants.isEmpty {
//                ProgressView()
//            } else {
//                WebView(url: restaurantProvider.nearestRestaurants[0].menu!)
//                    .edgesIgnoringSafeArea(.bottom)
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
