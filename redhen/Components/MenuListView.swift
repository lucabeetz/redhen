//
//  MenuListView.swift
//  Red Hen
//
//  Created by Luca Beetz on 02.03.22.
//

import SwiftUI

struct MenuListView: View {
    var body: some View {
        VStack() {
            MenuListItem()
                .listRowInsets(EdgeInsets())
            
            MenuListItem()
                .listRowInsets(EdgeInsets())
        }
    }
}

struct MenuListItem: View {
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 8) {
                Image("burger")
                    .resizable()
                    .frame(width: 64, height: 64)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8.0)
                    .padding(.vertical, 8)
                
                VStack(alignment: .leading) {
                    Text("Zeitgeist")
                        .font(.headline)
                    
                    Text("vegane Hähnchenalternative im Knuspermantel, vegane Goldscheibe & Trüffelsoße")
                        .lineLimit(2)
                        .font(.callout)
                }
                .padding(.vertical, 8)
                
                Image(systemName: "chevron.down")
                    .padding(.horizontal, 8)
                    .foregroundColor(Color(red: 211 / 255, green: 198 / 255, blue: 82 / 255))
            }
            
            Divider()
        }
    }
}

struct MenuListView_Previews: PreviewProvider {
    static var previews: some View {
        MenuListView()
    }
}
