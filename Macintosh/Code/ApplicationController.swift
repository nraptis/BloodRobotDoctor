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
        1400.0
    }()
    
    lazy var appHeight: CGFloat = {
        986.0
    }()
    
    lazy var toolbarHeight: CGFloat = {
        150.0
    }()
    
    private init() {
        
    }
    
    
}
