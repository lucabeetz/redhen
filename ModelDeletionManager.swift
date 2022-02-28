//
//  ModelDeletionManager.swift
//  Red Hen
//
//  Created by Luca Beetz on 28.02.22.
//

import SwiftUI
import RealityKit

class ModelDeletionManager: ObservableObject {
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
    
    func delete(placementSettings: PlacementSettings) {
        guard let anchor = self.entitySelectedForDeletion?.anchor else { return }
        
        let anchoringIdentifier = anchor.anchorIdentifier
        if let index = placementSettings.anchorEntities.firstIndex(where: { $0.anchorIdentifier == anchoringIdentifier}) {
            placementSettings.anchorEntities.remove(at: index)
        }
        
        anchor.removeFromParent()
        entitySelectedForDeletion = nil
        placementSettings.reset()
    }
}
