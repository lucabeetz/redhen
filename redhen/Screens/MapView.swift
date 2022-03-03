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
                            selectedRestaurant = restaurant
                            mapViewModel.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: restaurant.location.lat, longitude: restaurant.location.lon), span: mapViewModel.region.span)
                        
                            askToOpen = true
                            withAnimation(.easeInOut(duration: 0.2)) {
                                showRestaurantInfo = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
                                askToOpen = false
                            }
                        }) {
                            RestaurantAnnotationView(arEnabled: restaurant.ar)
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
                    
                    if showRestaurantInfo {
                        RestaurantDetailView()
                            .transition(.move(edge: .bottom))
                            .shadow(color: Color("shadow"), radius: 4, x: 0, y: -4)
                        
                    }
                }
                .padding(.bottom, showRestaurantInfo ? 0 : 64)
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
