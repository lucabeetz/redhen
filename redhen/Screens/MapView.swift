//
//  MapView.swift
//  Menew
//
//  Created by Luca Beetz on 21.02.22.
//

import SwiftUI
import MapKit
import BetterSafariView
import UIKit

struct MapView: View {
    @EnvironmentObject var mapViewModel: MapViewModel
    @State private var selectedRestaurant: Restaurant?
    @State private var showRestaurantInfo = false
    @State private var askToClose = false
    @State private var askToOpen = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                Map(coordinateRegion: $mapViewModel.region, showsUserLocation: true, userTrackingMode: .constant(.none), annotationItems: mapViewModel.restaurants) { restaurant in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: restaurant.location.lat, longitude: restaurant.location.lon), anchorPoint: CGPoint(x: 0.5, y: 0.95)) {
                        Button(action: {
                            mapViewModel.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: restaurant.location.lat, longitude: restaurant.location.lon), span: mapViewModel.region.span)
                            
                            askToOpen = true
                            withAnimation(.easeInOut(duration: 0.2)) {
                                selectedRestaurant = restaurant
                                showRestaurantInfo = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
                                askToOpen = false
                            }
                        }) {
                            RestaurantAnnotationView(arEnabled: restaurant.ar, selected: restaurant == selectedRestaurant)
                        }
                        //                        if restaurant.ar {
                        //                            NavigationLink(destination: MenuARView()) { RestaurantAnnotationView(arEnabled: true) }
                        //                        } else {
                        //                            OpenMenuViewButton(restaurantToShow: restaurant, content: RestaurantAnnotationView())
                        //                        }
                    }
                }
                .onTapGesture {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        if !askToOpen {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                showRestaurantInfo = false
                                askToOpen = false
                            }
                        }
                    }
                }
                
                VStack {
                    if showRestaurantInfo {
                        RestaurantDetailView(restaurant: selectedRestaurant!)
                            .shadow(color: Color("shadow"), radius: 4, x: 2, y: 2)
                            .padding(.horizontal, 16)
                            .padding(.top, 64)
                            .transition(.opacity)
                    }
                    
                    Spacer()
                }
                
                VStack(alignment: .trailing, spacing: 16.0) {
                    if !mapViewModel.activeRestaurants.isEmpty {
                        NavigationLink(destination: MenuView(restaurant: mapViewModel.activeRestaurants[0])) {
                            FloatingButtonView(iconName: "fork.knife", color: Color("henRed"))
                        }
                        .padding(.trailing, 16)
                    }
                    
                    Button(action: mapViewModel.focusOnUser) {
                        FloatingButtonView(iconName: "location", color: Color("henRed"))
                    }
                    .padding(.trailing, 16)
                }
                .padding(.bottom, 64)
            }
            .ignoresSafeArea()
            .animation(Animation.easeIn(duration: 1), value: mapViewModel.region)
            .popover(isPresented: $mapViewModel.authorizationDenied) {
                Text("Enable location service")
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(MapViewModel())
    }
}
