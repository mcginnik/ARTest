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
    case verticalPlane
    case horizontalPlane
    
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
        case .verticalPlane:
            let config = ARViewConfigType.standard.config
            config.planeDetection = [.vertical]
            return config
        case .horizontalPlane:
            let config = ARViewConfigType.standard.config
            config.planeDetection = [.horizontal]
            return config
        }
    }
}

extension ARView {
    
    static func getConfig(_ configType: ARViewConfigType) -> ARWorldTrackingConfiguration {
        return configType.config
    }

}
