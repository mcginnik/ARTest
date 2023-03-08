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
        .init(id: "0001",
              name: "Toy Car",
              imageName: ImageConstants.toyCar,
              modelName: "\(SceneAssetConstants.folderDir)\(SceneAssetConstants.toyCar)"),
        .init(id: "0002",
              name: "Caramel Sauce",
              imageName: ImageConstants.caramelSauce,
              modelName: "\(SceneAssetConstants.folderDir)\(SceneAssetConstants.caramelSauce)"),
        .init(id: "0003",
              name: "Toy Drummer",
              imageName: ImageConstants.toyDrummer,
              modelName: "\(SceneAssetConstants.folderDir)\(SceneAssetConstants.toyDrummer)"),
    ]
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: API
    
    func fetchModelEntity(withID id: AssetID, completion: @escaping (Result<ModelEntity, Error>) -> Void) {
        Logging.LogMe("... \(id), ")
        /// Fake delay to simulate networking
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
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
        /// Fake delay to simulate networking
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            completion(.success(self.testAssets))
        }
    }
    
}
