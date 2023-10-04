//
//  RGBImage.swift
//  BloodRobotDoctor
//
//  Created by Sports Dad on 9/30/23.
//

import Foundation
import Metal
import CoreGraphics

@objc class RGBImage: NSObject {
    
    @objc var width: Int
    @objc var height: Int
    
    var rgb: [[RGB]]
    
    @objc convenience override init() {
        self.init(rgb: [], width: 0, height: 0)
    }
    
    required init(rgb: [[RGB]], width: Int, height: Int) {
        self.width = width
        self.height = height
        self.rgb = rgb
        super.init()
    }
    
    @objc convenience init(width: Int, height: Int) {
        guard width > 0 && height > 0 else {
            self.init(rgb: [], width: 0, height: 0)
            return
        }
        var rgb = [[RGB]]()
        rgb.reserveCapacity(width)
        for _ in 0..<width {
            var column = [RGB]()
            column.reserveCapacity(height)
            for _ in 0..<height {
                column.append(RGB(red: 0, green: 0, blue: 0))
            }
            rgb.append(column)
        }
        self.init(rgb: rgb, width: width, height: height)
    }
    
    @objc convenience init(texture: MTLTexture?) {
        
        guard let texture = texture else {
            self.init(rgb: [], width: 0, height: 0)
            return
        }
        
        let width = texture.width
        let height = texture.height
        
        guard width > 0 && height > 0 else {
            self.init(rgb: [], width: 0, height: 0)
            return
        }
            
        var rgb = [[RGB]]()
        rgb.reserveCapacity(width)
        for _ in 0..<width {
            var column = [RGB]()
            column.reserveCapacity(height)
            for _ in 0..<height {
                column.append(RGB(red: 0, green: 0, blue: 0))
            }
            rgb.append(column)
        }
        
        let bytesPerPixel = 4
        let bytesPerRow = width * bytesPerPixel
        
        var data = [UInt8](repeating: 0, count: width * height * bytesPerPixel)
        
        let region = MTLRegionMake2D(0, 0, width, height)
        texture.getBytes(&data, bytesPerRow: bytesPerRow, from: region, mipmapLevel: 0)
        
        var index = 0
        var x = 0
        var y = 0
        let ceiling = (data.count - bytesPerPixel + 1)
        while index < ceiling {
            rgb[x][y].red = data[index + 2]
            rgb[x][y].green = data[index + 1]
            rgb[x][y].blue = data[index + 0]
            
            index += 4
            
            x += 1
            if x == width {
                x = 0
                y += 1
            }
        }
        
        self.init(rgb: rgb, width: width, height: height)
    }
    
    @objc func size(width: Int, height: Int) {
        if width <= 0 || height <= 0 {
            self.width = 0
            self.height = 0
            self.rgb = []
            return
        }
        
        var rgb = [[RGB]]()
        rgb.reserveCapacity(width)
        for _ in 0..<width {
            var column = [RGB]()
            column.reserveCapacity(height)
            for _ in 0..<height {
                column.append(RGB(red: 0, green: 0, blue: 0))
            }
            rgb.append(column)
        }
        
        self.rgb = rgb
        self.width = width
        self.height = height
    }
    
    @objc func set(x: Int, y: Int, red: UInt8, green: UInt8, blue: UInt8) {
        rgb[x][y].red = red
        rgb[x][y].green = green
        rgb[x][y].blue = blue
    }
    
    @objc func red(x: Int, y: Int) -> UInt8 {
        if x >= 0 && x < width && y >= 0 && y < height {
            return rgb[x][y].red
        }
        return 0
    }
    
    @objc func green(x: Int, y: Int) -> UInt8 {
        if x >= 0 && x < width && y >= 0 && y < height {
            return rgb[x][y].green
        }
        return 0
    }
    
    @objc func blue(x: Int, y: Int) -> UInt8 {
        if x >= 0 && x < width && y >= 0 && y < height {
            return rgb[x][y].blue
        }
        return 0
    }
    
    @objc func texture(device: MTLDevice?) -> MTLTexture? {
        
        guard let device = device else { return nil }
        guard width > 0 && height > 0 else { return nil }
        let bytesPerPixel = 4
        let bytesPerRow = width * bytesPerPixel
        
        var data = arrayBGRA()
        
        let textureDescriptor = MTLTextureDescriptor()
        textureDescriptor.pixelFormat = .bgra8Unorm
        textureDescriptor.width = width
        textureDescriptor.height = height
        
        guard let result = device.makeTexture(descriptor: textureDescriptor) else {
            return nil
        }
            
        let region = MTLRegionMake2D(0, 0, width, height)
            
        result.replace(region: region, mipmapLevel: 0, withBytes: &data, bytesPerRow: bytesPerRow)
        
        return result
    }
    
    func arrayBGRA() -> [UInt8] {
        guard width > 0 && height > 0 else { return [] }
        let bytesPerPixel = 4
        var result = [UInt8](repeating: 0, count: width * height * bytesPerPixel)
        for x in 0..<width {
            for y in 0..<height {
                let red = rgb[x][y].red
                let green = rgb[x][y].green
                let blue = rgb[x][y].blue
                let index = (y * width + x) << 2
                
                result[index + 0] = blue
                result[index + 1] = green
                result[index + 2] = red
                result[index + 3] = 255
            }
        }
        return result
    }
    
    func clone() -> RGBImage {
        let result = RGBImage(width: width,
                              height: height)
        var x = 0
        while x < width {
            var y = 0
            while y < height {
                let red = rgb[x][y].red
                let green = rgb[x][y].green
                let blue = rgb[x][y].blue
                result.set(x: x,
                           y: y,
                           red: red,
                           green: green,
                           blue: blue)
                y += 1
            }
            x += 1
        }
        return result
    }
}
