//
//  MainView.swift
//  ARTest
//
//  Created by Kyle McGinnis on 3/6/23.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
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
            ZStack(alignment: .bottom) {
                ARViewContainer(currentSelection: viewModel.currentSelection)
                AssetPickerView(assets: $viewModel.assets,
                                currentSelection: $viewModel.currentSelection)
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
