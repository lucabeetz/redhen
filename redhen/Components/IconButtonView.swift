//
//  IconButtonView.swift
//  Red Hen
//
//  Created by Luca Beetz on 02.03.22.
//

import SwiftUI

struct IconButtonView: View {
    let action: () -> Void
    var iconName: String? = nil
    var label: String? = nil
    var width = 32.0
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                if iconName != nil {
                    Image(systemName: iconName!)
                }
                
                if label != nil {
                    Text(label!)
                        .font(.caption)
                        .fontWeight(.medium)
                }
            }
            .frame(width: width, height: 32)
            .padding(4)
            .background(Color(UIColor.tertiarySystemBackground))
            .foregroundColor(Color(UIColor.link))
            .cornerRadius(8.0)
        }
    }
}

struct IconButtonView_Previews: PreviewProvider {
    static var previews: some View {
        IconButtonView(action: {}, iconName: "safari", label: "Website")
    }
}
