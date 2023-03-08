//
//  SceneAssetViewModel.swift
//  ARTest
//
//  Created by Kyle McGinnis on 3/7/23.
//

import Foundation
import RealityKit

class SceneAssetViewModel: ObservableObject {
    
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
    
    init(withAsset asset: SceneAsset, model: ModelEntity?){
        self.asset = asset
        self.model = model
    }
    
}

extension SceneAssetViewModel: Hashable, Identifiable {
    
    static func == (lhs: SceneAssetViewModel, rhs: SceneAssetViewModel) -> Bool {
        lhs.asset == rhs.asset
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
}
