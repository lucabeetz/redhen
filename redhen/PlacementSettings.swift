//
//  PlacementSettings.swift
//  Red Hen
//
//  Created by Luca Beetz on 25.02.22.
//

import RealityKit
import Combine

class PlacementSettings: ObservableObject {
    @Published var placeObject = false
    
    @Published var activeAnchor: AnchorEntity? = nil
    var activeEntity: Entity? = nil
    var otherEntity: Entity? = nil
    
    init() {
        let mesh = MeshResource.generateBox(size: 0.1)
        let material = SimpleMaterial(color: .yellow, roughness: 0.5, isMetallic: true)
        let modelEntity = ModelEntity(mesh: mesh, materials: [material])
        
        otherEntity = modelEntity
    }
    
    
    func changeActiveEntity() {
        guard let activeAnchor = activeAnchor else { return }
        guard let activeEntity = activeEntity else { return }
        guard let otherEntity = otherEntity else { return }
        
        activeAnchor.removeChild(activeEntity)
        activeAnchor.addChild(otherEntity)
        
        (self.otherEntity, self.activeEntity) = (activeEntity, otherEntity)
    }
    
    var sceneObserver: Cancellable?
}
