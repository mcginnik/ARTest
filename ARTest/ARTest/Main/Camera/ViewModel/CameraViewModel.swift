//
//  CameraViewModel.swift
//  ARTest
//
//  Created by Kyle McGinnis on 3/6/23.
//

import Foundation
import SwiftUI
import SceneKit


class CameraViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    var scene: SCNScene?
    
    init(){
        fetchAssets()
    }
    
    private func fetchAssets(){
        self.isLoading = true
        SceneService.shared.fetchScene(withID: "testid") { [weak self] res in
            switch res {
            case .success(let scene):
                self?.scene = scene
            case .failure(let error):
                Logging.LogMe("Failed! ... \(error)")
            }
            self?.isLoading = false
        }
    }
    
    
}
