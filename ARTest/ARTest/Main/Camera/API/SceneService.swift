//
//  SceneService.swift
//  ARTest
//
//  Created by Kyle McGinnis on 3/6/23.
//

import Foundation
import SceneKit

typealias SceneID = String

protocol SceneServiceProtocol {
    func fetchScene(withID id: SceneID, completion: @escaping (Result<SCNScene, Error>) -> Void)
}

enum SceneServiceError: LocalizedError {
    case invalidID
    
    var errorDescription: String? {
        switch self {
        case .invalidID:
            return "SceneID is invalid... can't fetch model"
        }
    }
}

class SceneService {
    
    // MARK: Properties
    
    static let shared = SceneService()

    /// Allowing for Dependency injection here, calling the injected service instead of directly  so you can easily swap out if need be
    /// Would instead have this be an automatic static injection setup so that all services are set at complie time, but this is a simple way of doing it for now
    ///
    var injected: SceneServiceProtocol?
    
    // MARK: Lifecycle
    
    private init(){}
    
    static func setup(with service: SceneServiceProtocol){
        self.shared.injected = service
    }
    
    // MARK: API
    
    func fetchScene(withID id: SceneID, completion: @escaping (Result<SCNScene, Error>) -> Void) {
        Logging.LogMe("...")
        injected?.fetchScene(withID: id) { res in
            DispatchQueue.main.async {
                switch res {
                case .success:
                    Logging.LogMe("Success!...")
                case .failure(let error):
                    Logging.LogMe("Failed! ... \(error)")
                }
                completion(res)
            }
        }
    }
    
}
