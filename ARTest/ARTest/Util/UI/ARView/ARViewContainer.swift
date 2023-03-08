////
////  ARViewContainer.swift
////  ARTest
////
////  Created by Kyle McGinnis on 3/7/23.
////
///
///
///
///

import SwiftUI
import RealityKit
import ARKit


struct ARViewContainer: UIViewRepresentable {
    
    
    var arViewModel: ARViewModel
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = arViewModel.arView
        let tapGesture = UITapGestureRecognizer(target: arViewModel, action: #selector(arViewModel.objPlacementFunc(sender:)))
        arView.addGestureRecognizer(tapGesture)
        
        let config = ARView.getConfig(.standard)
        arView.session.run(config)
        arView.session.delegate = context.coordinator
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        
//        func session(_ session: ARSession, didUpdate frame: ARFrame) {
////            Logging.LogMe("...")
//        }
    }

}
