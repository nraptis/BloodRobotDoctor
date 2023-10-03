//
//  ControlInterfaceViewModel.swift
//  Macintosh
//
//  Created by Sports Dad on 10/2/23.
//

import Foundation

class ControlInterfaceViewModel: ObservableObject {
    
    var expanded = true
    var nodes = [ProcessingNode]()
    var selectedNode: ProcessingNode?
    
    private var nodeID = 0
    
    static var preview: ControlInterfaceViewModel {
        ControlInterfaceViewModel()
    }
    
    func expand() {
        expanded = true
        objectWillChange.send()
    }
    
    func collapse() {
        expanded = false
        objectWillChange.send()
    }
    
    func addNode() {
        let node = ProcessingNode(id: nodeID)
        nodes.append(node)
        selectedNode = node
        nodeID += 1
        
        objectWillChange.send()
    }
    
    func deleteNode() {
        
    }
    
    func moveNodeBack() {
        
    }
    
    func moveNodeForward() {
        
    }
    
    func save() {
        
    }
    
    func load() {
        
    }
    
    
    
}
