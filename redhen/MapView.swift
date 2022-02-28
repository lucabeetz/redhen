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
    @StateObject private var viewModel: MapViewModel = MapViewModel()
    
    var body: some View {
        NavigationView {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, userTrackingMode: .constant(.none), annotationItems: viewModel.restaurants) { restaurant in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: restaurant.location.lat, longitude: restaurant.location.lon), anchorPoint: CGPoint(x: 0.5, y: 0.95)) {
                    if restaurant.ar {
                        NavigationLink(destination: MenuARView()) { RestaurantAnnotationView(arEnabled: true) }
                    } else {
                        OpenMenuViewButton(restaurantToShow: restaurant, content: RestaurantAnnotationView())
                    }
                }
            }
            .overlay(alignment: .bottomTrailing) {
                VStack {
                    if !viewModel.activeRestaurants.isEmpty {
                        NavigationLink(destination: MenuView(restaurant: viewModel.activeRestaurants[0])) {
                            ZStack {
                                Circle()
                                    .fill(Color("orangeBright"))
                                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                                    .frame(width: 48, height: 48)
                                
                                Image(systemName: "fork.knife")
                                    .font(.system(size: 22))
                                    .foregroundColor(.white)
                                
                            }
                            .padding(.horizontal, 16.0)
                            .padding(.vertical, 64.0)
                        }
                    }
                    LocateUserButton(action: viewModel.focusOnUser)
                }
                .offset(x: -10, y: -100)
            }
            .ignoresSafeArea()
            .animation(Animation.easeIn(duration: 1), value: viewModel.region)
            .popover(isPresented: $viewModel.authorizationDenied) {
                
                Text("Enable location service")
                
            }
        }
    }
    
    
    struct LocateUserButton: View {
        private let action: () -> Void
        
        init(action: @escaping () -> Void) {
            self.action = action
        }
        
        var body: some View {
            Button(action: action) {
                ZStack{
                    Circle()
                        .fill(Color("orangeBright"))
                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                        .frame(width: 48, height: 48)
                    
                    Image(systemName: "location")
                        .font(.system(size: 22))
                        .foregroundColor(.white)
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

/*struct MapView: UIViewRepresentable {
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
 view.userTrackingMode = .followWithHeading
 view.pointOfInterestFilter = MKPointOfInterestFilter(including: [])
 view.showsBuildings = true
 view.showsUserLocation = true
 view.showsCompass = true
 // show compasss
 let compassButton = MKCompassButton(mapView: view)
 compassButton.frame.origin = CGPoint(x: 20, y: 20)
 compassButton.compassVisibility = .visible
 view.addSubview(compassButton)
 
 let restAnno = UIHostingController(rootView: RestaurantAnnotationView())
 view.addSubview(restAnno.view)
 view.layoutSubviews()
 
 return view
 }
 
 func updateUIView(_ view: MKMapView, context: Context) {
 view.addAnnotations(viewModel.restaurants.map({
 (restaurant: Restaurant) -> MKRestaurantAnnotation in
 return MKRestaurantAnnotation(restaurant: restaurant)}))
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
 else if(annotation.isKind(of: MKRestaurantAnnotation.self)) {
 return (annotation as! MKRestaurantAnnotation).view()
 }
 }
 
 
 func mapView(_ mapView: MKMapView, didSelect annotationView: MKAnnotationView) {
 var restaurant: Restaurant
 if(annotationView.annotation!.isKind(of: RestaurantMKAnnotation.self) ) {
 restaurant = (annotationView.annotation as! RestaurantMKAnnotation).restaurant
 }
 mapView NavigationLink(destination: MenuView(restaurant: restaurant)) {
 RestaurantAnnotationView()
 }
 }
 }
 }*/
