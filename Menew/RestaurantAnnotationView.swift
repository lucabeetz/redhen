//
//  RestaurantAnnotationView.swift
//  Menew
//
//  Created by Luca Beetz on 21.02.22.
//

import SwiftUI

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
        .offset(x: 0, y: -15)
    }
}

struct RestaurantAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantAnnotationView()
    }
}
