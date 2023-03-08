//
//  SceneAssetService.swift
//  ARTest
//
//  Created by Kyle McGinnis on 3/6/23.
//

import Foundation
import RealityKit

typealias AssetID = String

protocol SceneAssetServiceProtocol {
    func fetchModelEntity(withID id: AssetID, completion: @escaping (Result<ModelEntity, Error>) -> Void)
    func fetchAssets(completion: @escaping (Result<[SceneAsset], Error>) -> Void)
}

enum SceneAssetServiceError: LocalizedError {
    case invalidID
    
    var errorDescription: String? {
        switch self {
        case .invalidID:
            return "SceneID is invalid... can't fetch model"
        }
    }
}

class SceneAssetService {
    
    // MARK: Properties
    
    static let shared = SceneAssetService()

    /// Allowing for Dependency injection here, calling the injected service instead of directly  so you can easily swap out if need be
    /// Would instead have this be an automatic static injection setup so that all services are set at complie time, but this is a simple way of doing it for now
    ///
    var injected: SceneAssetServiceProtocol?
    
    // MARK: Lifecycle
    
    private init(){}
    
    static func setup(with service: SceneAssetServiceProtocol){
        self.shared.injected = service
    }
    
    // MARK: API
    
    func fetchModelEntity(withID id: AssetID, completion: @escaping (Result<ModelEntity, Error>) -> Void) {
        Logging.LogMe("...")
        injected?.fetchModelEntity(withID: id) { res in
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
    
    func fetchAssets(completion: @escaping (Result<[SceneAsset], Error>) -> Void) {
        Logging.LogMe("...")
        injected?.fetchAssets() { res in
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
