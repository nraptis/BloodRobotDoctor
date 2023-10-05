//
//  ControlInterfaceViewModel.swift
//  Macintosh
//
//  Created by Sports Dad on 10/2/23.
//

import Foundation

class ControlInterfaceViewModel: ObservableObject {
    
    var isProcessingEnqueued = false
    
    var nodes = [ProcessingNode]()
    var selectedNode: ProcessingNode?
    var selectedNodeUUID = 0
    
    private var nodeID = 0
    
    static var preview: ControlInterfaceViewModel {
        ControlInterfaceViewModel()
    }
    
    let medicalModel = MedicalModel()
    
    init() {
        //addNode()
        //updateNodeType(node: selectedNode, type: .gray)
        
        //addNode()
        //updateNodeType(node: selectedNode, type: .dilation)
        
        addNode()
        updateNodeType(node: selectedNode, type: .gauss)
        
        if let node = selectedNode, let data = node.data as? ProcessingNodeDataGaussian {
            data.sizeX = 12
            data.sizeY = 0
            
            data.sigmaX = 0.0
            data.sigmaY = 60.0
        }
        
        /*
        addNode()
        updateNodeType(node: selectedNode, type: .gauss)
        
        if let node = selectedNode, let data = node.data as? ProcessingNodeDataGaussian {
            data.size = 4
            data.sigma = 15.0
        }
         */
        
        
        
    }
    
    private func incrementSelectedNodeUUID() {
        selectedNodeUUID += 1
        if selectedNodeUUID >= 1000 {
            selectedNodeUUID = 0
        }
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
                incrementSelectedNodeUUID()
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
    
    func addNode() {
        let node = ProcessingNode(id: nodeID)
        nodes.append(node)
        selectedNode = node
        nodeID += 1
        
        postUpdateAndEnqueueRebuild()
    }
    
    func updateNodeType(node: ProcessingNode?, type: ProcessingNodeType) {
        if let index = nodeIndex(node) {
            
            if nodes[index].type != type {
                
                nodes[index].type = type
             
                switch type {
                    
                case .none:
                    nodes[index].data = ProcessingNodeData()
                case .gray:
                    nodes[index].data = ProcessingNodeDataGray()
                case .gauss:
                    nodes[index].data = ProcessingNodeDataGaussian()
                case .erosion:
                    nodes[index].data = ProcessingNodeDataErode()
                case .dilation:
                    nodes[index].data = ProcessingNodeDataDilate()
                }
                
                postUpdateAndEnqueueRebuild()
                
            }
        }
    }
    
    func deleteNode() {
        if let index = nodeIndex(selectedNode) {
            
            nodes.remove(at: index)
            
            if nodes.count <= 0 {
                postUpdateAndEnqueueRebuild()
            } else {
                if index < nodes.count {
                    selectedNode = nodes[index]
                    postUpdateAndEnqueueRebuild()
                } else {
                    selectedNode = nodes[nodes.count - 1]
                    postUpdateAndEnqueueRebuild()
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
    
    func nodeGaussianSetSizeX(node: ProcessingNode, sizeX: Int) {
        if let data = node.data as? ProcessingNodeDataGaussian {
            data.sizeX = sizeX
            postUpdateAndEnqueueRebuild()
        }
    }
    
    func nodeGaussianSetSizeY(node: ProcessingNode, sizeY: Int) {
        if let data = node.data as? ProcessingNodeDataGaussian {
            data.sizeY = sizeY
            postUpdateAndEnqueueRebuild()
        }
    }
    
    func nodeGaussianSetSigmaX(node: ProcessingNode, sigmaX: Float) {
        if let data = node.data as? ProcessingNodeDataGaussian {
            data.sigmaX = sigmaX
            postUpdateAndEnqueueRebuild()
        }
    }
    
    func nodeGaussianSetSigmaY(node: ProcessingNode, sigmaY: Float) {
        if let data = node.data as? ProcessingNodeDataGaussian {
            data.sigmaY = sigmaY
            postUpdateAndEnqueueRebuild()
        }
    }
    
    
    func save() {
        
    }
    
    func load() {
        
    }
    
    func postUpdate() {
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    func postUpdateAndEnqueueRebuild() {
        DispatchQueue.main.async {
            self.objectWillChange.send()
            self.isProcessingEnqueued = true
        }
    }
    
    func process(rgbaImage: RGBImage) -> RGBImage {
        var result = rgbaImage.clone()
        for node in nodes {
            result = node.process(rgbaImage: result)
        }
        return result
    }
    
}
