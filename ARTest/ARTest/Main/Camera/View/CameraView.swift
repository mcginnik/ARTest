//
//  CameraView.swift
//  ARTest
//
//  Created by Kyle McGinnis on 3/6/23.
//

import SwiftUI

struct CameraView: View {
    
    @ObservedObject var viewModel: CameraViewModel
    
    init(viewModel: CameraViewModel) {
        self.viewModel = viewModel
    }
    
    var loadingView: some View {
        ProgressView()
            .controlSize(.large)
    }
    
    
    var body: some View {
        if viewModel.isLoading {
            loadingView
        } else {
            if let scene = viewModel.scene {
                ARView(withScene: scene)
            }
        }
    }
    
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(viewModel: .init())
    }
}
