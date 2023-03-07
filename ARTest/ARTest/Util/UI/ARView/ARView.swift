//
//  ARView.swift
//  ARTest
//
//  Created by Kyle McGinnis on 3/6/23.
//

import SwiftUI
import ARKit

struct ARView: UIViewRepresentable {
    
    let scene: SCNScene
    
    init(withScene scene: SCNScene){
        self.scene = scene
    }
    
    func makeUIView(context: Context) -> some UIView {
        let sceneView = ARSCNView()
        sceneView.showsStatistics = true
        
        sceneView.scene = self.scene
        
        let config = ARWorldTrackingConfiguration()
        sceneView.session.run(config)
        
        return sceneView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
}
