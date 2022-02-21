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
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: viewModel.restaurants) {
            MapMarker(coordinate: CLLocationCoordinate2D(latitude: $0.location.lat, longitude: $0.location.lon))
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.checkIfLocationServiceIsEnabled()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
