//
//  FloatingButtonView.swift
//  Red Hen
//
//  Created by Luca Beetz on 01.03.22.
//

import SwiftUI

struct FloatingButtonView: View {
    let iconName: String
    let color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .fill(color)
                .shadow(color: Color("shadow"), radius: 4, x: 0, y: 4)
                .frame(width: 48, height: 48)
            
            Image(systemName: iconName)
                .font(.system(size: 22))
                .foregroundColor(.white)
            
        }
    }
}

struct FloatingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButtonView(iconName: "fork.knife", color: Color("orangeBright"))
    }
}
