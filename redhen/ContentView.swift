//
//  ContentView.swift
//  Menew
//
//  Created by Luca Beetz on 18.02.22.
//

import SwiftUI
import Amplify

struct ContentView: View {
    @StateObject var mapViewModel = MapViewModel()
    @StateObject var menuARViewModel = MenuARViewModel()
    
    var body: some View {
        MapView()
            .environmentObject(mapViewModel)
            .environmentObject(menuARViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
