//
//  ControlInterfaceContainerView.swift
//  Macintosh
//
//  Created by Sports Dad on 10/2/23.
//

import SwiftUI

struct ControlInterfaceContainerView: View {
    
    let width: CGFloat
    let height: CGFloat
    @ObservedObject var controlInterfaceViewModel: ControlInterfaceViewModel
    
    init(width: CGFloat, height: CGFloat, controlInterfaceViewModel: ControlInterfaceViewModel) {
        self.width = width
        self.height = height
        self.controlInterfaceViewModel = controlInterfaceViewModel
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            ControlInterfaceToolbarView(width: width,
                                        height: ApplicationController.shared.toolbarHeight,
                                        controlInterfaceViewModel: controlInterfaceViewModel)
            if controlInterfaceViewModel.expanded {
                ControlInterfaceContentContainerView(width: width,
                                                     height: height - ApplicationController.shared.toolbarHeight,
                                                     controlInterfaceViewModel: controlInterfaceViewModel)
            } else {
                ZStack {
                    
                }
                .frame(width: width, height: height - ApplicationController.shared.toolbarHeight)
            }
        }
        .frame(width: width, height: height)
    }
}

#Preview {
    ControlInterfaceContainerView(width: 640.0,
                                  height: 640.0,
                                  controlInterfaceViewModel: ControlInterfaceViewModel.preview)
}
