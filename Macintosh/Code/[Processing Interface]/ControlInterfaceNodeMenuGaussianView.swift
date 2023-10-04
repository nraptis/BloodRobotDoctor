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
    let id: Int
    
    @State var size: Int
    @State var sigma: Float
    
    init(controlInterfaceViewModel: ControlInterfaceViewModel, node: ProcessingNode, data: ProcessingNodeDataGaussian, id: Int) {
        self.controlInterfaceViewModel = controlInterfaceViewModel
        self.node = node
        self.data = data
        self.id = id
        _size = State(wrappedValue: data.size)
        _sigma = State(wrappedValue: data.sigma)
        
        print("initializing with \(data.size) and \(data.sigma)")
    }
    
    var body: some View {
        VStack {

            Stepper("Stepa \(size)", value: $size, in: 0...20)

            Slider(value: $sigma, in: 0.0...100.0)
            
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
            
            Text("value of size: \(data.size) vs \(size)")
            Text("value of sig: \(data.sigma) vs \(sigma)")
            Text("Da id: \(id)")
            

        }
        .background(Color.red)
        .onChange(of: size) {
            print("size is now \(size)")
            controlInterfaceViewModel.nodeGaussianSetSize(node: node,
                                                          size: size)
        }
        .onChange(of: sigma) {
            print("sigma is now \(sigma)")
            controlInterfaceViewModel.nodeGaussianSetSigma(node: node,
                                                           sigma: sigma)
        }
        .onAppear {
            print("did on sppear called")
        }
        
    }
}

#Preview {
    ControlInterfaceNodeMenuGaussianView(controlInterfaceViewModel: ControlInterfaceViewModel.preview,
                                         node: ProcessingNode.preview,
                                         data: ProcessingNodeDataGaussian(),
                                         id: 0)
}
