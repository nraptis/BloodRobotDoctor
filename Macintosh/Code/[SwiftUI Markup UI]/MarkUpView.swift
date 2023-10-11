//
//  MarkUpView.swift
//  Macintosh
//
//  Created by Screwy Uncle Louie on 10/9/23.
//

import SwiftUI

struct MarkUpView: View {
    let medicalScene: MedicalScene
    let width: CGFloat
    let height: CGFloat
    @ObservedObject var controlInterfaceViewModel: ControlInterfaceViewModel
    
    init(medicalScene: MedicalScene, width: CGFloat, height: CGFloat, controlInterfaceViewModel: ControlInterfaceViewModel) {
        self.medicalScene = medicalScene
        self.width = width
        self.height = height
        self.controlInterfaceViewModel = controlInterfaceViewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(medicalScene.slices) { slice in
                MarkUpTileView(slice: slice)
                    .offset(x: CGFloat(slice.x),
                            y: CGFloat(slice.y) + ApplicationController.shared.toolbarHeight)
                
            }
        }
    }
}

#Preview {
    MarkUpView(medicalScene: MedicalScene.preview,
               width: 640.0,
               height: 640.0,
               controlInterfaceViewModel: ControlInterfaceViewModel.preview)
}
