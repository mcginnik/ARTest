//
//  AppConfig.swift
//  ARTest
//
//  Created by Kyle McGinnis on 3/6/23.
//

import Foundation

public class AppConfig {

    // MARK: - Properties

    static let shared: AppConfig = AppConfig()
    
    private (set) var loggingLevel: LoggingLevel = .medium
    
    private (set) var baseURLString = "https://www.nomad-go.com/"
    
    // MARK: - Lifecycle

    private init() {}
    
    // MARK: - API
    
    func setBaseURLString(to url: String){
        self.baseURLString = url
    }

}
