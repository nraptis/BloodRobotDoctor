//
//  ControlInterfaceLearningNodeCell.swift
//  Macintosh
//
//  Created by Screwy Uncle Louie on 10/9/23.
//

import SwiftUI

struct ControlInterfaceLearningNodeCell: View {
    let width: CGFloat = 128.0
    let height: CGFloat = 36.0
    let node: LearningNode
    let selected: Bool
    @ObservedObject var controlInterfaceViewModel: ControlInterfaceViewModel
    
    init(node: LearningNode, selected: Bool, controlInterfaceViewModel: ControlInterfaceViewModel) {
        self.node = node
        self.selected = selected
        self.controlInterfaceViewModel = controlInterfaceViewModel
    }
    
    var body: some View {
        ZStack {
            Button {
                controlInterfaceViewModel.select(learningNode: node)
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
    ControlInterfaceLearningNodeCell(node: LearningNode.preview,
                                     selected: true,
                                     controlInterfaceViewModel: ControlInterfaceViewModel.preview)
}
