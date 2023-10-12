//
//  NSImage+CropAndFit.swift
//  Macintosh
//
//  Created by Screwy Uncle Louie on 10/11/23.
//

import Cocoa

extension NSImage {
    
    static func cropAndFit(image: NSImage, width: CGFloat, height: CGFloat) -> NSImage? {
        
        guard width > 4.0 else { return nil }
        guard height > 4.0 else { return nil }
        guard image.size.width > 4.0 else { return nil }
        guard image.size.height > 4.0 else { return nil }
        
        let size = CGSize(width: width, height: height)
        let fit = size.getAspectFill(CGSize(width: image.size.width, height: image.size.height))
        
        let x: CGFloat = CGFloat(roundf(Float(width * 0.5 - fit.size.width * 0.5)))
        let y: CGFloat = CGFloat(roundf(Float(height * 0.5 - fit.size.height * 0.5)))
        
        guard let cgContext = CGContext(data: nil,
                                        width: Int(width + 0.5),
                                        height: Int(height + 0.5),
                                        bitsPerComponent: 8,
                                        bytesPerRow: 0,
                                        space: CGColorSpaceCreateDeviceRGB(),
                                        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue), cgContext.data != nil
        else { return nil }
        
        
        //UIGraphicsBeginImageContext(CGSizeMake(width, height))
        
        //image.draw(in: CGRectMake(x, y, fit.size.width, fit.size.height))
        
        if let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) {
            
            cgContext.draw(cgImage,
                           in: CGRect(origin: CGPoint(x: x, y: y),
                                      size: CGSize(width: fit.size.width,
                                                   height: fit.size.height)))
            
            let result = NSImage(cgImage: cgImage, size: NSSize(width: width, height: height))
            
            print("original size: \(image.size.width) x \(image.size.height)")
            print("fit size: \(fit.size.width) x \(fit.size.height)")
            print("final size: \(result.size.width) x \(result.size.height)")
            
            return result
        } else {
            return nil
        }
        
        //return result
        
    }
    
}
