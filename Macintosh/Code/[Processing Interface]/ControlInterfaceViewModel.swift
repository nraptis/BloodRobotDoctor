//
//  ControlInterfaceViewModel.swift
//  Macintosh
//
//  Created by Sports Dad on 10/2/23.
//

import Foundation

class ControlInterfaceViewModel: ObservableObject {
    
    
    
    var isProcessingEnqueued = false
    
    var processingNodes = [ProcessingNode]()
    var learningNodes = [LearningNode]()
    
    var selectedNode: GenericNode?
    var selectedNodeUUID = 0
    
    private var processingNodeID = 0
    private var learningNodeID = 0
    
    static var preview: ControlInterfaceViewModel {
        ControlInterfaceViewModel()
    }
    
    let medicalModel = MedicalModel()
    
    lazy var scene: MedicalScene = {
        MedicalScene(controlInterfaceViewModel: self,
                                 medicalModel: medicalModel)
    }()
    
    
    
    
    
    init() {
        load()
        NotificationCenter.default.addObserver(self, selector: #selector(receive(notification:)),
                                               name: MedicalScene.processingCompleteNotificationName,
                                               object: nil)
    }
    
    @objc func receive(notification: Notification) {
        if Thread.isMainThread {
            print("churp mt")
            objectWillChange.send()
        } else {
            DispatchQueue.main.async {
                print("churp bt")
                self.objectWillChange.send()
            }
        }
    }
    
    private func incrementSelectedNodeUUID() {
        selectedNodeUUID += 1
        if selectedNodeUUID >= 1000 {
            selectedNodeUUID = 0
        }
    }
    
    func select(processingNode: ProcessingNode) {
        if let selectedNode = selectedNode as? ProcessingNode {
            if selectedNode.id == processingNode.id {
                self.selectedNode = nil
                postUpdate()
                return
            }
        }
        for _node in processingNodes {
            if _node.id == processingNode.id {
                selectedNode = _node
                incrementSelectedNodeUUID()
                postUpdate()
                return
            }
        }
        selectedNode = nil
        postUpdate()
    }
    
    func select(learningNode: LearningNode) {
        if let selectedNode = selectedNode as? LearningNode {
            if selectedNode.id == learningNode.id {
                self.selectedNode = nil
                postUpdate()
                return
            }
        }
        for _node in learningNodes {
            if _node.id == learningNode.id {
                selectedNode = _node
                incrementSelectedNodeUUID()
                postUpdate()
                return
            }
        }
        selectedNode = nil
        postUpdate()
    }
    
    func selected(processingNode: ProcessingNode) -> Bool {
        if let selectedNode = selectedNode as? ProcessingNode {
            if selectedNode.id == processingNode.id {
                return true
            }
        }
        return false
    }
    
    func selected(learningNode: LearningNode) -> Bool {
        if let selectedNode = selectedNode as? LearningNode {
            if selectedNode.id == learningNode.id {
                return true
            }
        }
        return false
    }
    
    func addProcessingNode() {
        let node = ProcessingNode(id: processingNodeID)
        processingNodes.append(node)
        selectedNode = node
        processingNodeID += 1
        postUpdateAndEnqueueRebuild()
    }
    
    func addLearningNode() {
        let node = LearningNode(id: learningNodeID)
        learningNodes.append(node)
        selectedNode = node
        learningNodeID += 1
        postUpdateAndEnqueueRebuild()
    }
    
    func updateNodeType(processingNode: ProcessingNode?, type: ProcessingNodeType) {
        if let index = nodeIndex(processingNode: processingNode) {
            if processingNodes[index].type != type {
                processingNodes[index].type = type
                switch type {
                case .none:
                    processingNodes[index].data = ProcessingNodeData()
                case .gray:
                    processingNodes[index].data = ProcessingNodeDataGray()
                case .gauss:
                    processingNodes[index].data = ProcessingNodeDataGaussian()
                case .erosion:
                    processingNodes[index].data = ProcessingNodeDataErode()
                case .dilation:
                    processingNodes[index].data = ProcessingNodeDataDilate()
                }
                postUpdateAndEnqueueRebuild()
            }
        }
    }
    
    func updateNodeType(learningNode: LearningNode?, type: LearningNodeType) {
        if let index = nodeIndex(learningNode: learningNode) {
            if learningNodes[index].type != type {
                learningNodes[index].type = type
                switch type {
                case .none:
                    learningNodes[index].data = LearningNodeData()
                case .mobileNet:
                    learningNodes[index].data = LearningNodeDataMobileNet()
                }
                postUpdateAndEnqueueRebuild()
            }
        }
    }
    
