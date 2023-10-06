//
//  ControlInterfaceNodeMenuDilationView.swift
//  Macintosh
//
//  Created by Sports Dad on 10/3/23.
//

import SwiftUI

struct ControlInterfaceNodeMenuDilationView: View {
    @ObservedObject var controlInterfaceViewModel: ControlInterfaceViewModel
    let node: ProcessingNode
    let data: ProcessingNodeDataDilate
    
    init(controlInterfaceViewModel: ControlInterfaceViewModel,node: ProcessingNode, data: ProcessingNodeDataDilate) {
        self.controlInterfaceViewModel = controlInterfaceViewModel
        self.node = node
        self.data = data
    }
    
    var body: some View {
        VStack {
            
            SegmentRow(title: "dseg", choices:
                        [DilationElement.rect, DilationElement.cross, DilationElement.ellipse],
                       selected: data.element) { element in
                
                print("element changed... \(element)")
                controlInterfaceViewModel.nodeDilateSetElement(node: node,
                                                              element: element)
                
            }.id(controlInterfaceViewModel.selectedNodeUUID)
            
            StepperRow(title: "Size", value: data.size, minValue: 0, maxValue: 64, step: 2) { size in
                controlInterfaceViewModel.nodeDilateSetSize(node: node, size: size)
            }
            .id(controlInterfaceViewModel.selectedNodeUUID)
            
        }
        .background(Color.red)
    }
}

#Preview {
    ControlInterfaceNodeMenuDilationView(controlInterfaceViewModel: ControlInterfaceViewModel.preview,
                                         node: ProcessingNode.preview,
                                         data: ProcessingNodeDataDilate())
}
