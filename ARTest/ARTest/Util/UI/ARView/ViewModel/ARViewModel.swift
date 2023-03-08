//
//  ARViewModel.swift
//  ARTest
//
//  Created by Kyle McGinnis on 3/8/23.
//

import UIKit
import RealityKit

class ARViewModel: ObservableObject {
    
    // MARK: Properties
    
    private(set) var arView : ARView
    private (set) var modelForPlacement: ModelEntity?
    var allowCloning: Bool
    var allowTransformation: Bool
    
    // MARK: Lifecycle
    
    init(arView: ARView = .init(frame: .zero),
         modelForPlacement: ModelEntity?,
         allowCloning: Bool = true,
         allowTransformation: Bool  = true) {
        self.arView = arView
        self.modelForPlacement =  modelForPlacement
        self.allowCloning = allowCloning
        self.allowTransformation = allowTransformation
    }
    
    // MARK: API
    
    func captureScene(){
        Logging.LogMe("...")
        arView.snapshot(saveToHDR: true) { image in
            if let image = image {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
        }
    }
    
    func setModelForPlacement(_ model: ModelEntity?){
        self.modelForPlacement = model
    }
    
    @objc func placeObjectAtTapPosition(sender: UITapGestureRecognizer) {
        
        guard var modelForPlacement = modelForPlacement else {
            Logging.LogMe("Failed!... modelForPlacement is nil")
            return
        }
        
        let location = sender.location(in: arView)
        
        guard let query = arView.makeRaycastQuery(from: location, allowing: .estimatedPlane, alignment: .any) else {
            Logging.LogMe("Failed!... query with location: \(location)")
            return
        }
        guard let result = arView.session.raycast(query).first else {
            Logging.LogMe("Failed!... no object hit with query: \(query)")
            return
        }
        
        let anchorEntity = AnchorEntity(world: result.worldTransform)
        
        /// Adding anchor
        if allowCloning {
            let clone = modelForPlacement.clone(recursive: true)
            modelForPlacement = clone
            anchorEntity.addChild(clone)
        } else {
            anchorEntity.addChild(modelForPlacement)
        }
        
        /// Allowing Translation Rotation and Scale
        if allowTransformation {
            modelForPlacement.generateCollisionShapes(recursive: true)
            arView.installGestures([.translation, .rotation, .scale], for: modelForPlacement)
        }
        
        Logging.LogMe("Success!... placed object \(modelForPlacement.name) at: \(location)")
        
        arView.scene.anchors.append(anchorEntity)
    }
    
}
