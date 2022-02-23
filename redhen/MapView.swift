//
//  MapView.swift
//  Menew
//
//  Created by Luca Beetz on 21.02.22.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @StateObject private var viewModel: MapViewModel = MapViewModel()
        
    typealias UIViewType = MKMapView
    
    func makeUIView(context: Context) -> MKMapView {
        let view = MKMapView()
        view.delegate = context.coordinator
        view.region = viewModel.region
        view.mapType = MKMapType.standard
        view.isZoomEnabled = true
        view.isScrollEnabled = true
        view.isRotateEnabled = true
        view.userTrackingMode = .follow
        view.pointOfInterestFilter = MKPointOfInterestFilter(including: [])
        view.showsBuildings = true
        view.showsUserLocation = true
        
        return view
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.addAnnotations(viewModel.restaurants.map({
            (restaurant: Restaurant) -> RestaurantMKAnnotation in
            return RestaurantMKAnnotation(restaurant: restaurant)}))
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
            parent.viewModel.checkIfLocationServiceIsEnabled()
        }
            
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // Don't modify user dot design
            if(annotation.isKind(of: MKUserLocation.self)) {
                return nil
            }
            let annotationView = MKMarkerAnnotationView()
            annotationView.markerTintColor = .systemOrange
            return annotationView
        }
        
        
        /*func mapView(_ mapView: MKMapView, didSelect annotationView: MKAnnotationView) {
            var restaurant: Restaurant
            if(annotationView.annotation!.isKind(of: RestaurantMKAnnotation.self) ) {
                restaurant = (annotationView.annotation as! RestaurantMKAnnotation).restaurant
            }
            mapView NavigationLink(destination: MenuView(restaurant: restaurant)) {
                RestaurantAnnotationView()
            }
        }*/
    }
}
/*
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
}*/

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
