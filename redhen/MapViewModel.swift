//
//  MapViewModel.swift
//  Menew
//
//  Created by Luca Beetz on 21.02.22.
//

import MapKit
import Amplify
import SwiftUI

extension MKCoordinateSpan: Equatable {
   public static func == (lhs: MKCoordinateSpan, rhs: MKCoordinateSpan) -> Bool {
       return lhs.latitudeDelta == rhs.latitudeDelta &&
               lhs.longitudeDelta == rhs.longitudeDelta
   }
}

extension CLLocationCoordinate2D: Equatable {
   public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
       return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
   }
}

extension MKCoordinateRegion: Equatable {
   public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
       return lhs.span == rhs.span &&
       lhs.center == rhs.center
   }
}

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 50.996254, longitude: 10.334109)
    static let defaultOverviewSpan = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    static let defaultUserSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
}

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultOverviewSpan)
    
    @Published var restaurants: [Restaurant] = []
    @Published var activeRestaurants: [Restaurant] = []
    
    var locationManager: CLLocationManager = CLLocationManager()
    private var didFocusOnUser: Bool = false
    
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func focusOnUserOnce() {
        if(!didFocusOnUser) {
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDetails.defaultUserSpan)
            didFocusOnUser = true
        }
    }
    
    func checkIfLocationServiceIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
        } else {
            print("Location services disabled")
        }
    }
    
    private func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDetails.defaultUserSpan)
            updateRestaurants()
            updateActiveRestaurants()
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func updateRestaurants() {
        guard let location = locationManager.location else { return }
        
        Amplify.API.query(request: .getNearbyRestaurants(lat: Float(location.coordinate.latitude), lon: Float(location.coordinate.longitude), radius: 3000)) { response in
            switch(response) {
            case .success(let result):
                switch(result) {
                case .success(let restaurants):
                    DispatchQueue.main.async {
                        self.restaurants = restaurants
                    }
                case .failure(let error):
                    print("GraphQL error when retrieving nearest restaurants: \(error)")
                }
            case .failure(let apiError):
                print("API error when retrieving nearest restaurants: \(apiError)")
            }
        }
    }
    
    func updateActiveRestaurants() {
        guard let location = locationManager.location else { return }
        
        Amplify.API.query(request: .getNearbyRestaurants(lat: Float(location.coordinate.latitude), lon: Float(location.coordinate.longitude), radius: 25)) { response in
            switch(response) {
            case .success(let result):
                switch(result) {
                case .success(let restaurants):
                    DispatchQueue.main.async {
                        self.activeRestaurants = restaurants
                    }
                case .failure(let error):
                    print("GraphQL error when retrieving nearest restaurants: \(error)")
                }
            case .failure(let apiError):
                print("API error when retrieving nearest restaurants: \(apiError)")
            }
        }
    }
}
