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
    var arEnabled = false
    var notification = false
    var open = true
    
    var body: some View {
        VStack {
            ZStack {
                if open {
                    Circle()
                        .fill(Color(red: 229 / 255, green: 140 / 255, blue: 0 / 255))
                        .frame(width: 40, height: 40)
                    
                    Circle()
                        .fill(Color(red: 255 / 255, green: 159 / 255, blue: 10 / 255))
                        .frame(width: 34, height: 34)
                } else {
                    Circle()
                        .fill(Color(red: 103 / 255, green: 103 / 255, blue: 103 / 255))
                        .frame(width: 40, height: 40)
                    
                    Circle()
                        .fill(Color(red: 143 / 255, green: 143 / 255, blue: 143 / 255))
                        .frame(width: 34, height: 34)
                }
                
                Image(systemName: "fork.knife")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                
                if arEnabled {
                    ZStack {
                        RoundedRectangle(cornerRadius: 4.0, style: .circular)
                            .fill(Color(red: 2 / 255, green: 99 / 255, blue: 0 / 255))
                            .frame(width: 21, height: 13)
                        
                        RoundedRectangle(cornerRadius: 3.0, style: .circular)
                            .fill(Color(red: 69 / 255, green: 181 / 255, blue: 0 / 255))
                            .frame(width: 19, height: 11)
                        
                        Text("AR")
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                    .offset(x: -15, y: -17)
                }
                
                if notification && open {
                    Circle()
                        .fill(.red)
                        .frame(width: 12, height: 12)
                        .offset(x: 14, y: -14)
                }
            }
            
            if open {
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(Color(red: 229 / 255, green: 140 / 255, blue: 0 / 255))
                    .offset(x: 0, y: -3)
            } else {
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(Color(red: 103 / 255, green: 103 / 255, blue: 103 / 255))
                    .offset(x: 0, y: -3)
            }
        }
    }
}

struct RestaurantAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantAnnotationView(arEnabled: false, notification: false)
            .previewLayout(.sizeThatFits)
        
        RestaurantAnnotationView(arEnabled: false, notification: true)
            .previewLayout(.sizeThatFits)
        
        RestaurantAnnotationView(arEnabled: true, notification: true)
            .previewLayout(.sizeThatFits)
        
        RestaurantAnnotationView(arEnabled: false, notification: true, open: false)
            .previewLayout(.sizeThatFits)
        
        RestaurantAnnotationView(arEnabled: true, notification: true, open: false)
            .previewLayout(.sizeThatFits)
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
