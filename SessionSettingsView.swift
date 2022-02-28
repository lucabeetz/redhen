//
//  SessionSettingsView.swift
//  Red Hen
//
//  Created by Luca Beetz on 28.02.22.
//

import SwiftUI

enum Setting {
    case peopleOcclusion
    case objectOcclusion
    case lidarDebug
    
    var label: String {
        get {
            switch self {
            case .peopleOcclusion, .objectOcclusion:
                return "Occlusion"
            case .lidarDebug:
                return "LiDAR"
            }
        }
    }
    
    var systemIconName: String {
        get {
            switch self {
            case .peopleOcclusion:
                return "person"
            case .objectOcclusion:
                return "cube.box.fill"
            case .lidarDebug:
                return "light.min"
            }
        }
    }
}

struct SettingsView: View {
    @Binding var showSettings: Bool
    
    var body: some View {
        NavigationView {
            SettingsGrid()
                .navigationBarTitle(Text("Settings"), displayMode: .inline)
        }
    }
}

struct SettingsGrid: View {
    @EnvironmentObject var arSceneManager: ARSceneManager
    
    private var gridItemLayout = [GridItem(.adaptive(minimum: 100, maximum: 100), spacing: 24)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout, spacing: 24) {
                SettingToggleButton(setting: .peopleOcclusion, isOn: $arSceneManager.isPeopleOcclusionEnabled)
                SettingToggleButton(setting: .objectOcclusion, isOn: $arSceneManager.isObjectOcclusionEnabled)
                SettingToggleButton(setting: .lidarDebug, isOn: $arSceneManager.isLidarDebugEnabled)
            }
        }
        .padding(.top, 32)
    }
}

struct SettingToggleButton: View {
    let setting: Setting
    @Binding var isOn: Bool
    
    var body: some View {
        Button(action: {
            self.isOn.toggle()
        }) {
            VStack {
                Image(systemName: setting.systemIconName)
                    .font(.system(size: 36))
                    .foregroundColor(self.isOn ? .green : Color(UIColor.secondaryLabel))
                    .buttonStyle(PlainButtonStyle())
                
                Text(setting.label)
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .foregroundColor(self.isOn ? Color(UIColor.label) : Color(UIColor.secondaryLabel))
                    .padding(.top, 4)
            }
        }
        .frame(width: 100, height: 100)
        .background(Color(UIColor.secondarySystemFill))
        .cornerRadius(20)
    }
}
