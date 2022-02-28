//
//  SessionSettings.swift
//  Red Hen
//
//  Created by Luca Beetz on 28.02.22.
//

import SwiftUI

class SessionSettings: ObservableObject {
    @Published var isPeopleOcclusionEnabled: Bool = false
    @Published var isObjectOcclusionEnabled: Bool = false
    @Published var isLidarDebugEnabled: Bool = false
}
