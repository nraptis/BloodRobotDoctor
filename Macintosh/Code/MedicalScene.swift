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
    
    func load() {
        //sprite.load(graphics: graphics, fileName: "test_image_8_4.png")
        
        let centerX = graphics.width * 0.5
        let centerY = graphics.height * 0.5
        let sliceWidth = 256
        let sliceHeight = 256
        let gridWidth = 3
        let gridHeight = 3
        let gridSpacing = Float(16.0)
        
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
        
        
        //- (Float(sliceHeight) * Float(gridHeight) * 0.5 + gridSpacing * Float(gridHeight - 1))
        
        var imageNameList = [
            "callib_image_256_00.png",
            "callib_image_256_01.png",
            "callib_image_256_02.png",
            "callib_image_256_03.png",
            "callib_image_256_04.png",
            "callib_image_256_05.png",
            "callib_image_256_06.png",
            "callib_image_256_07.png",
            "callib_image_256_08.png"]
        
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
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.jax()
        }
    }
    
    @objc func receive(notification: Notification) {
        
    }
    
    var ROTATEEE = Float(0.0)
    
    func jax() {
        for slice in slices {
            slice.jax()
        }
    }
    
    func update() {
        
        ROTATEEE += 0.005
        if ROTATEEE >= Float.pi * 2.0 {
            ROTATEEE -= Float.pi * 2.0
        }
        
        
    }
    
    func draw3D(renderEncoder: MTLRenderCommandEncoder) {
        
    }
    
    func draw2D(renderEncoder: MTLRenderCommandEncoder) {
        for slice in slices {
            slice.draw2D(renderEncoder: renderEncoder)
        }
    }
}
