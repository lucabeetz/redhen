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
    var selected = false
    var notification = false
    var open = true
    var type = RestaurantType.restaurant
    
    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                Circle()
                    .fill(open ? Color("orangeDark") : Color("grayDark"))
                    .frame(width: 40, height: 40)
                
                Circle()
                    .fill(open ? Color("orangeBright") : Color("grayBright"))
                    .frame(width: 34, height: 34)
                
                switch(type) {
                case RestaurantType.restaurant:
                    Image(systemName: "fork.knife")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                case RestaurantType.cocktail:
                    TintedSVGIcon(imageName: "cocktail", size: 22)
                case RestaurantType.cafe:
                    TintedSVGIcon(imageName: "cafe", size: 22)
                case RestaurantType.toGo:
                    TintedSVGIcon(imageName: "takeaway", size: 22)
                }
                
                if arEnabled {
                    ZStack {
                        RoundedRectangle(cornerRadius: 4.0, style: .circular)
                            .fill(Color("greenDark"))
                            .frame(width: 21, height: 13)
                        
                        RoundedRectangle(cornerRadius: 3.0, style: .circular)
                            .fill(Color("greenBright"))
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
                    .foregroundColor(Color("orangeDark"))
                    .offset(x: 0, y: -3)
            } else {
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(Color("grayDark"))
                    .offset(x: 0, y: -3)
            }
        }
    }
}

struct RestaurantAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantAnnotationView(arEnabled: false, notification: false)
            .previewLayout(.sizeThatFits)
        
        RestaurantAnnotationView(arEnabled: false, selected: false, notification: true, type: .cocktail)
            .previewLayout(.sizeThatFits)
        
        RestaurantAnnotationView(arEnabled: true, selected: true, notification: true, type: .cafe)
            .previewLayout(.sizeThatFits)
        
        RestaurantAnnotationView(arEnabled: false, selected: false, notification: true, open: false, type: .toGo)
            .previewLayout(.sizeThatFits)
        
        RestaurantAnnotationView(arEnabled: true, selected: true, notification: true, open: false)
            .previewLayout(.sizeThatFits)
    }
}

struct TintedSVGIcon: View {
    let imageName: String
    let size: CGFloat
    
    var body: some View {
        ZStack(alignment: .top) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: size)
            Color.white.blendMode(.sourceAtop)
        }
        .drawingGroup(opaque: false)
        .frame(width: size, height: size)
        
    }
}
