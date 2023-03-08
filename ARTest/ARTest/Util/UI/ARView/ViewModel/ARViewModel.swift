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
    var clone: Bool
    private (set) var modelForPlacement: ModelEntity?
    
    // MARK: Lifecycle
    
    init(arView: ARView = .init(frame: .zero),
         modelForPlacement: ModelEntity?,
         clone: Bool = true) {
        self.arView = arView
        self.modelForPlacement =  modelForPlacement
        self.clone = clone
    }
    
    // MARK: API
    
    func setModelForPlacement(_ model: ModelEntity?){
        self.modelForPlacement = model
    }
    
    @objc func objPlacementFunc(sender: UITapGestureRecognizer) {
        guard let modelForPlacement = modelForPlacement else { return }
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
        if clone {
            anchorEntity.addChild(modelForPlacement.clone(recursive: true))
        } else {
            anchorEntity.addChild(modelForPlacement)
        }
        
        arView.scene.anchors.append(anchorEntity)
    }
    
}
