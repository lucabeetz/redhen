//
//  ContentView.swift
//  Menew
//
//  Created by Luca Beetz on 18.02.22.
//

import SwiftUI
import Amplify

struct ContentView: View {
    @StateObject var arSceneManager = ARSceneManager()
    
    var body: some View {
        MapView()
            .environmentObject(arSceneManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
