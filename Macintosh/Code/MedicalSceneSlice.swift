//
//  MedicalSceneSlice.swift
//  Macintosh
//
//  Created by Sports Dad on 10/2/23.
//

import Foundation
import Metal
import simd

class MedicalSceneSlice {
    
    let recyclerSprite2D = RecyclerSprite2D()
    
    let graphics: Graphics
    var x: Float
    var y: Float
    var width: Float
    var height: Float
    var image: RGBImage
    var imageProcessed: RGBImage
    let sprite = Sprite2D()
    
    init(graphics: Graphics, x: Float, y: Float, width: Float, height: Float, image: RGBImage) {
        self.graphics = graphics
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.image = image
        
        self.imageProcessed = RGBImage(width: image.width,
                                       height: image.height)
        if let texture = image.texture(device: graphics.device) {
            sprite.load(graphics: graphics, texture: texture)
        }
    }
    
    func draw2D(renderEncoder: MTLRenderCommandEncoder) {
        
        recyclerSprite2D.reset()
        
        var projection = matrix_float4x4()
        projection.ortho(width: graphics.width,
                         height: graphics.height)
        
        graphics.set(pipelineState: .sprite2DAlphaBlending,
                     renderEncoder: renderEncoder)
        
        var modelView = matrix_identity_float4x4
        modelView.translate(x: x + width * 0.5, y: y + height * 0.5, z: 0.0)
        
        //modelView.scale(60.0)
        
        
        recyclerSprite2D.set(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        recyclerSprite2D.draw(graphics: graphics,
                              renderEncoder: renderEncoder,
                              projection: projection,
                              modelView: modelView,
                              sprite: sprite)
    }
    
    func stampProcessedImageToTexture() {
        
        
        if let texture = sprite.texture {
            
            //graphics.
            sprite.load(graphics: graphics, texture: texture)
        }
        
    }
    
    func jax() {
     
        if let ggg = OpenCVWrapper.gaussian(image, size: 20, sigma: 0.0) {
            
            if let texture = ggg.texture(device: graphics.device) {
                sprite.load(graphics: graphics, texture: texture)
            }
            
        }
        
    }
    
}
