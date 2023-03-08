//
//  SceneAssetViewModel.swift
//  ARTest
//
//  Created by Kyle McGinnis on 3/7/23.
//

import Foundation
import RealityKit

class SceneAssetViewModel: ObservableObject {
    
    // MARK: Properties
    
    let asset: SceneAsset
    
    @Published var model: ModelEntity?
    
    var isReadyFor3DDisplay: Bool {
        model != nil
    }
    
    var id: String {
        return asset.id
    }
    
    var name: String {
        return asset.name
    }
    
    var imageName: String {
        return asset.imageName
    }
    
    // MARK: Lifecycle
    
    init(withAsset asset: SceneAsset, model: ModelEntity?){
        self.asset = asset
        self.model = model
    }
    
}

// MARK: Hashable & Identifiable Conformance
extension SceneAssetViewModel: Hashable, Identifiable {
    
    static func == (lhs: SceneAssetViewModel, rhs: SceneAssetViewModel) -> Bool {
        lhs.asset == rhs.asset
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
