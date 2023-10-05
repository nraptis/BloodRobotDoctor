//
//  ControlInterfaceNodeMenuGaussianView.swift
//  Macintosh
//
//  Created by Sports Dad on 10/3/23.
//

import SwiftUI

struct ControlInterfaceNodeMenuGaussianView: View {
    
    @ObservedObject var controlInterfaceViewModel: ControlInterfaceViewModel
    let node: ProcessingNode
    let data: ProcessingNodeDataGaussian
    
    init(controlInterfaceViewModel: ControlInterfaceViewModel, node: ProcessingNode, data: ProcessingNodeDataGaussian) {
        self.controlInterfaceViewModel = controlInterfaceViewModel
        self.node = node
        self.data = data
    }
    
    var body: some View {
        VStack {
            
            SliderRow(title: "SigmaX", value: data.sigmaX, minValue: 0.0, maxValue: 100.0) { sigmaX in
                controlInterfaceViewModel.nodeGaussianSetSigmaX(node: node,
                                                                sigmaX: sigmaX)
            }
            .id(controlInterfaceViewModel.selectedNodeUUID)
            
            SliderRow(title: "SigmaY", value: data.sigmaY, minValue: 0.0, maxValue: 100.0) { sigmaY in
                controlInterfaceViewModel.nodeGaussianSetSigmaY(node: node,
                                                                sigmaY: sigmaY)
            }
            .id(controlInterfaceViewModel.selectedNodeUUID)
            
            
            StepperRow(title: "SizeX", value: data.sizeX, minValue: 0, maxValue: 64, step: 4) { sizeX in
                controlInterfaceViewModel.nodeGaussianSetSizeX(node: node, sizeX: sizeX)
            }
            .id(controlInterfaceViewModel.selectedNodeUUID)
            
            StepperRow(title: "SizeY", value: data.sizeY, minValue: 0, maxValue: 64, step: 4) { sizeY in
                controlInterfaceViewModel.nodeGaussianSetSizeY(node: node, sizeY: sizeY)
            }
            .id(controlInterfaceViewModel.selectedNodeUUID)

        }
        .background(Color.red)
    }
}

#Preview {
    ControlInterfaceNodeMenuGaussianView(controlInterfaceViewModel: ControlInterfaceViewModel.preview,
                                         node: ProcessingNode.preview,
                                         data: ProcessingNodeDataGaussian())
}
