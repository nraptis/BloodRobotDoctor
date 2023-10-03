//
//  ControlInterfaceContentContainerView.swift
//  Macintosh
//
//  Created by Screwy Uncle Louie on 10/2/23.
//

import SwiftUI

struct ControlInterfaceContentContainerView: View {
    let width: CGFloat
    let height: CGFloat
    @ObservedObject var controlInterfaceViewModel: ControlInterfaceViewModel
    
    init(width: CGFloat, height: CGFloat, controlInterfaceViewModel: ControlInterfaceViewModel) {
        self.width = width
        self.height = height
        self.controlInterfaceViewModel = controlInterfaceViewModel
    }
    
    var body: some View {
        VStack {
            
        }
        .frame(width: width, height: height)
        .background(RoundedRectangle(cornerRadius: 60.0).foregroundColor(.blue.opacity(0.5)))
    }
}

#Preview {
    ControlInterfaceContentContainerView(width: ApplicationController.shared.appWidth,
                                         height: ApplicationController.shared.toolbarHeight,
                                         controlInterfaceViewModel: ControlInterfaceViewModel.preview)
}
