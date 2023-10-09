//
//  ControlInterfaceProcessingContentContainerView.swift
//  Macintosh
//
//  Created by Sports Dad on 10/9/23.
//

import SwiftUI

struct ControlInterfaceProcessingContentContainerView: View {
    let node: ProcessingNode
    
    let width: CGFloat
    let height: CGFloat
    let id: Int
    
    @ObservedObject var controlInterfaceViewModel: ControlInterfaceViewModel
    
    init(node: ProcessingNode, width: CGFloat, height: CGFloat, controlInterfaceViewModel: ControlInterfaceViewModel, id: Int) {
        self.node = node
        self.width = width
        self.height = height
        self.controlInterfaceViewModel = controlInterfaceViewModel
        self.id = id
        //
        //selectedType = type
        
        print("initializn with \(node.type)")
        
    }
    
    var body: some View {
        VStack {
            
            Text("arch id: \(id)")
            Text("t1 = \(node.type.name)")
            
            
            ForEach(ProcessingNodeType.allCases) { type in
                if node.type == type {
                    Button {
                        controlInterfaceViewModel.updateNodeType(processingNode: node,
                                                                 type: type)
                    } label: {
                        Text(type.name)
                            .foregroundColor(.red)
                    }

                } else {
                    Button {
                        controlInterfaceViewModel.updateNodeType(processingNode: node,
                                                                 type: type)
                    } label: {
                        Text(type.name)
                            .foregroundColor(.blue)
                    }
                }
            }
            
            
            switch node.type {
            case .none:
                EmptyView()
            case .gauss:
                if let data = node.data as? ProcessingNodeDataGaussian {
                    ControlInterfaceNodeMenuGaussianView(controlInterfaceViewModel: controlInterfaceViewModel,
                                                         node: node,
                                                         data: data)
                }
            case .gray:
                ControlInterfaceNodeMenuGrayView()
            case .erosion:
                if let data = node.data as? ProcessingNodeDataErode {
                    ControlInterfaceNodeMenuErosionView(controlInterfaceViewModel: controlInterfaceViewModel,
                                                        node: node,
                                                        data: data)
                }
            case .dilation:
                if let data = node.data as? ProcessingNodeDataDilate {
                    ControlInterfaceNodeMenuDilationView(controlInterfaceViewModel: controlInterfaceViewModel,
                                                         node: node,
                                                         data: data)
                }
            }

            /*
            Picker("Please choose a color", selection: $selectedType) {
                ForEach(ProcessingNodeType.allCases, id: \.self) {
                    Text($0.name)
                }
            }
            Text("You selected: \(selectedType.name)")
            */
            
        }
        .frame(width: width, height: height)
        .background(RoundedRectangle(cornerRadius: 60.0).foregroundColor(.blue.opacity(0.5)))
        
    }
}

#Preview {
    ControlInterfaceProcessingContentContainerView(node: ProcessingNode.preview,
                                                   width: ApplicationController.shared.appWidth,
                                                   height: ApplicationController.shared.toolbarHeight,
                                                   controlInterfaceViewModel: ControlInterfaceViewModel.preview,
                                                   id: 0)
}
