//
//  ContentView.swift
//  Menew
//
//  Created by Luca Beetz on 18.02.22.
//

import SwiftUI
import Amplify

struct ContentView: View {
    @State var menuUrl: String?
    
    var body: some View {
        VStack {
            if menuUrl != nil {
                WebView(url: menuUrl!)
                    .edgesIgnoringSafeArea(.bottom)
            } else {
                ProgressView()
            }
        }
        .onAppear(perform: performOnAppear)
    }
    
    func performOnAppear() {
        Amplify.API.query(request: .getNearbyRestaurants(lat: 11, lon: 11, radius: 50)) { result in
            switch(result) {
            case .success(let restaurants):
                switch(restaurants) {
                case .success(let restaurants):
                    for restaurant in restaurants {
                        print("==== Restaurant ====")
                        print("Name: \(restaurant.name)")
                        if let menu = restaurant.menu {
                            print("Menu: \(menu)")
                            menuUrl = menu
                        }
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            case .failure(let error):
                print("Could not query DataStore: \(error)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
