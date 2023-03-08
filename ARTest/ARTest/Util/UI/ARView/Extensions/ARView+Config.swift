//
//  ARView+Config.swift
//  ARTest
//
//  Created by Kyle McGinnis on 3/8/23.
//

import ARKit
import RealityKit

enum ARViewConfigType {
    case standard
    
    var config: ARWorldTrackingConfiguration {
        switch self {
        case .standard:
            let config = ARWorldTrackingConfiguration()
            config.planeDetection = [.horizontal, .vertical]
            config.environmentTexturing = .automatic
            if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh){
                config.sceneReconstruction   = .mesh
            }
            return config
        }
    }
}

extension ARView {
    
    static func getConfig(_ configType: ARViewConfigType) -> ARWorldTrackingConfiguration {
        return configType.config
    }

}
