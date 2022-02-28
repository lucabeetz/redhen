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
import Combine

struct ARDisplayView: UIViewRepresentable {
    @EnvironmentObject var arSceneManager: ARSceneManager
    
    func makeUIView(context: Context) -> CustomARView {
        let arView = CustomARView(frame: .zero, arSceneManager: arSceneManager)
        
        arSceneManager.sceneObserver = arView.scene.subscribe(to: SceneEvents.Update.self, { (event) in
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
        
        if arSceneManager.placeObject {
            self.place(modelEntity, in: arView)
        }
    }
    
    private func place(_ modelEntity: ModelEntity, in arView: ARView) {
        let clonedEntity = modelEntity.clone(recursive: true)
        clonedEntity.generateCollisionShapes(recursive: true)
        arView.installGestures([.translation, .rotation], for: clonedEntity)
        
        let anchorEntity = AnchorEntity(plane: .any)
        anchorEntity.addChild(clonedEntity)
        
        arView.scene.addAnchor(anchorEntity)
        arSceneManager.anchorEntities.append(anchorEntity)
        
        arSceneManager.placeObject = false
    }
}

class CustomARView: ARView {
    var focusEntity: FocusEntity?
    var arSceneManager: ARSceneManager
    
    private var peopleOcclusionCancellable: AnyCancellable?
    private var objectOcclusionCancellable: AnyCancellable?
    private var lidarDebugCancellable: AnyCancellable?
    
    required init(frame frameRect: CGRect, arSceneManager: ARSceneManager) {
        self.arSceneManager = arSceneManager
        
        super.init(frame: frameRect)
        
        focusEntity = FocusEntity(on: self, focus: .classic)
        
        configure()
        
        self.initializeSettings()
        self.setupSubscribers()
        self.enableObjectDeletion()
    }
    
    required init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        
        session.run(config)
    }
    
    private func initializeSettings() {
        self.updatePeopleOcclusion(isEnabled: arSceneManager.isPeopleOcclusionEnabled)
        self.updateObjectOcclusion(isEnabled: arSceneManager.isObjectOcclusionEnabled)
        self.updateLidarDebug(isEnabled: arSceneManager.isLidarDebugEnabled)
    }
    
    private func setupSubscribers() {
        self.peopleOcclusionCancellable = arSceneManager.$isPeopleOcclusionEnabled.sink { [weak self] isEnabled in
            self?.updatePeopleOcclusion(isEnabled: isEnabled)
        }
        
        self.objectOcclusionCancellable = arSceneManager.$isObjectOcclusionEnabled.sink { [weak self] isEnabled in
            self?.updateObjectOcclusion(isEnabled: isEnabled)
        }
        
        self.lidarDebugCancellable = arSceneManager.$isLidarDebugEnabled.sink { [weak self] isEnabled in
            self?.updateLidarDebug(isEnabled: isEnabled)
        }
    }
    
    private func updatePeopleOcclusion(isEnabled: Bool) {
        guard ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) else { return }
        
        guard let configuration = self.session.configuration as? ARWorldTrackingConfiguration else { return }
        
        if configuration.frameSemantics.contains(.personSegmentationWithDepth) {
            configuration.frameSemantics.remove(.personSegmentationWithDepth)
        } else {
            configuration.frameSemantics.insert(.personSegmentationWithDepth)
        }
        
        self.session.run(configuration)
    }
    
    private func updateObjectOcclusion(isEnabled: Bool) {
        if self.environment.sceneUnderstanding.options.contains(.occlusion) {
            self.environment.sceneUnderstanding.options.remove(.occlusion)
        } else {
            self.environment.sceneUnderstanding.options.insert(.occlusion)
        }
    }
    
    private func updateLidarDebug(isEnabled: Bool) {
        if self.debugOptions.contains(.showSceneUnderstanding) {
            self.debugOptions.remove(.showSceneUnderstanding)
        } else {
            self.debugOptions.insert(.showSceneUnderstanding)
        }
    }
}

extension CustomARView {
    func enableObjectDeletion() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
        self.addGestureRecognizer(longPressGesture)
    }
    
    @objc
    func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        let location = recognizer.location(in: self)
        
        if let entity = self.entity(at: location) as? ModelEntity {
            arSceneManager.entitySelectedForDeletion = entity
        }
    }
    
}
