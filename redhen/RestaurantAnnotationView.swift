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

struct RestaurantAnnotationView: UIViewRepresentable {
    @State var mkAnnotation: MKAnnotation? = nil
    
    typealias UIViewType = MKAnnotationView
    
    func makeUIView(context: Context) -> MKAnnotationView {
        let view = MKAnnotationView(annotation: self.mkAnnotation, reuseIdentifier: nil)
        view.image = UIImage(systemName: "mappin")
        
        
        
        return view
    }
    
    func updateUIView(_ uiView: MKAnnotationView, context: Context) {
        
    }
    
    /*
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
        .offset(x: 0, y: -15)
    }*/
    
    
}

class RestaurantMKAnnotation: NSObject, MKAnnotation {
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
    
    func toMKAnnotationView() -> MKAnnotationView {
        let annotationView = MKAnnotationView(annotation: self, reuseIdentifier: self.restaurant.id)
        annotationView.canShowCallout = true
        annotationView.image = UIImage(systemName: "location.circle")?.withTintColor(.systemGreen,renderingMode: .alwaysOriginal)
        let size = CGSize(width: 40, height: 40)
        annotationView.image = UIGraphicsImageRenderer(size:size).image {
            _ in annotationView.image!.draw(in:CGRect(origin:.zero, size:size))
        }
        return annotationView
        }
    }

struct RestaurantAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantAnnotationView()
    }
}
