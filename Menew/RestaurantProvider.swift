//
//  RestaurantProvider.swift
//  Menew
//
//  Created by Luca Beetz on 20.02.22.
//

import Foundation
import Amplify

class RestaurantProvider: ObservableObject {
    @Published var nearestRestaurants: [Restaurant] = []
    
    init() {
        updateNearestRestaurants()
    }
    
    func updateNearestRestaurants() {
        Amplify.API.query(request: .getNearbyRestaurants(lat: 11, lon: 11, radius: 50)) { response in
            switch(response) {
            case .success(let result):
                switch(result) {
                    case .success(let restaurants):
                    DispatchQueue.main.async {
                        self.nearestRestaurants = restaurants
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
