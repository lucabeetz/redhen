//
//  queries.swift
//  Menew
//
//  Created by Luca Beetz on 20.02.22.
//

import Amplify

extension GraphQLRequest where R == [Restaurant] {
    static func getNearbyRestaurants(lat: Float, lon: Float, radius: Int) -> Self {
        let nearbyRestaurantsQuery = """
        query NearbyRestaurants($lat: Float!, $lon: Float!, $radius: Int!) {
            nearbyRestaurants(
                location: {
                    lat: $lat
                    lon: $lon
                },
                radius: $radius
                limit: 10
            ) {
                nextToken
                items {
                    id
                    name
                    menu
                    location {
                        lat
                        lon
                    }
                }
            }
        }
        """
        
        return GraphQLRequest(document: nearbyRestaurantsQuery,
                              variables: ["lat": lat, "lon": lon, "radius": radius],
                              responseType: [Restaurant].self,
                              decodePath: "nearbyRestaurants.items")
    }
}
