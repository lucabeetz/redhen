//
//  MenuARView.swift
//  Red Hen
//
//  Created by Luca Beetz on 26.02.22.
//

import SwiftUI

struct MenuARView: View {
    @EnvironmentObject var menuARViewModel: MenuARViewModel
    
    @State var showSettings = false
    @State var showMenu = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ARDisplayView()
            
            VStack(spacing: 16) {
                Button() {
                    print("Open menu")
                    showMenu = true
                } label: {
                    FloatingButtonView(iconName: "menucard", color: Color("greenHig"))
                }
                
                Button() {
                    print("Add Entity")
                    menuARViewModel.placeObject = true
                } label: {
                    FloatingButtonView(iconName: "plus", color: Color("greenHig"))
                }
                
                Button() {
                    print("Show settings")
                    showSettings.toggle()
                } label: {
                    FloatingButtonView(iconName: "gearshape", color: Color("greenHig"))
                }
                .sheet(isPresented: $showSettings) {
                    SettingsView(showSettings: $showSettings)
                }
                
                Button() {
                    print("Delete entity")
                    menuARViewModel.delete()
                } label: {
                    FloatingButtonView(iconName: "trash", color: menuARViewModel.entitySelectedForDeletion == nil ? Color("grayDark") : Color("henRed"))
                }
                .disabled(menuARViewModel.entitySelectedForDeletion == nil)
                
            }
            .padding(.bottom, 64)
            .padding(.trailing, 16)
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showMenu) {
            MenuListView()
                .padding(.top, 8)
        }
    }
}

struct MenuARView_Previews: PreviewProvider {
    static var previews: some View {
        MenuARView()
    }
}
