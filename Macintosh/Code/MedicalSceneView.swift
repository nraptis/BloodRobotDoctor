//
//  MedicalSceneView.swift
//  BloodRobotDoctor
//
//  Created by Sports Dad on 9/28/23.
//

import Foundation
import SwiftUI

#if os(macOS)

import AppKit

struct MedicalSceneView: NSViewControllerRepresentable {
    
    let width: CGFloat
    let height: CGFloat
    
    @ObservedObject var controlInterfaceViewModel: ControlInterfaceViewModel
    
    init(width: CGFloat, height: CGFloat, controlInterfaceViewModel: ControlInterfaceViewModel) {
        self.width = width
        self.height = height
        self.controlInterfaceViewModel = controlInterfaceViewModel
    }
    
    func makeNSViewController(context: NSViewControllerRepresentableContext<MedicalSceneView>) -> MetalViewController {
        let width = Float(Int(width + 0.5))
        let height = Float(Int(height + 0.5))
        
        let scene = MedicalScene(controlInterfaceViewModel: controlInterfaceViewModel,
                                 medicalModel: controlInterfaceViewModel.medicalModel)
        let graphics = Graphics(delegate: scene,
                                width: width,
                                height: height)
        
        let metalViewController = graphics.metalViewController
        metalViewController.load()
        
        return metalViewController
    }
    
    func updateNSViewController(_ nsViewController: MetalViewController,
                                context: NSViewControllerRepresentableContext<MedicalSceneView>) {
        let width = Float(Int(width + 0.5))
        let height = Float(Int(height + 0.5))
        
        print("updated to \(width) x \(height)")
        
        nsViewController.graphics.update(width: width,
                                         height: height)
    }
}

#else

struct MedicalSceneView: UIViewControllerRepresentable {
    
    let width: CGFloat
    let height: CGFloat
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MedicalSceneView>) -> MetalViewController {
        
        let width = Float(Int(width + 0.5))
        let height = Float(Int(height + 0.5))
        
        let scene = MedicalScene()
        let graphics = Graphics(delegate: scene,
                                width: width,
                                height: height)
        
        let metalViewController = graphics.metalViewController
        metalViewController.loadViewIfNeeded()
        metalViewController.load()
        
        return metalViewController
    }
    
    func updateUIViewController(_ uiViewController: MetalViewController,
                                context: UIViewControllerRepresentableContext<MedicalSceneView>) {
        let width = Float(Int(width + 0.5))
        let height = Float(Int(height + 0.5))
        uiViewController.graphics.update(width: width,
                                         height: height)
    }
}


#endif

