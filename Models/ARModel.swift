//
//  ARModel.swift
//  Red Hen
//
//  Created by Luca Beetz on 01.03.22.
//

import RealityKit
import Combine

class ARModel {
    var name: String
    var modelEntity: ModelEntity?
    
    private var cancellable: AnyCancellable?
    
    init(name: String) {
        self.name = name
    }
    
    func asyncLoadModelEntity() {
        let filename = self.name + ".usdz"
        
        cancellable = ModelEntity.loadModelAsync(named: filename).sink(receiveCompletion: { loadCompletion in
            switch loadCompletion {
            case .failure(let error):
                print("Unable to load modelEntity for \(filename). Error: \(error.localizedDescription)")
            case .finished:
                break
            }
        }, receiveValue: { modelEntity in
            self.modelEntity = modelEntity
            print("modelEntity for \(self.name) has been loaded.")
        })
    }
}
