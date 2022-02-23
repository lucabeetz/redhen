//
//  MenuView.swift
//  Menew
//
//  Created by Luca Beetz on 21.02.22.
//

import SwiftUI

struct MenuView: View {
    let restaurant: Restaurant
    
    var body: some View {
        WebView(url: restaurant.menu!)
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle(restaurant.name)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        let restaurant = Restaurant(id: "1", name: "Galileo", menu: "https://www.galileo-erlangen.de/wp-content/uploads/SpeisekarteOnline.pdf", location: Location(lat: 10, lon: 10))
        MenuView(restaurant: restaurant)
    }
}
