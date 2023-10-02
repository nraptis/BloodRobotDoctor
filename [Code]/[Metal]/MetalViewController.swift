//
//  MetalViewController.swift
//  BloodRobotDoctor
//
//  Created by Sports Dad on 2/10/23.
//

#if os(macOS)
import Cocoa

class MetalViewController: NSViewController {
    
    let graphics: Graphics
    let metalView: MetalView
    required init(graphics: Graphics,
                  metalView: MetalView) {
        self.graphics = graphics
        self.metalView = metalView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = metalView
    }
    
    func load() {
        metalView.load()
    }
}

#else
import UIKit

class MetalViewController: UIViewController {
    
    let graphics: Graphics
    let metalView: MetalView
    required init(graphics: Graphics,
                  metalView: MetalView) {
        self.graphics = graphics
        self.metalView = metalView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = metalView
    }
    
    func load() {
        metalView.load()
    }
}

#endif
