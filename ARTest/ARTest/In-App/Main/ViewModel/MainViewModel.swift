//
//  MainViewModel.swift
//  ARTest
//
//  Created by Kyle McGinnis on 3/6/23.
//

import Foundation
import SwiftUI
import SceneKit


class MainViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    
    @Published var assets: [SceneAssetViewModel] = []
    @Published var assetSet: Set<SceneAssetViewModel> = [] {
        didSet {
            assets = Array(assetSet)
        }
    }

    @Published var currentSelection: SceneAssetViewModel?
    
    init(){
        fetchAssets()
    }
    
    private func fetchAssets(){
        self.isLoading = true
        SceneAssetService.shared.fetchAssets { [weak self] res in
            switch res {
            case .success(let assets):
                for asset in assets {
                    self?.fetchModelEntity(forAsset: asset)
                }
            case .failure(let error):
                Logging.LogMe("Failed! ... \(error)")
            }
            self?.isLoading = false
        }
    }
    
    private func fetchModelEntity(forAsset asset: SceneAsset){
        SceneAssetService.shared.fetchModelEntity(withID: asset.id) { [weak self] res in
            switch res {
            case .success(let model):
                self?.assetSet.insert(SceneAssetViewModel(withAsset: asset, model: model))
            case .failure(let error):
                Logging.LogMe("Failed!... \(error)")
            }
        }
    }
    
    
}

//extension MainViewModel: ARViewDelegate {
//    
//}
