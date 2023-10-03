//
//  ControlInterfaceToolbarView.swift
//  Macintosh
//
//  Created by Screwy Uncle Louie on 10/2/23.
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
                    if controlInterfaceViewModel.expanded {
                        controlInterfaceViewModel.collapse()
                    } else {
                        controlInterfaceViewModel.expand()
                    }
                } label: {
                    ZStack {
                        if controlInterfaceViewModel.expanded {
                            Text("Expand")
                                .padding(.all, 8.0)
                        } else {
                            Text("Collapse")
                                .padding(.all, 8.0)
                        }
                    }
                    .frame(width: 72.0, height: 44.0)
                    .background(LinearGradient(colors: [Color.red, Color.blue], startPoint: UnitPoint(x: 0.5, y: 1.0), endPoint: UnitPoint(x: 0.5, y: 0.0)))
                }
                
                Button {
                    controlInterfaceViewModel.addNode()
                } label: {
                    ZStack {
                        Text("Add Node")
                            .padding(.all, 8.0)
                    }
                    .frame(width: 72.0, height: 44.0)
                    .background(LinearGradient(colors: [Color.red, Color.blue], startPoint: UnitPoint(x: 0.5, y: 1.0), endPoint: UnitPoint(x: 0.5, y: 0.0)))
                }
                
                Button {
                    controlInterfaceViewModel.deleteNode()
                } label: {
                    ZStack {
                        Text("Delete Node")
                            .padding(.all, 8.0)
                    }
                    .frame(width: 72.0, height: 44.0)
                    .background(LinearGradient(colors: [Color.red, Color.blue], startPoint: UnitPoint(x: 0.5, y: 1.0), endPoint: UnitPoint(x: 0.5, y: 0.0)))
                }
                
                Button {
                    controlInterfaceViewModel.moveNodeForward()
                } label: {
                    ZStack {
                        Text("-->")
                            .padding(.all, 8.0)
                    }
                    .frame(width: 72.0, height: 44.0)
                    .background(LinearGradient(colors: [Color.red, Color.blue], startPoint: UnitPoint(x: 0.5, y: 1.0), endPoint: UnitPoint(x: 0.5, y: 0.0)))
                }
                
                Button {
                    controlInterfaceViewModel.moveNodeBack()
                } label: {
                    ZStack {
                        Text("<--")
                            .padding(.all, 8.0)
                    }
                    .frame(width: 72.0, height: 44.0)
                    .background(LinearGradient(colors: [Color.red, Color.blue], startPoint: UnitPoint(x: 0.5, y: 1.0), endPoint: UnitPoint(x: 0.5, y: 0.0)))
                }
                
                Button {
                    controlInterfaceViewModel.save()
                } label: {
                    ZStack {
                        Text("Save")
                            .padding(.all, 8.0)
                    }
                    .frame(width: 72.0, height: 44.0)
                    .background(LinearGradient(colors: [Color.red, Color.blue], startPoint: UnitPoint(x: 0.5, y: 1.0), endPoint: UnitPoint(x: 0.5, y: 0.0)))
                }
                
                Button {
                    controlInterfaceViewModel.load()
                } label: {
                    ZStack {
                        Text("Load")
                            .padding(.all, 8.0)
                    }
                    .frame(width: 72.0, height: 44.0)
                    .background(LinearGradient(colors: [Color.red, Color.blue], startPoint: UnitPoint(x: 0.5, y: 1.0), endPoint: UnitPoint(x: 0.5, y: 0.0)))
                }
                
            }
            
            HStack {
                ScrollView(.horizontal) {
                    
                    HStack {
                        ForEach(controlInterfaceViewModel.nodes) { node in
                            ZStack {
                                Text("\(node.id)")
                                    .padding(.all, 8.0)
                            }
                            .frame(width: 72.0, height: 44.0)
                            .background(LinearGradient(colors: [Color.blue, Color.green], startPoint: UnitPoint(x: 0.5, y: 1.0), endPoint: UnitPoint(x: 0.5, y: 0.0)))
                        }
                    }
                }
            }

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
