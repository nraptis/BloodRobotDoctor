//
//  ControlInterfaceContentContainerView.swift
//  Macintosh
//
//  Created by Sports Dad on 10/2/23.
//

import SwiftUI

struct ControlInterfaceContentContainerView: View {
    
    let node: ProcessingNode
    
    let width: CGFloat
    let height: CGFloat
    
    @ObservedObject var controlInterfaceViewModel: ControlInterfaceViewModel
    
    init(node: ProcessingNode, width: CGFloat, height: CGFloat, controlInterfaceViewModel: ControlInterfaceViewModel) {
        self.node = node
        self.width = width
        self.height = height
        self.controlInterfaceViewModel = controlInterfaceViewModel
        //
        //selectedType = type
        
        print("initializn with \(node.type)")
        
    }
    
    var body: some View {
        VStack {
            
            Text("t1 = \(node.type.name)")

            
            
            ForEach(ProcessingNodeType.allCases) { type in
                if node.type == type {
                    Button {
                        controlInterfaceViewModel.updateNodeType(node: node,
                                                                 type: type)
                    } label: {
                        Text(type.name)
                            .foregroundColor(.red)
                    }

                } else {
                    Button {
                        controlInterfaceViewModel.updateNodeType(node: node,
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
                ControlInterfaceNodeMenuErosionView()
            case .dilation:
                ControlInterfaceNodeMenuDilationView()
                
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
        /*
        .onChange(of: selectedType, initial: true) {
            print("selected type now is \(selectedType.name)")
            controlInterfaceViewModel.updateNodeType(node: node,
                                                     type: selectedType)
        }
        */
        .onAppear {
            print("appeard")
        }
    }
}

#Preview {
    ControlInterfaceContentContainerView(node: ProcessingNode.preview,
                                         width: ApplicationController.shared.appWidth,
                                         height: ApplicationController.shared.toolbarHeight,
                                         controlInterfaceViewModel: ControlInterfaceViewModel.preview)
}
