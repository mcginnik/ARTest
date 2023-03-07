//
//  CameraViewController.swift
//  ARTest
//
//  Created by Kyle McGinnis on 3/6/23.
//

import SwiftUI

class CameraViewController: UIViewController {
    
    var viewModel: CameraViewModel = CameraViewModel()
    
    var navTitle: String {
        StringConstants.ARTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.view.backgroundColor = .white
        view.backgroundColor = .white
        setupNavBar()
        setupHostingVC()
    }
    
    private func setupNavBar(){
        title = navTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupHostingVC(){
        let vc = CameraView(viewModel: viewModel)
        let hostingVC = UIHostingController(rootView: vc)
        add(hostingVC, to: view)
    }
    
    // MARK: Navigation
    
}

