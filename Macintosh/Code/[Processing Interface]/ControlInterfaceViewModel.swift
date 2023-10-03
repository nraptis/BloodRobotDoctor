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
    
    init() {
        addNode()
        updateNodeType(node: selectedNode, type: .gray)
        
        addNode()
        updateNodeType(node: selectedNode, type: .gauss)
        
        addNode()
        updateNodeType(node: selectedNode, type: .dilation)
    }
    
    func select(node: ProcessingNode) {
        
        if let selectedNode = selectedNode {
            if selectedNode.id == node.id {
                self.selectedNode = nil
                postUpdate()
                return
            }
        }
        
        for _node in nodes {
            if _node.id == node.id {
                selectedNode = _node
                postUpdate()
                return
            }
        }
        selectedNode = nil
        postUpdate()
    }
    
    func selected(node: ProcessingNode) -> Bool {
        if let selectedNode = selectedNode {
            if selectedNode.id == node.id {
                return true
            }
        }
        return false
    }
    
    func expand() {
        expanded = true
        postUpdate()
    }
    
    func collapse() {
        expanded = false
        postUpdate()
    }
    
    func addNode() {
        let node = ProcessingNode(id: nodeID)
        nodes.append(node)
        selectedNode = node
        nodeID += 1
        
        postUpdateAndEnqueueRebuild()
    }
    
    func updateNodeType(node: ProcessingNode?, type: ProcessingNodeType) {
        if let index = nodeIndex(node) {
            nodes[index].type = type
            postUpdateAndEnqueueRebuild()
        }
    }
    
    func deleteNode() {
        if let index = nodeIndex(selectedNode) {
            
            nodes.remove(at: index)
            
            if nodes.count <= 0 {
                postUpdate()
            } else {
                if index < nodes.count {
                    selectedNode = nodes[index]
                    postUpdate()
                } else {
                    selectedNode = nodes[nodes.count - 1]
                    postUpdate()
                }
            }
        }
    }
    
    func nodeIndex(_ node: ProcessingNode?) -> Int? {
        if let node = node {
            for index in 0..<nodes.count {
                if nodes[index].id == node.id {
                    return index
                }
            }
        }
        return nil
    }
    
    func moveNodeBack() {
        if let index = nodeIndex(selectedNode) {
            if index > 0 {
                nodes.swapAt(index, index - 1)
                postUpdateAndEnqueueRebuild()
            }
        }
    }
    
    func moveNodeForward() {
        if let index = nodeIndex(selectedNode) {
            if index < (nodes.count - 1) {
                nodes.swapAt(index, index + 1)
                postUpdateAndEnqueueRebuild()
            }
        }
    }
    
    func save() {
        
    }
    
    func load() {
        
    }
    
    func postUpdate() {
        if Thread.isMainThread {
            objectWillChange.send()
        } else {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    func postUpdateAndEnqueueRebuild() {
        postUpdate()
        
    }
    
}
