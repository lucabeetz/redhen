//
//  RealityKitView.swift
//  Red Hen
//
//  Created by Luca Beetz on 25.02.22.
//

import SwiftUI
import RealityKit

struct RealityKitView: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
        
        let mesh = MeshResource.generateBox(size: 0.1)
        let material = SimpleMaterial(color: .orange, roughness: 0.5, isMetallic: true)
        let modelEntity = ModelEntity(mesh: mesh, materials: [material])
        let anchorEntity = AnchorEntity(plane: .horizontal)
        anchorEntity.addChild(modelEntity)
        arView.scene.addAnchor(anchorEntity)
        
        modelEntity.generateCollisionShapes(recursive: true)
        
        arView.installGestures([.translation, .rotation, .scale], for: modelEntity)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
}

struct RealityKitView_Previews: PreviewProvider {
    static var previews: some View {
        RealityKitView()
    }
}
