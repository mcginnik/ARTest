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
    
    
    // MARK: Properties
    
    @Published var isLoading: Bool = false
    @Published var assets: [SceneAssetViewModel] = []
    @Published private var assetSet: Set<SceneAssetViewModel> = [] {
        didSet {
            withAnimation {
                self.assets = Array(assetSet)
            }
        }
    }
    @Published var capturedImage: UIImage?

    @Published var currentSelection: SceneAssetViewModel? {
        didSet {
            arViewModel.setModelForPlacement(currentSelection?.model)
        }
    }
    
    @Published var arViewModel: ARViewModel = ARViewModel(modelForPlacement: nil)
    
    // MARK: Lifecycle

    init(){
        fetchAssets()
        
        arViewModel.didCaptureScene = { [weak self] image in
            self?.capturedImage = image
        }
    }
    
    // MARK: API
    
    func didTapCameraButton() {
        Logging.LogMe("...")
        arViewModel.captureScene()
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
