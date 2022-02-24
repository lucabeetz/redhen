//
//  MapViewModel.swift
//  Menew
//
//  Created by Luca Beetz on 21.02.22.
//

import MapKit
import Amplify

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 49.589349, longitude: 11.012710)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
}


class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan)
    
    @Published var restaurants: [Restaurant] = []
    @Published var activeRestaurants: [Restaurant] = []
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServiceIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Location services disabled")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }

        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDetails.defaultSpan)
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
        guard let location = locationManager?.location else { return }
        
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
        guard let location = locationManager?.location else { return }
        
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

