//
//  MenuARView.swift
//  Red Hen
//
//  Created by Luca Beetz on 26.02.22.
//

import SwiftUI

struct MenuARView: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    
    @State var showSettings = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ARDisplayView()
            
            VStack(spacing: 16) {
                Button() {
                    print("Add Entity")
                    placementSettings.placeObject = true
                } label: {
                    ZStack{
                        Circle()
                            .fill(Color(red: 255 / 255, green: 159 / 255, blue: 10 / 255))
                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                            .frame(width: 48, height: 48)
                        
                        Image(systemName: "plus")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                    }
                }
                
                Button() {
                    print("Switch Entity")
                    placementSettings.changeActiveEntity()
                } label: {
                    ZStack{
                        Circle()
                            .fill(Color(red: 255 / 255, green: 159 / 255, blue: 10 / 255))
                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                            .frame(width: 48, height: 48)
                        
                        Image(systemName: "arrow.right")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                    }
                }
                
                Button() {
                    print("Show settings")
                    showSettings.toggle()
                } label: {
                    ZStack{
                        Circle()
                            .fill(Color(red: 255 / 255, green: 159 / 255, blue: 10 / 255))
                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                            .frame(width: 48, height: 48)
                        
                        Image(systemName: "gearshape")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                    }
                }
                .sheet(isPresented: $showSettings) {
                    SettingsView(showSettings: $showSettings)
                }
                
            }
            .padding(.bottom, 64)
            .padding(.trailing, 16)
        }
        .ignoresSafeArea()
    }
}

struct MenuARView_Previews: PreviewProvider {
    static var previews: some View {
        MenuARView()
    }
}
