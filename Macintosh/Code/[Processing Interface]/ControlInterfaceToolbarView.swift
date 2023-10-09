//
//  ControlInterfaceToolbarView.swift
//  Macintosh
//
//  Created by Sports Dad on 10/2/23.
//

import SwiftUI

struct ControlInterfaceToolbarView: View {
    let width: CGFloat
    let height: CGFloat
    @ObservedObject var controlInterfaceViewModel: ControlInterfaceViewModel
    
    init(width: CGFloat, height: CGFloat, controlInterfaceViewModel: ControlInterfaceViewModel) {
        self.width = width
        self.height = height
        self.controlInterfaceViewModel = controlInterfaceViewModel
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            HStack {
                
                Button {
                    controlInterfaceViewModel.addProcessingNode()
                } label: {
                    ZStack {
                        Text("Add Processing Node")
                            .padding(.all, 8.0)
                    }
                    .frame(width: 128.0, height: 36.0)
                    .background(LinearGradient(colors: [Color.red, Color.blue], startPoint: UnitPoint(x: 0.5, y: 1.0), endPoint: UnitPoint(x: 0.5, y: 0.0)))
                }
                
                Button {
                    controlInterfaceViewModel.addLearningNode()
                } label: {
                    ZStack {
                        Text("Add Learning Node")
                            .padding(.all, 8.0)
                    }
                    .frame(width: 128.0, height: 36.0)
                    .background(LinearGradient(colors: [Color.brown, Color.purple], startPoint: UnitPoint(x: 0.5, y: 1.0), endPoint: UnitPoint(x: 0.5, y: 0.0)))
                }
                
                Button {
                    controlInterfaceViewModel.deleteNode()
                } label: {
                    ZStack {
                        Text("Delete Node")
                            .padding(.all, 8.0)
                    }
                    .frame(width: 128.0, height: 36.0)
                    .background(LinearGradient(colors: [Color.red, Color.blue], startPoint: UnitPoint(x: 0.5, y: 1.0), endPoint: UnitPoint(x: 0.5, y: 0.0)))
                }
                
                Button {
                    controlInterfaceViewModel.moveNodeForward()
                } label: {
                    ZStack {
                        Text("-->")
                            .padding(.all, 8.0)
                    }
                    .frame(width: 128.0, height: 36.0)
                    .background(LinearGradient(colors: [Color.red, Color.blue], startPoint: UnitPoint(x: 0.5, y: 1.0), endPoint: UnitPoint(x: 0.5, y: 0.0)))
                }
                
                Button {
                    controlInterfaceViewModel.moveNodeBack()
                } label: {
                    ZStack {
                        Text("<--")
                            .padding(.all, 8.0)
                    }
                    .frame(width: 128.0, height: 36.0)
                    .background(LinearGradient(colors: [Color.red, Color.blue], startPoint: UnitPoint(x: 0.5, y: 1.0), endPoint: UnitPoint(x: 0.5, y: 0.0)))
                }
                
                Button {
                    controlInterfaceViewModel.save()
                } label: {
                    ZStack {
                        Text("Save")
                            .padding(.all, 8.0)
                    }
                    .frame(width: 128.0, height: 36.0)
                    .background(LinearGradient(colors: [Color.red, Color.blue], startPoint: UnitPoint(x: 0.5, y: 1.0), endPoint: UnitPoint(x: 0.5, y: 0.0)))
                }
                
                Button {
                    controlInterfaceViewModel.load()
                } label: {
                    ZStack {
                        Text("Load")
                            .padding(.all, 8.0)
                    }
                    .frame(width: 128.0, height: 36.0)
                    .background(LinearGradient(colors: [Color.red, Color.blue], startPoint: UnitPoint(x: 0.5, y: 1.0), endPoint: UnitPoint(x: 0.5, y: 0.0)))
                }
            }
            
            HStack {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(controlInterfaceViewModel.processingNodes) { node in
                            ControlInterfaceProcessingNodeCell(node: node,
                                                               selected: controlInterfaceViewModel.selected(processingNode: node),
                                                               controlInterfaceViewModel: controlInterfaceViewModel)
                        }
                    }
                }
            }
            .frame(height: 36.0)
            
            HStack {
                ScrollView(.horizontal) {
                    
                    HStack {
                        ForEach(controlInterfaceViewModel.learningNodes) { node in
                            ControlInterfaceLearningNodeCell(node: node,
                                                             selected: controlInterfaceViewModel.selected(learningNode: node),
                                                             controlInterfaceViewModel: controlInterfaceViewModel)
                        }
                    }
                }
            }
            .frame(height: 36.0)

        }
        .frame(width: width, height: height)
        .background(RoundedRectangle(cornerRadius: 60.0).foregroundColor(.green.opacity(0.5)))
    }
}

#Preview {
    ControlInterfaceToolbarView(width: ApplicationController.shared.appWidth,
                                height: ApplicationController.shared.toolbarHeight,
                                controlInterfaceViewModel: ControlInterfaceViewModel.preview)
}
