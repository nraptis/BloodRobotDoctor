//
//  ControlInterfaceNodeCell.swift
//  Macintosh
//
//  Created by Sports Dad on 10/3/23.
//

import SwiftUI

struct ControlInterfaceNodeCell: View {
    
    let width: CGFloat = 128.0
    let height: CGFloat = 36.0
    let node: ProcessingNode
    let selected: Bool
    @ObservedObject var controlInterfaceViewModel: ControlInterfaceViewModel
    
    init(node: ProcessingNode, selected: Bool, controlInterfaceViewModel: ControlInterfaceViewModel) {
        self.node = node
        self.selected = selected
        self.controlInterfaceViewModel = controlInterfaceViewModel
    }
    
    var body: some View {
        ZStack {
            Button {
                controlInterfaceViewModel.select(node: node)
            } label: {
                ZStack {
                    Text("\(node.id)")
                        .padding(.all, 8.0)
                }
                .frame(width: width, height: height)
                .background(RoundedRectangle(cornerRadius: 60.0).foregroundColor(selected ? .green : .orange))
            }
        }
        .frame(width: width, height: height)
        VStack {
            
        }
    }
}

#Preview {
    ControlInterfaceNodeCell(node: ProcessingNode.preview,
                             selected: true,
                             controlInterfaceViewModel: ControlInterfaceViewModel.preview)
}
