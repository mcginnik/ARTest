//
//  MockSceneService.swift
//  ARTest
//
//  Created by Kyle McGinnis on 3/6/23.
//

import Foundation
import RealityKit
import Combine

class MockSceneAssetService: SceneAssetServiceProtocol {
    
    // MARK: Properties
    
    let testAssets: [SceneAsset] = [
        .init(id: "0001", name: "Toy Car", imageName: "toy_car", modelName: "SceneAssets.scnassets/toy_car.usdz"),
        .init(id: "0002", name: "Caramel Sauce", imageName: "caramel_sauce", modelName: "SceneAssets.scnassets/caramel_sauce.usdz"),
        .init(id: "0003", name: "Toy Drummer", imageName: "toy_drummer", modelName: "SceneAssets.scnassets/toy_drummer.usdz"),
    ]
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: API
    
    func fetchModelEntity(withID id: AssetID, completion: @escaping (Result<ModelEntity, Error>) -> Void) {
        Logging.LogMe("... \(id), ")
        /// Fake delay to simulate networking
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let asset = self.testAssets.first(where: {$0.id == id}) {
                ModelEntity.loadModelAsync(named: asset.modelName)
                    .sink { res in
                        switch res {
                        case .finished:
                            break
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    } receiveValue: { val in
                        completion(.success(val))
                    }
                    .store(in: &self.cancellables)
            } else {
                completion(.failure(SceneAssetServiceError.invalidID))
            }
        }
    }
    
    func fetchAssets(completion: @escaping (Result<[SceneAsset], Error>) -> Void) {
        completion(.success(testAssets))
    }
    
    
}
