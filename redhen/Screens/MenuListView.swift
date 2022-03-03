//
//  MenuListView.swift
//  Red Hen
//
//  Created by Luca Beetz on 02.03.22.
//

import SwiftUI

struct MenuListView: View {
    @State private var selectedIndex: Int? = nil
    
    var body: some View {
        ScrollView {
            ForEach(0..<2) { index in
                MenuListItem(isExpanded: self.selectedIndex == index, chevronCallback: { selectDeselectItem(index) }, plusCallback: {})
                    .listRowInsets(EdgeInsets())
                    .onTapGesture {
                        print("Tapped on \(index)")
                    }
            }
        }
        .navigationTitle("Hans im Glück - Menu")
    }
    
    private func selectDeselectItem(_ index: Int) {
        withAnimation(.spring()) {
            if (selectedIndex == index) {
                self.selectedIndex = nil
            } else {
                self.selectedIndex = index
            }
        }
    }
}

struct MenuListItem: View {
    let isExpanded: Bool
    
    let chevronCallback: () -> Void
    let plusCallback: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 8) {
                Image("burger")
                    .resizable()
                    .frame(width: isExpanded ? 84 : 64, height: isExpanded ? 84 : 64)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8.0)
                    .padding(.vertical, 8)
                
                VStack(alignment: .leading) {
                    HStack(alignment: .bottom) {
                        Text("Zeitgeist")
                            .font(.headline)
                        
                        Text("9,50€")
                            .font(.subheadline)
                            .foregroundColor(Color(UIColor.secondaryLabel))
                            .transition(.opacity)
                            .opacity(isExpanded ? 1 : 0)
                    }
                    
                    Spacer()
                    
                    Text("vegane Hähnchenalternative im Knuspermantel, vegane Goldscheibe & Trüffelsoße")
                        .lineLimit(isExpanded ? nil : 2)
                        .font(.callout)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                }
                .padding(.vertical, 8)
                
                Spacer()
                
                VStack {
                    
                    Button(action: chevronCallback) {
                        Image(systemName: "chevron.down")
                            .foregroundColor(Color(red: 211 / 255, green: 198 / 255, blue: 82 / 255))
                            .rotationEffect(.degrees(isExpanded ? 180 : 0))
                            .font(.system(size: 24))
                    }
                    
                    Spacer()
                    
                    Button(action: plusCallback) {
                        Image(systemName: "plus")
                            .foregroundColor(Color(red: 211 / 255, green: 198 / 255, blue: 82 / 255))
                            .disabled(!isExpanded)
                            .scaleEffect(isExpanded ? 1 : 0)
                            .font(.system(size: 24))
                    }
                }
                .padding(8)
            }
            
            Divider()
        }
        .padding(.horizontal, 8)
    }
}

struct MenuListView_Previews: PreviewProvider {
    static var previews: some View {
        MenuListView()
        
    }
}
