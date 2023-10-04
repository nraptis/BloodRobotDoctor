//
//  MedicalScene.swift
//  BloodRobotDoctor
//
//  Created by Sports Dad on 9/28/23.
//

import Foundation
import Metal
import simd

class MedicalScene: GraphicsDelegate {
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
        //sprite.load(graphics: graphics, fileName: "test_image_8_4.png")
        
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
        
        let imageNameList = [
            "callib_image_256_00.png", "callib_image_256_01.png", "callib_image_256_02.png",
            "callib_image_256_03.png", "callib_image_256_04.png", "callib_image_256_05.png",
            "callib_image_256_06.png", "callib_image_256_07.png", "callib_image_256_08.png"]
        
        var xList = [Float]()
        var yList = [Float]()
        
        var gridX = 0
        var gridY = 0
        var x = startX
        var y = startY
        for _ in 0..<imageNameList.count {
            xList.append(x)
            yList.append(y)
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
        
        for index in imageNameList.indices {
            let imageName = imageNameList[index]
            let x = xList[index]
            let y = yList[index]
            
            if let texture = graphics.loadTexture(fileName: imageName) {
                let rgbImage = RGBImage(texture: texture)
                let slice = MedicalSceneSlice(graphics: graphics,
                                              x: x,
                                              y: y,
                                              width: Float(sliceWidth),
                                              height: Float(sliceHeight),
                                              image: rgbImage)
                slices.append(slice)
            }
        }
        
        
        
        
        
        /*
         callib_image_256_00.png
         callib_image_256_01.png
         callib_image_256_02.png
         callib_image_256_03.png
         callib_image_256_04.png
         callib_image_256_05.png
         callib_image_256_06.png
         callib_image_256_07.png
         callib_image_256_08.png

         callib_image_512_08.png
         callib_image_512_00.png
         callib_image_512_01.png
         callib_image_512_02.png
         callib_image_512_03.png
         callib_image_512_04.png
         callib_image_512_05.png
         callib_image_512_06.png
         callib_image_512_07.png
        */
        
        
        
        //DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        //    self.jax()
        //}
        
    }
    
    @objc func receive(notification: Notification) {
        
    }
    
    func update() {
        
        if Int.random(in: 0...100) == 25 {
            print("controlInterfaceViewModel.isProcessingEnqueued = \(controlInterfaceViewModel.isProcessingEnqueued) | isProcessingExecuting = \(isProcessingExecuting)")
        }
        if controlInterfaceViewModel.isProcessingEnqueued == true && isProcessingExecuting == false {
            controlInterfaceViewModel.isProcessingEnqueued = false
            isProcessingExecuting = true
            
            var processingNodes = [ProcessingNode]()
            for processingNode in controlInterfaceViewModel.nodes {
                processingNodes.append(processingNode)
            }
            
            print("Process In Background...!!!")
            
            processingQueue.async {
                self.processInBackground(processingNodes: processingNodes)
                self.isProcessingComplete = true
                
                // Note: isProcessingExecuting gets reset on the draw as we update textures...
            }
        }
    }
    
    func draw3D(renderEncoder: MTLRenderCommandEncoder) {
        
    }
    
    func draw2D(renderEncoder: MTLRenderCommandEncoder) {
        
        if isProcessingComplete {
            
            print("isProcessingComplete ==> STAMP")
            
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
                slice.stampProcessedImageToTexture()
            }
            
            isProcessingComplete = false
            isProcessingExecuting = false
        }
        
        let centerX = graphics.width * 0.5
        let centerY = graphics.height * 0.5
        
        var startX = centerX
        startX -= Float(sliceWidth) * Float(gridWidth) * 0.5
        if gridWidth > 1 {
            startX -= Float(gridSpacing) * Float(gridWidth - 1) * 0.5
        }
        
        //- (Float(sliceWidth) * Float(gridWidth) * 0.5 + gridSpacing * Float(gridWidth - 1))
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
        
        
        for slice in slices {
            slice.draw2D(renderEncoder: renderEncoder)
        }
    }
    
    private func processInBackground(processingNodes: [ProcessingNode]) {
        print("processInBackground ==> START")
        for slice in slices {
            slice.imageProcessed = controlInterfaceViewModel.process(rgbaImage: slice.image)
        }
        print("processInBackground ==> DONE")
    }
    
    
}
