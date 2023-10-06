//
//  ControlInterfaceNodeMenuErosionView.swift
//  Macintosh
//
//  Created by Sports Dad on 10/3/23.
//

import SwiftUI

struct ControlInterfaceNodeMenuErosionView: View {
    @ObservedObject var controlInterfaceViewModel: ControlInterfaceViewModel
    let node: ProcessingNode
    let data: ProcessingNodeDataErode
    
    init(controlInterfaceViewModel: ControlInterfaceViewModel,node: ProcessingNode, data: ProcessingNodeDataErode) {
        self.controlInterfaceViewModel = controlInterfaceViewModel
        self.node = node
        self.data = data
    }
    
    var body: some View {
        VStack {
            
            SegmentRow(title: "segz", choices: 
                        [ErosionElement.rect, ErosionElement.cross, ErosionElement.ellipse],
                       selected: data.element) { element in
                
                print("element changed... \(element)")
                controlInterfaceViewModel.nodeErodeSetElement(node: node,
                                                              element: element)
                
            }.id(controlInterfaceViewModel.selectedNodeUUID)
            
            StepperRow(title: "Size", value: data.size, minValue: 0, maxValue: 64, step: 2) { size in
                controlInterfaceViewModel.nodeErodeSetSize(node: node, size: size)
            }
            .id(controlInterfaceViewModel.selectedNodeUUID)
            
        }
        .background(Color.red)
    }
}

#Preview {
    ControlInterfaceNodeMenuErosionView(controlInterfaceViewModel: ControlInterfaceViewModel.preview,
                                        node: ProcessingNode.preview,
                                        data: ProcessingNodeDataErode())
}
