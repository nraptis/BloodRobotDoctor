//
//  ControlInterfaceLearningContentContainerView.swift
//  Macintosh
//
//  Created by Screwy Uncle Louie on 10/9/23.
//

import SwiftUI

struct ControlInterfaceLearningContentContainerView: View {
    let node: LearningNode
    
    let width: CGFloat
    let height: CGFloat
    let id: Int
    
    @ObservedObject var controlInterfaceViewModel: ControlInterfaceViewModel
    
    init(node: LearningNode, width: CGFloat, height: CGFloat, controlInterfaceViewModel: ControlInterfaceViewModel, id: Int) {
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
            
            ForEach(LearningNodeType.allCases) { type in
                if node.type == type {
                    Button {
                        controlInterfaceViewModel.updateNodeType(learningNode: node,
                                                                 type: type)
                    } label: {
                        Text(type.name)
                            .foregroundColor(.red)
                    }

                } else {
                    Button {
                        controlInterfaceViewModel.updateNodeType(learningNode: node,
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
            case .mobileNet:
                if let data = node.data as? LearningNodeDataMobileNet {
                    ControlInterfaceNodeMenuMobileNet(controlInterfaceViewModel: controlInterfaceViewModel,
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
    ControlInterfaceLearningContentContainerView(node: LearningNode.preview,
                                                 width: ApplicationController.shared.appWidth,
                                                 height: ApplicationController.shared.toolbarHeight,
                                                 controlInterfaceViewModel: ControlInterfaceViewModel.preview,
                                                 id: 0)
}
