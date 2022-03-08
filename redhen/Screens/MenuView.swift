//
//  MenuView.swift
//  Red Hen
//
//  Created by Luca Beetz on 06.03.22.
//

import SwiftUI

struct MenuView: View {
    let restaurant: Restaurant
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            MenuListView()
            
            NavigationLink(destination: MenuARView()) {
                FloatingButtonView(iconName: "moon", color: Color(red: 211 / 255, green: 198 / 255, blue: 82 / 255))
            }
            .padding(.trailing, 16)
            .padding(.bottom, 32)
        }
    }
}
