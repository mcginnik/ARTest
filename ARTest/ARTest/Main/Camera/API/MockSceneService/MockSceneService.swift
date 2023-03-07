//
//  MockSceneService.swift
//  ARTest
//
//  Created by Kyle McGinnis on 3/6/23.
//

import SceneKit

class MockSceneService: SceneServiceProtocol {
    
    func fetchScene(withID id: SceneID, completion: @escaping (Result<SCNScene, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let scene = SCNScene(named: ARConstants.testScene) {
                completion(.success(scene))
            } else {
                completion(.failure(SceneServiceError.invalidID))
            }
        }
    }
    
}
