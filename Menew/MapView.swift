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
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, userTrackingMode: .constant(.none), annotationItems: viewModel.restaurants) { restaurant in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: restaurant.location.lat, longitude: restaurant.location.lon)) {
                    NavigationLink(destination: MenuView(restaurant: restaurant)) {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 44, height: 44)
                    }
                }
            }
            .ignoresSafeArea()
            .onAppear {
                viewModel.checkIfLocationServiceIsEnabled()
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
