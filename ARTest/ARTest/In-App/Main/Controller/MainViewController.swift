//
//  MainViewController.swift
//  ARTest
//
//  Created by Kyle McGinnis on 3/6/23.
//

import SwiftUI

class MainViewController: UIViewController {
    
    // MARK: Properties

    var viewModel: MainViewModel = MainViewModel()
    
    var navTitle: String {
        StringConstants.MainTitle
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.view.backgroundColor = .white
        view.backgroundColor = .white
        setupNavBar()
        setupHostingVC()
    }
    
    // MARK: View Helpers
    
    private func setupNavBar(){
        title = navTitle
//        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupHostingVC(){
        let vc = MainView(viewModel: viewModel)
        let hostingVC = UIHostingController(rootView: vc)
        add(hostingVC, to: view)
    }
        
}

