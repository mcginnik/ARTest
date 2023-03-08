//
//  ARViewContainer.swift
//  ARTest
//
//  Created by Kyle McGinnis on 3/7/23.
//

import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    
    var currentSelection: SceneAssetViewModel?
    
    func makeUIView(context: Context) -> ARView {
                
        let arView = ARView(frame: .zero)

        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic

        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh){
            config.sceneReconstruction   = .mesh
        }

        arView.session.run(config)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        if let model = self.currentSelection {
            print("... adding model to scenen \(model.name)")
            if let modelEntity = model.model {
                let anchorEntity = AnchorEntity(.plane(.any, classification: .any, minimumBounds: .zero))
                anchorEntity.addChild(modelEntity.clone(recursive: true))
                uiView.scene.addAnchor(anchorEntity)
                print("... adding model to scenen anchor added\(model.name)")
            } else {
                print("... modelEntity is nil... \(model.name)")
            }
        }
    }
    
}
