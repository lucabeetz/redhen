//
//  MenuView.swift
//  Menew
//
//  Created by Luca Beetz on 21.02.22.
//

import SwiftUI
import BetterSafariView

struct OpenAdvancedWebViewButton<Content>: View where Content : View {
    let restaurantToShow: Restaurant
    let content: Content
    
    @State private var shownRestaurant: Restaurant?
    
    public var body: some View {
        return Button(action: {
            shownRestaurant = restaurantToShow
        }) {
            content
        }
        .safariView(
            item: $shownRestaurant,
            onDismiss: {
                shownRestaurant = nil
            },
            content: {item in AdvancedWebView.SafariView(restaurant: item)}
        )
    }
}

struct AdvancedWebView: View {
    let restaurant: Restaurant
    
    static func SafariView(restaurant: Restaurant) -> SafariView {
        return BetterSafariView.SafariView(
            url: URL(string: restaurant.menu![0])!,
            configuration: BetterSafariView.SafariView.Configuration(
                entersReaderIfAvailable: false,
                barCollapsingEnabled: true
            )
        )
        .preferredBarAccentColor(.clear)
        .preferredControlAccentColor(.accentColor)
        .dismissButtonStyle(.done)
    }
    
    var body: some View {
        WebView(url: restaurant.menu![0])
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle(restaurant.name)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct AdvancedWebView_Previews: PreviewProvider {
    static var previews: some View {
        let restaurant = Restaurant(id: "1", name: "Galileo", menu: ["https://www.galileo-erlangen.de/wp-content/uploads/SpeisekarteOnline.pdf"], location: Location(lat: 10, lon: 10), type: RestaurantType.restaurant, ar: false)
        AdvancedWebView(restaurant: restaurant)
    }
}