    func deleteNode() {
        
        if let selectedProcessingNode = selectedNode as? ProcessingNode {
            if let index = nodeIndex(processingNode: selectedProcessingNode) {
                processingNodes.remove(at: index)
                if processingNodes.count <= 0 {
                    selectedNode = nil
                    postUpdateAndEnqueueRebuild()
                } else {
                    if index < processingNodes.count {
                        selectedNode = processingNodes[index]
                        postUpdateAndEnqueueRebuild()
                    } else {
                        selectedNode = processingNodes[processingNodes.count - 1]
                        postUpdateAndEnqueueRebuild()
                    }
                }
            }
        }
        
        if let selectedLearningNode = selectedNode as? LearningNode {
            if let index = nodeIndex(learningNode: selectedLearningNode) {
                learningNodes.remove(at: index)
                if learningNodes.count <= 0 {
                    selectedNode = nil
                    postUpdateAndEnqueueRebuild()
                } else {
                    if index < learningNodes.count {
                        selectedNode = learningNodes[index]
                        postUpdateAndEnqueueRebuild()
                    } else {
                        selectedNode = learningNodes[learningNodes.count - 1]
                        postUpdateAndEnqueueRebuild()
                    }
                }
            }
        }
    }
    
    func nodeIndex(processingNode: ProcessingNode?) -> Int? {
        if let processingNode = processingNode {
            for index in 0..<processingNodes.count {
                if processingNodes[index].id == processingNode.id {
                    return index
                }
            }
        }
        return nil
    }
    
    func nodeIndex(learningNode: LearningNode?) -> Int? {
        if let learningNode = learningNode {
            for index in 0..<learningNodes.count {
                if learningNodes[index].id == learningNode.id {
                    return index
                }
            }
        }
        return nil
    }
    
    func moveNodeBack() {
        if let processingNode = selectedNode as? ProcessingNode {
            if let index = nodeIndex(processingNode: processingNode) {
                if index > 0 {
                    processingNodes.swapAt(index, index - 1)
                    postUpdateAndEnqueueRebuild()
                }
            }
        }
        if let learningNode = selectedNode as? LearningNode {
            if let index = nodeIndex(learningNode: learningNode) {
                if index > 0 {
                    learningNodes.swapAt(index, index - 1)
                    postUpdateAndEnqueueRebuild()
                }
            }
        }
    }
    
    func moveNodeForward() {
        if let processingNode = selectedNode as? ProcessingNode {
            if let index = nodeIndex(processingNode: processingNode) {
                if index < (processingNodes.count - 1) {
                    processingNodes.swapAt(index, index + 1)
                    postUpdateAndEnqueueRebuild()
                }
            }
        }
        if let learningNode = selectedNode as? LearningNode {
            if let index = nodeIndex(learningNode: learningNode) {
                if index < (learningNodes.count - 1) {
                    learningNodes.swapAt(index, index + 1)
                    postUpdateAndEnqueueRebuild()
                }
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
        do {
            let encoder = JSONEncoder()
            let filePath = FileUtils.shared.documentsPath("processing_saved.json")
            let data = try encoder.encode(processingNodes)
            FileUtils.shared.saveDataToFilePath(data, filePath)
        } catch let error {
            print("Error encoding: \(error.localizedDescription)")
            print("Error encoding: \(self)")
        }
        
        do {
            let encoder = JSONEncoder()
            let filePath = FileUtils.shared.documentsPath("learning_saved.json")
            let data = try encoder.encode(learningNodes)
            FileUtils.shared.saveDataToFilePath(data, filePath)
        } catch let error {
            print("Error encoding: \(error.localizedDescription)")
            print("Error encoding: \(self)")
        }
    }
    
    func load() {
        selectedNode = nil
        
        do {
            let decoder = JSONDecoder()
            if let data = FileUtils.shared.dataFromDocumentsFile("processing_saved.json") {
                processingNodes = try decoder.decode([ProcessingNode].self, from: data)
                for index in 0..<processingNodes.count {
                    processingNodes[index].id = index
                    selectedNode = processingNodes[index]
                }
            }
        } catch let error {
            print("Error decoding: \(error.localizedDescription)")
            print("Error decoding: \(self)")
        }
        
        do {
            let decoder = JSONDecoder()
            if let data = FileUtils.shared.dataFromDocumentsFile("learning_saved.json") {
                learningNodes = try decoder.decode([LearningNode].self, from: data)
                for index in 0..<learningNodes.count {
                    learningNodes[index].id = index
                    selectedNode = learningNodes[index]
                }
            }
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
            
            // TODO: If the medical scene is detached, this will need comment removed
            //self.objectWillChange.send()
            
            self.isProcessingEnqueued = true
        }
    }
    
    func process(rgbaImage: RGBImage, slice: MedicalSceneSlice) -> RGBImage {
        var result = rgbaImage.clone()
        for node in processingNodes {
            result = node.process(rgbaImage: result, slice: slice)
        }
        return result
    }
    
    func learn(rgbaImage: RGBImage, slice: MedicalSceneSlice) -> RGBImage {
        var result = rgbaImage.clone()
        for node in learningNodes {
            result = node.process(rgbaImage: result, slice: slice)
        }
        return result
    }
    
}
