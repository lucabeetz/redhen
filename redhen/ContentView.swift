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
    
    var body: some View {
        RealityKitView()
//        MapView()
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
