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
        sprite.load(graphics: graphics, fileName: "LY_9109.jpg")
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
        
        var modelView = matrix_identity_float4x4
        modelView.translate(x: graphics.width * 0.25, y: graphics.height * 0.5, z: 0.0)
        modelView.rotateZ(radians: Float(ROTATEEE))
        
        graphics.set(pipelineState: .shape2DAlphaBlending,
                     renderEncoder: renderEncoder)
        
        
        
        recycler.set(red: 1.0, green: 0.0, blue: 0.25, alpha: 1.0)
        
        recycler.drawPoint(graphics: graphics,
                           renderEncoder: renderEncoder,
                           projection: projection,
                           modelView: modelView,
                           x: 0.0,
                           y: 0.0,
                           size: 120.0)
        
        
        
        
        graphics.set(pipelineState: .sprite2DAlphaBlending,
                     renderEncoder: renderEncoder)
        
        modelView = matrix_identity_float4x4
        modelView.translate(x: graphics.width * 0.75, y: graphics.height * 0.5, z: 0.0)
        modelView.rotateZ(radians: Float(ROTATEEE))
        
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
