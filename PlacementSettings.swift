//
//  PlacementSettings.swift
//  Red Hen
//
//  Created by Luca Beetz on 25.02.22.
//

import Foundation
import Combine

class PlacementSettings: ObservableObject {
    @Published var placeObject = true
    
    var sceneObserver: Cancellable?
}
