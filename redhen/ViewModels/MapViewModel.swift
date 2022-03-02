//
//  MapViewModel.swift
//  Menew
//
//  Created by Luca Beetz on 21.02.22.
//

import MapKit
import Amplify
import SwiftUI

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 50.996254, longitude: 10.334109)
    static let defaultOverviewSpan = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    static let defaultUserSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
}

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultOverviewSpan)
    
    @Published var restaurants: [Restaurant] = []
    @Published var activeRestaurants: [Restaurant] = []
    
    @Published var authorizationDenied: Bool = false
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func focusOnUser() {
        guard let userCoords = locationManager.location?.coordinate else { return }
        region = MKCoordinateRegion(center: userCoords, span: MapDetails.defaultUserSpan)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            authorizationDenied = false
            manager.requestWhenInUseAuthorization()
        case .restricted:
            authorizationDenied = true
            break
        case .denied:
            authorizationDenied = true
            break
        case .authorizedAlways, .authorizedWhenInUse:
            authorizationDenied = false
            focusOnUser()
            updateRestaurants()
            updateActiveRestaurants()
        @unknown default:
            authorizationDenied = true
            break
        }
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
