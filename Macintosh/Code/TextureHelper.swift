//
//  MTLTexture+CGImage.swift
//  Macintosh
//
//  Created by Screwy Uncle Louie on 10/12/23.
//

import Foundation
import Metal
import CoreImage

class TextureHelper {
    
    static func cgImage(from metalTexture: MTLTexture?, engine: MetalEngine) -> CGImage? {
        
        guard let metalTexture = metalTexture else {
            print("metal texture was nil")
            return nil
        }
        
        // Ensure the Metal texture is in a format that's readable by the CPU
        //let format = MTLPixelFormat.bgra8Unorm
        //guard metalTexture.pixelFormat == format else {
        //    return nil
        //}
        
        // Create a buffer to read the texture data
        let bytesPerPixel = 4
        let width = metalTexture.width
        let height = metalTexture.height
        let dataSize = width * height * bytesPerPixel // 4 bytes per pixel for BGRA8
        guard let buffer = engine.device.makeBuffer(length: dataSize, options: []) else {
            print("could not create buffer")
            return nil
        }
        
        // Create a command buffer and blit encoder
        if let commandBuffer = engine.commandQueue.makeCommandBuffer(),
            let blitEncoder = commandBuffer.makeBlitCommandEncoder() {
            // Use the blit encoder to copy texture data to the buffer
            blitEncoder.copy(from: metalTexture,
                             sourceSlice: 0,
                             sourceLevel: 0,
                             sourceOrigin: MTLOriginMake(0, 0, 0),
                             sourceSize: MTLSizeMake(width, height, metalTexture.depth),
                             to: buffer,
                             destinationOffset: 0,
                             destinationBytesPerRow: width * bytesPerPixel,
                             destinationBytesPerImage: dataSize)
            blitEncoder.endEncoding()
            
            // Commit the command buffer and wait for it to complete
            commandBuffer.commit()
            commandBuffer.waitUntilCompleted()
        }
        
        // Create a CGImage from the buffer
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let context = CGContext(data: buffer.contents(),
                                      width: width,
                                      height: height,
                                      bitsPerComponent: 8,
                                      bytesPerRow: width * bytesPerPixel,
                                      space: colorSpace,
                                      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            return nil
        }
        
        return context.makeImage()
    }
    
    
}

