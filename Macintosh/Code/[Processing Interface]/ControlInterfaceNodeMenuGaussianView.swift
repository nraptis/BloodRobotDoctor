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
            
            SliderRow(title: "Sigma", value: data.sigma, minValue: 0.0, maxValue: 100.0) { sigma in
                controlInterfaceViewModel.nodeGaussianSetSigma(node: node,
                                                               sigma: sigma)
            }
            .id(controlInterfaceViewModel.selectedNodeUUID)
            
            
            StepperRow(title: "Size", value: data.size, minValue: -5, maxValue: 10, step: 2) { size in
                controlInterfaceViewModel.nodeGaussianSetSize(node: node, size: size)
            }
            .id(controlInterfaceViewModel.selectedNodeUUID)
            
            Button {
                controlInterfaceViewModel.nodeGaussianChangeStep(node: node, delta: 1)
            } label: {
                Text("incrase size")
                    .padding()
            }
            
            Button {
                controlInterfaceViewModel.nodeGaussianChangeStep(node: node, delta: -1)
            } label: {
                Text("decreaz size")
                    .padding()
            }
        }
        .background(Color.red)
    }
}

#Preview {
    ControlInterfaceNodeMenuGaussianView(controlInterfaceViewModel: ControlInterfaceViewModel.preview,
                                         node: ProcessingNode.preview,
                                         data: ProcessingNodeDataGaussian())
}
