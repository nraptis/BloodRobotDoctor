//
//  ControlInterfaceNodeMenuGaussianView.swift
//  Macintosh
//
//  Created by Screwy Uncle Louie on 10/3/23.
//

import SwiftUI

struct ControlInterfaceNodeMenuGaussianView: View {
    
    @ObservedObject var controlInterfaceViewModel: ControlInterfaceViewModel
    let node: ProcessingNode
    let data: ProcessingNodeDataGaussian
    
    var body: some View {
        VStack {
            
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
            
            Text("value of size: \(data.size)")

        }
        .background(Color.red)
    }
}

#Preview {
    ControlInterfaceNodeMenuGaussianView(controlInterfaceViewModel: ControlInterfaceViewModel.preview,
                                         node: ProcessingNode.preview,
                                         data: ProcessingNodeDataGaussian())
}
