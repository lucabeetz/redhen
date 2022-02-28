//
//  MenuARView.swift
//  Red Hen
//
//  Created by Luca Beetz on 26.02.22.
//

import SwiftUI

struct MenuARView: View {
    @EnvironmentObject var arSceneManager: ARSceneManager
    
    @State var showSettings = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ARDisplayView()
            
            VStack(spacing: 16) {
                Button() {
                    print("Add Entity")
                    arSceneManager.placeObject = true
                } label: {
                    ZStack{
                        Circle()
                            .fill(Color("orangeBright"))
                            .shadow(color: Color("shadow"), radius: 4, x: 0, y: 4)
                            .frame(width: 48, height: 48)
                        
                        Image(systemName: "plus")
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
                            .fill(Color("orangeBright"))
                            .shadow(color: Color("shadow"), radius: 4, x: 0, y: 4)
                            .frame(width: 48, height: 48)
                        
                        Image(systemName: "gearshape")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                    }
                }
                .sheet(isPresented: $showSettings) {
                    SettingsView(showSettings: $showSettings)
                }
                
                Button() {
                    print("Delete entity")
                    arSceneManager.delete()
                } label: {
                    ZStack{
                        if arSceneManager.entitySelectedForDeletion == nil {
                            Circle()
                                .fill(Color("grayDark"))
                                .shadow(color: Color("shadow"), radius: 4, x: 0, y: 4)
                                .frame(width: 48, height: 48)
                        } else {
                            Circle()
                                .fill(Color("orangeBright"))
                                .shadow(color: Color("shadow"), radius: 4, x: 0, y: 4)
                                .frame(width: 48, height: 48)
                        }
                        
                        Image(systemName: "trash")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                    }
                }
                .disabled(arSceneManager.entitySelectedForDeletion == nil)
                
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
