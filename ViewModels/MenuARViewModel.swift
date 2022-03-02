//
//  ARSceneManager.swift
//  Red Hen
//
//  Created by Luca Beetz on 28.02.22.
//

import Combine
import RealityKit

class MenuARViewModel: ObservableObject {
    @Published var placeObject = false
    @Published var anchorEntities: [AnchorEntity] = []
    
    // AR object occlusion and debug settings
    @Published var isPeopleOcclusionEnabled: Bool = false
    @Published var isObjectOcclusionEnabled: Bool = false
    @Published var isLidarDebugEnabled: Bool = false
    
    /// Currently selected entity for deletion
    @Published var entitySelectedForDeletion: ModelEntity? = nil {
        willSet(newValue) {
            if self.entitySelectedForDeletion == nil, let newlySelectedModelEntity = newValue {
                let component = ModelDebugOptionsComponent(visualizationMode: .lightingDiffuse)
                newlySelectedModelEntity.modelDebugOptions = component
            } else if let previouslySelectedModelEntity = self.entitySelectedForDeletion, let newlySelectedModelEntity = newValue {
                previouslySelectedModelEntity.modelDebugOptions = nil
                
                let component = ModelDebugOptionsComponent(visualizationMode: .lightingDiffuse)
                newlySelectedModelEntity.modelDebugOptions = component
            } else if newValue == nil {
                self.entitySelectedForDeletion?.modelDebugOptions = nil
            }
        }
    }
    
    /// Delete entitySelectedForDeletion and remove from AR scene
    func delete() {
        guard let anchor = self.entitySelectedForDeletion?.anchor else { return }
        
        let anchoringIdentifier = anchor.anchorIdentifier
        if let index = anchorEntities.firstIndex(where: {
            $0.anchorIdentifier == anchoringIdentifier
        }) {
            anchorEntities.remove(at: index)
        }
        
        anchor.removeFromParent()
        entitySelectedForDeletion = nil
    }
    
    var sceneObserver: Cancellable?
}
