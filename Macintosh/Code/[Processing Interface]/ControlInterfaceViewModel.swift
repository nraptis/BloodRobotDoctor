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
        load()
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
                selectedNode = nil
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
    
    func nodeErodeSetElement(node: ProcessingNode, element: ErosionElement) {
        if let data = node.data as? ProcessingNodeDataErode {
            data.element = element
            postUpdateAndEnqueueRebuild()
        }
    }
    
    func nodeErodeSetSize(node: ProcessingNode, size: Int) {
        if let data = node.data as? ProcessingNodeDataErode {
            data.size = size
            postUpdateAndEnqueueRebuild()
        }
    }
    
    func nodeDilateSetElement(node: ProcessingNode, element: DilationElement) {
        if let data = node.data as? ProcessingNodeDataDilate {
            data.element = element
            postUpdateAndEnqueueRebuild()
        }
    }
    
    func nodeDilateSetSize(node: ProcessingNode, size: Int) {
        if let data = node.data as? ProcessingNodeDataDilate {
            data.size = size
            postUpdateAndEnqueueRebuild()
        }
    }
    
    func save() {
        let filePath = FileUtils.shared.documentsPath("saved.json")
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(nodes)
            FileUtils.shared.saveDataToFilePath(data, filePath)
        } catch let error {
            print("Error encoding: \(error.localizedDescription)")
            print("Error encoding: \(self)")
        }
    }
    
    func load() {
        selectedNode = nil
        let decoder = JSONDecoder()
        do {
            if let data = FileUtils.shared.dataFromDocumentsFile("saved.json") {
                
                nodes = try decoder.decode([ProcessingNode].self, from: data)
                
                for index in 0..<nodes.count {
                    nodes[index].id = index
                    selectedNode = nodes[index]
                }
            }
            
            //let data = try encoder.encode(nodes)
            
        } catch let error {
            print("Error decoding: \(error.localizedDescription)")
            print("Error decoding: \(self)")
        }
        
        incrementSelectedNodeUUID()
        postUpdateAndEnqueueRebuild()
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
