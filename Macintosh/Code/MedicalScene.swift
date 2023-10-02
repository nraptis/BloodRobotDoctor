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
    
    let recycler = RecyclerShapeQuad2D()
    
    let recyclerSprite2D = RecyclerSprite2D()
    
    let sprite = Sprite2D()
    
    func load() {
        //sprite.load(graphics: graphics, fileName: "test_image_8_4.png")
        
        let tex = graphics.loadTexture(fileName: "test_platelet.png")
        //let tex = graphics.loadTexture(fileName: "test_image_8_4.png")
        
        let rg = RGBImage(texture: tex)
        
        let w = rg.width
        let h = rg.height
        
        rg.set(x: 0, y: 0, red: 255, green: 0, blue: 0)
        rg.set(x: 1, y: 0, red: 192, green: 64, blue: 64)
        rg.set(x: 0, y: 1, red: 192, green: 64, blue: 64)
        
        rg.set(x: w - 1, y: 0, red: 0, green: 255, blue: 0)
        rg.set(x: w - 2, y: 0, red: 64, green: 192, blue: 64)
        rg.set(x: w - 1, y: 1, red: 64, green: 192, blue: 64)
        
        
        rg.set(x: 0, y: h - 1, red: 0, green: 0, blue: 255)
        rg.set(x: 1, y: h - 1, red: 64, green: 64, blue: 192)
        rg.set(x: 0, y: h - 2, red: 64, green: 64, blue: 192)
        
        
        rg.set(x: w - 1, y: h - 1, red: 255, green: 255, blue: 255)
        rg.set(x: w - 2, y: h - 1, red: 128, green: 128, blue: 192)
        rg.set(x: w - 1, y: h - 2, red: 128, green: 128, blue: 192)
        
        if let ggg = OpenCVWrapper.process(rg) {
            
            if let ttt = ggg.texture(device: graphics.device) {
                sprite.load(graphics: graphics, texture: ttt)
            }
        }
        
        let poo = RGBImage(texture: sprite.texture)
    }
    
    @objc func receive(notification: Notification) {
        
    }
    
    var ROTATEEE = Float(0.0)
    
    func update() {
        
        ROTATEEE += 0.005
        if ROTATEEE >= Float.pi * 2.0 {
            ROTATEEE -= Float.pi * 2.0
        }
        
        
    }
    
    func draw3D(renderEncoder: MTLRenderCommandEncoder) {
        
        /*
        recyclerShapeQuad3D.reset()
        
        
        graphics.set(depthState: .disabled, renderEncoder: renderEncoder)
        renderEncoder.setCullMode(.front)
        stars.draw3D(graphics: graphics,
                     renderEncoder: renderEncoder)
        
        graphics.set(depthState: .lessThan, renderEncoder: renderEncoder)
        renderEncoder.setCullMode(.back)
        earth.draw3D(graphics: graphics,
                     renderEncoder: renderEncoder)
        */
    }
    
    func draw2D(renderEncoder: MTLRenderCommandEncoder) {
        
        recycler.reset()
        recyclerSprite2D.reset()
        
        
        var projection = matrix_float4x4()
        projection.ortho(width: graphics.width,
                         height: graphics.height)
        
        
        
        graphics.set(pipelineState: .sprite2DAlphaBlending,
                     renderEncoder: renderEncoder)
        
        var modelView = matrix_identity_float4x4
        modelView.translate(x: graphics.width * 0.5, y: graphics.height * 0.5, z: 0.0)
        modelView.scale(2.0)
        //modelView.scale(60.0)
        
        
        recyclerSprite2D.set(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        recyclerSprite2D.draw(graphics: graphics,
                              renderEncoder: renderEncoder,
                              projection: projection,
                              modelView: modelView,
                              sprite: sprite)
        
        /*
        recyclerShapeQuad2D.reset()
        
        earth.draw2D(graphics: graphics,
                     renderEncoder: renderEncoder)
        
        dimensionBridge.drawQuads2D(recyclerShapeQuad2D: recyclerShapeQuad2D,
                                    renderEncoder: renderEncoder)
        dimensionBridge.drawLines2D(recyclerShapeQuad2D: recyclerShapeQuad2D,
                                    renderEncoder: renderEncoder)
        dimensionBridge.drawHits2D(recyclerShapeQuad2D: recyclerShapeQuad2D,
                                   renderEncoder: renderEncoder)
        
        gestureProcessor.draw2D(graphics: graphics,
                                recyclerShapeQuad2D: recyclerShapeQuad2D,
                                renderEncoder: renderEncoder)
        */
        
    }
}
