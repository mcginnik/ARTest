//
//  AssetPickerView.swift
//  ARTest
//
//  Created by Kyle McGinnis on 3/7/23.
//

import SwiftUI

struct AssetPickerView: View {

    @Binding var assets: [SceneAssetViewModel]
    @Binding var currentSelection: SceneAssetViewModel?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(assets, id: \.id) { asset in
                    Button {
                        print("selected: \(asset.name)")
                        self.currentSelection = asset
                    } label: {
                        Image(asset.imageName)
                            .resizable()
                            .scaledToFill()
                    }
                    .background(Color.white)
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
                    .opacity(asset.id == currentSelection?.id && asset.isReadyFor3DDisplay ? 1 : 0.35)
                    .onAppear {
                        if currentSelection == nil {
                            currentSelection = assets.first
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.black.opacity(0.35))
    }
        
}

struct AssetPickerView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = SceneAssetViewModel(withAsset: .init(id: "0001",
                                                      name: "Toy Car",
                                                      imageName: "toy_car",
                                                      modelName: "toy_car.usdz"),
                                     model: nil)
        
        return AssetPickerView( assets: .constant([vm]), currentSelection: .constant(nil))
    }
}
