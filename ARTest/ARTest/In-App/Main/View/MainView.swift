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
    @State var showCapturedImage: Bool = false
    
    // MARK: Lifecycle
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: Views
    
    var loadingView: some View {
        ProgressView()
            .controlSize(.large)
    }
    
    var closeButton: some View {
        CloseButtonView(shouldDisplay: $showCapturedImage)
    }
    
    var bottomHUD: some View {
        VStack {
            CameraButtonView {
                viewModel.didTapCameraButton()
            }
            AssetPickerView(assets: $viewModel.assets,
                            currentSelection: $viewModel.currentSelection)
        }
        .onChange(of: viewModel.capturedImage) { newValue in
            showCapturedImage.toggle()
        }
    }
    
    var capturedImageModal: some View {
        ZStack {
            if let image = viewModel.capturedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            }
            closeButton
        }
    }
    
    var body: some View {
        if viewModel.isLoading {
            loadingView
        } else {
            ZStack(alignment: .bottom) {
                ARViewContainer(arViewModel: viewModel.arViewModel)
                bottomHUD
            }
            .fullScreenCover(isPresented: $showCapturedImage, content: {
                capturedImageModal
            })
            .ignoresSafeArea()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: .init())
    }
}
