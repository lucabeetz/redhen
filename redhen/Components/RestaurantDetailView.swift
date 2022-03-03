//
//  RestaurantDetailView.swift
//  Red Hen
//
//  Created by Luca Beetz on 02.03.22.
//

import SwiftUI

struct RestaurantDetailView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Hans im Glück")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("Burger and Cocktails")
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Open")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                    
                    Text("12:00 - 22:30")
                }
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Address")
                        .foregroundColor(Color(UIColor.secondaryLabel))
                        .padding(.top, 4)
                    Text("Hauptstraße 20")
                    Text("91054 Erlangen")
                }
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Phone")
                        .foregroundColor(Color(UIColor.secondaryLabel))
                        .padding(.top, 4)
                    Text("+49 9131 6258780")
                        .foregroundColor(Color(UIColor.link))
                }
                
                Spacer()
                
                HStack(spacing: 8) {
                    Button(action: {}) {
                        Image(systemName: "safari")
                            .frame(width: 32, height: 32)
                            .padding(4)
                            .background(Color(UIColor.tertiarySystemBackground))
                            .foregroundColor(Color(UIColor.link))
                            .cornerRadius(8.0)
                    }
                    
                    Button(action: {}) {
                        Image(systemName: "square.and.arrow.up")
                            .frame(width: 32, height: 32)
                            .padding(4)
                            .background(Color(UIColor.tertiarySystemBackground))
                            .foregroundColor(Color(UIColor.link))
                            .cornerRadius(8.0)
                    }
                    
                    Button(action: {}) {
                        Text("Menu")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .frame(width: 64, height: 32)
                            .padding(4)
                            .background(Color(UIColor.link))
                            .foregroundColor(.white)
                            .cornerRadius(8.0)
                    }
                }
            }
            
        }
        .font(.body)
        .padding(16)
        .padding(.bottom, 32)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
        .foregroundColor(Color(UIColor.label))
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailView()
            .preferredColorScheme(.dark)
            .previewLayout(.device)
    }
}
