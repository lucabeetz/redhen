//
//  Utils.swift
//  Red Hen
//
//  Created by Luca Beetz on 28.02.22.
//

import Foundation
import MapKit

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
