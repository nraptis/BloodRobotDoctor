//
//  ApplicationController.swift
//  Macintosh
//
//  Created by Sports Dad on 10/2/23.
//

import Foundation

final class ApplicationController {
    
    static let shared = ApplicationController()
    
    lazy var appWidth: CGFloat = {
        1280.0
    }()
    
    lazy var appHeight: CGFloat = {
        936.0
    }()
    
    lazy var toolbarHeight: CGFloat = {
        88.0
    }()
    
    private init() {
        
    }
    
    
}
