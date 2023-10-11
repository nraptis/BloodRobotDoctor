//
//  AppContainerView.swift
//  Macintosh
//
//  Created by Sports Dad on 10/2/23.
//

import SwiftUI

struct AppContainerView: View {
    
    let appWidth: CGFloat
    let appHeight: CGFloat
    let toolbarHeight: CGFloat
    
    @ObservedObject var controlInterfaceViewModel: ControlInterfaceViewModel
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ZStack {
                    VStack(spacing: 0.0) {
                        VStack {
                            
                        }
                        .frame(width: geometry.size.width, height: toolbarHeight, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 40.0).foregroundColor(.orange.opacity(0.75)))
                        ZStack {
                            MedicalSceneView(width: geometry.size.width,
                                             height: geometry.size.height - toolbarHeight,
                                             controlInterfaceViewModel: controlInterfaceViewModel)
                        }
                    }
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)
                    
                    MarkUpView(medicalScene: controlInterfaceViewModel.scene,
                               width: geometry.size.width,
                               height: geometry.size.height,
                               controlInterfaceViewModel: controlInterfaceViewModel)
                    
                    ControlInterfaceContainerView(width: geometry.size.width,
                                                  height: geometry.size.height,
                                                  controlInterfaceViewModel: controlInterfaceViewModel)
                    
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            }
        }
        //.edgesIgnoringSafeArea(.all)
        .frame(minWidth: appWidth, minHeight: appHeight)
    }
}

#Preview {
    AppContainerView(appWidth: ApplicationController.shared.appWidth,
                     appHeight: ApplicationController.shared.appHeight,
                     toolbarHeight: ApplicationController.shared.toolbarHeight,
                     controlInterfaceViewModel: ControlInterfaceViewModel.preview)
}
