//
//  ControlInterfaceNodeMenuMobileNet.swift
//  Macintosh
//
//  Created by Sports Dad on 10/9/23.
//

import SwiftUI

struct ControlInterfaceNodeMenuMobileNet: View {
    @ObservedObject var controlInterfaceViewModel: ControlInterfaceViewModel
    let node: LearningNode
    let data: LearningNodeDataMobileNet
    
    init(controlInterfaceViewModel: ControlInterfaceViewModel, node: LearningNode, data: LearningNodeDataMobileNet) {
        self.controlInterfaceViewModel = controlInterfaceViewModel
        self.node = node
        self.data = data
    }
    
    var body: some View {
        VStack {
            
            
            StepperRow(title: "Junq", value: data.junq, minValue: 0, maxValue: 64, step: 4) { sizeX in
                
            }
            .id(controlInterfaceViewModel.selectedNodeUUID)

        }
        .background(Color.red)
    }
}

#Preview {
    ControlInterfaceNodeMenuMobileNet(controlInterfaceViewModel: ControlInterfaceViewModel.preview,
                                      node: LearningNode.preview,
                                      data: LearningNodeDataMobileNet())
}
