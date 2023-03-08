//
//  MainView.swift
//  ARTest
//
//  Created by Kyle McGinnis on 3/6/23.
//

import SwiftUI

struct MainView: View {
    
    // MARK: Properties
    
    @ObservedObject var viewModel: MainViewModel
    
    // MARK: Lifecycle
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: Views
    
    var loadingView: some View {
        ProgressView()
            .controlSize(.large)
    }
    
    var body: some View {
        if viewModel.isLoading {
            loadingView
        } else {
            ZStack(alignment: .bottom) {
                ARViewContainer(arViewModel: viewModel.arViewModel)
                VStack {
                    CameraButtonView {
                        viewModel.didTapCameraButton()
                    }
                    AssetPickerView(assets: $viewModel.assets,
                                    currentSelection: $viewModel.currentSelection)
                }

            }
            .ignoresSafeArea()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: .init())
    }
}
