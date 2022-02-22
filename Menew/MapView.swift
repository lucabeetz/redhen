//
//  MapView.swift
//  Menew
//
//  Created by Luca Beetz on 21.02.22.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel: MapViewModel = MapViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                Map(coordinateRegion: $viewModel.region, showsUserLocation: true, userTrackingMode: .constant(.none), annotationItems: viewModel.restaurants) { restaurant in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: restaurant.location.lat, longitude: restaurant.location.lon)) {
                        NavigationLink(destination: MenuView(restaurant: restaurant)) {
                            RestaurantAnnotationView()
                        }
                    }
                }
                .ignoresSafeArea()
                .onAppear {
                    viewModel.checkIfLocationServiceIsEnabled()
                }
                
                if !viewModel.activeRestaurants.isEmpty {
                    NavigationLink(destination: MenuView(restaurant: viewModel.activeRestaurants[0])) {
                        Image(systemName: "menucard.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 64)
                            .foregroundColor(Color.orange)
                            .padding(.horizontal, 16.0)
                            .padding(.vertical, 64.0)
                    }
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
