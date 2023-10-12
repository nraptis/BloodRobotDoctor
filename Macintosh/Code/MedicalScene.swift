//
//  MedicalScene.swift
//  BloodRobotDoctor
//
//  Created by Sports Dad on 9/28/23.
//

import Foundation
import Metal
import Cocoa
import simd

class MedicalScene: GraphicsDelegate {
    
    static var preview: MedicalScene {
        MedicalScene(controlInterfaceViewModel: ControlInterfaceViewModel.preview,
                     medicalModel: MedicalModel.preview)
    }
    
    static let processingCompleteNotificationName = NSNotification.Name("processing.complete")
    
    var graphics: Graphics!
    
    var slices = [MedicalSceneSlice]()
    
    let processingQueue = DispatchQueue(label: "com.medical.processing.queue")
    
    var isProcessingExecuting = false
    var isProcessingComplete = false
    
    let sliceWidth = 256
    let sliceHeight = 256
    let gridWidth = 3
    let gridHeight = 3
    let gridSpacing = Float(12.0)
    
    let controlInterfaceViewModel: ControlInterfaceViewModel
    let medicalModel: MedicalModel
    
    init(controlInterfaceViewModel: ControlInterfaceViewModel, medicalModel: MedicalModel) {
        self.controlInterfaceViewModel = controlInterfaceViewModel
        self.medicalModel = medicalModel
    }
    
    func load() {
        
        let imageNameList = [
            "test_image_272_380.png",
            "test_image_420_236.png",
            "test_image_440_800.png",
            "test_image_880_520.png",
            
            "cat_and_dog_1_256.png", "cat_and_dog_2_256.png", "callib_image_256_02.png",
            "callib_image_256_03.png", "callib_image_256_04.png",
            //"callib_image_256_05.png",
            //"callib_image_256_06.png", "callib_image_256_07.png", "callib_image_256_08.png"
        ]
        
        
        
        
        for index in imageNameList.indices {
            let imageName = imageNameList[index]
            //let x = xList[index]
            //let y = yList[index]
            
            let filePath = FileUtils.shared.assetsPath(imageName)
            let url = URL(filePath: filePath)
            
            print("url = \(url)")
            
            if let nsImage = NSImage(contentsOf: url) {
                
                print("ns image: \(nsImage.size.width) x \(nsImage.size.height)")
                
                if let downsize = NSImage.cropAndFit(image: nsImage, width: CGFloat(sliceWidth), height: CGFloat(sliceHeight)) {
                    
                    //if let texture = graphics.loadTexture(fileName: imageName) {
                    if let texture = graphics.loadTexture(image: nsImage) {
                        let rgbImage = RGBImage(texture: texture)
                        let slice = MedicalSceneSlice(id: index,
                                                      graphics: graphics,
                                                      x: 0.0,
                                                      y: 0.0,
                                                      width: Float(sliceWidth),
                                                      height: Float(sliceHeight),
                                                      image: rgbImage)
                        slices.append(slice)
                        
                    }
                }
            }
            
        }
        repositionTiles()
    }
    
    @objc func receive(notification: Notification) {
        
    }
    
    func update() {
        
        if controlInterfaceViewModel.isProcessingEnqueued == true && isProcessingExecuting == false {
            controlInterfaceViewModel.isProcessingEnqueued = false
            isProcessingExecuting = true
            
            var processingNodes = [ProcessingNode]()
            for processingNode in controlInterfaceViewModel.processingNodes {
                processingNodes.append(processingNode)
            }
            
            var learningNodes = [LearningNode]()
            for learningNode in controlInterfaceViewModel.learningNodes {
                learningNodes.append(learningNode)
            }
            
            processingQueue.async {
                self.processInBackground(processingNodes: processingNodes)
                self.learnInBackground(learningNodes: learningNodes)
                self.isProcessingComplete = true
                
                // Note: isProcessingExecuting gets reset on the draw as we update textures...
                // Instruct the UI to Re-Draw
                NotificationCenter.default.post(name: Self.processingCompleteNotificationName, object: nil)
            }
        }
    }
    
    func draw3D(renderEncoder: MTLRenderCommandEncoder) {
        
    }
    
    func draw2D(renderEncoder: MTLRenderCommandEncoder) {
        
        if isProcessingComplete {
            for slice in slices {
                if let texture = slice.sprite.texture {
                    let bytes = slice.imageProcessed.arrayBGRA()
                    let bytesPerPixel = 4
                    let bytesPerRow = slice.imageProcessed.width * bytesPerPixel
                    let region = MTLRegionMake2D(0,
                                                 0,
                                                 slice.imageProcessed.width,
                                                 slice.imageProcessed.height)
                    
                    texture.replace(region: region,
                                    mipmapLevel: 0,
                                    withBytes: bytes,
                                    bytesPerRow: bytesPerRow)
                }
            }
            isProcessingComplete = false
            isProcessingExecuting = false
        }
        
        repositionTiles()
        
        for slice in slices {
            slice.draw2D(renderEncoder: renderEncoder)
        }
    }
    
    func repositionTiles() {
        let centerX = graphics.width * 0.5
        let centerY = graphics.height * 0.5
        
        var startX = centerX
        startX -= Float(sliceWidth) * Float(gridWidth) * 0.5
        if gridWidth > 1 {
            startX -= Float(gridSpacing) * Float(gridWidth - 1) * 0.5
        }
        
        var startY = centerY
        startY -= Float(sliceHeight) * Float(gridHeight) * 0.5
        if gridHeight > 1 {
            startY -= Float(gridSpacing) * Float(gridHeight - 1) * 0.5
        }
        
        var gridX = 0
        var gridY = 0
        var x = startX
        var y = startY
        for index in 0..<slices.count {
            
            slices[index].x = x
            slices[index].y = y
            slices[index].width = Float(sliceWidth)
            slices[index].height = Float(sliceWidth)
            
            gridX += 1
            if gridX == gridWidth {
                gridX = 0
                gridY += 1
                y += Float(sliceHeight) + gridSpacing
                x = startX
            } else {
                x += Float(sliceWidth) + gridSpacing
            }
        }
    }
    
    private func processInBackground(processingNodes: [ProcessingNode]) {
        for slice in slices {
            slice.imageProcessed = controlInterfaceViewModel.process(rgbaImage: slice.image, slice: slice)
        }
    }
    
    private func learnInBackground(learningNodes: [LearningNode]) {
        for slice in slices {
            _ = controlInterfaceViewModel.process(rgbaImage: slice.image, slice: slice)
            
        }
    }
    
    
}
