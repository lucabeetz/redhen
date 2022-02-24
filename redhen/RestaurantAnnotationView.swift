//
//  RestaurantAnnotationView.swift
//  Menew
//
//  Created by Luca Beetz on 21.02.22.
//

import SwiftUI
import MapKit
import CoreFoundation
import CoreGraphics

struct RestaurantAnnotationView: View {
    var body: some View {
        VStack {
            Image(systemName: "mappin.circle.fill")
                .font(.title)
                .foregroundColor(.orange)
            
            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .foregroundColor(.orange)
                .offset(x: 0, y: -5)
        }
    }
}

struct RestaurantAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantAnnotationView()
    }
}

/*class MKRestaurantAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    
    let restaurant: Restaurant
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
        
        self.coordinate = CLLocationCoordinate2D(latitude: restaurant.location.lat, longitude: restaurant.location.lon)
        self.title = restaurant.name
        self.subtitle = nil
    }
    
    func view() -> MKAnnotationView {
        let annotationView = MKAnnotationView(annotation: self, reuseIdentifier: self.restaurant.id)
        annotationView.canShowCallout = true
        annotationView.image = UIImage(systemName: "location.circle")?.withTintColor(.systemGreen,renderingMode: .alwaysOriginal)
        
        let size = CGSize(width: 40, height: 40)
        annotationView.image = UIGraphicsImageRenderer(size:size).image {
            _ in annotationView.image!.draw(in:CGRect(origin:.zero, size:size))
        }
        return annotationView
    }
    
    class MKRestaurantAnnotationView: MKAnnotationView {
        init(annotation: MKRestaurantAnnotation?, reuseIdentifier: String?) {
            super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        }
        
        override func draw(_ rect: CGRect) {
            guard let context = UIGraphicsGetCurrentContext() else { return }

                    context.beginPath()
                    context.move(to: CGPoint(x: rect.midX, y: rect.maxY))
                    context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
                    context.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
                    context.closePath()

                    UIColor.blue.set()
                    context.fillPath()
        }
    }
}*/
