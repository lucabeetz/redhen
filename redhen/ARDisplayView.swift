//
//  MenuARView.swift
//  Red Hen
//
//  Created by Luca Beetz on 25.02.22.
//

import RealityKit
import ARKit
import FocusEntity
import SwiftUI

struct ARDisplayView: UIViewRepresentable {
    @EnvironmentObject var placementSettings: PlacementSettings
    
    func makeUIView(context: Context) -> CustomARView {
        let arView = CustomARView(frame: .zero)
        
        placementSettings.sceneObserver = arView.scene.subscribe(to: SceneEvents.Update.self, { (event) in
            self.updateScene(for: arView)
        })
        
        return arView
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {}
    
    private func updateScene(for arView: CustomARView) {
        arView.focusEntity?.isEnabled = true
        
        let mesh = MeshResource.generateBox(size: 0.1)
        let material = SimpleMaterial(color: .orange, roughness: 0.5, isMetallic: true)
        let modelEntity = ModelEntity(mesh: mesh, materials: [material])
        
        if placementSettings.placeObject {
            self.place(modelEntity, in: arView)
        }
    }
    
    private func place(_ modelEntity: ModelEntity, in arView: ARView) {
        let clonedEntity = modelEntity.clone(recursive: true)
        clonedEntity.generateCollisionShapes(recursive: true)
        arView.installGestures([.translation, .rotation], for: clonedEntity)
        
        let anchorEntity = AnchorEntity(plane: .any)
        anchorEntity.addChild(clonedEntity)
        if placementSettings.activeAnchor == nil {
            placementSettings.activeAnchor = anchorEntity
            placementSettings.activeEntity = clonedEntity
        }
        
        arView.scene.addAnchor(anchorEntity)
        
        placementSettings.placeObject = false
    }
}

class CustomARView: ARView {
    var focusEntity: FocusEntity?
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        
        focusEntity = FocusEntity(on: self, focus: .classic)
        
        configure()
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        session.run(config)
    }
}
