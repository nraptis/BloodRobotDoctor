//
//  CGImage+CropAndFit.swift
//  Macintosh
//
//  Created by Screwy Uncle Louie on 10/12/23.
//

import CoreGraphics

extension CGImage {
    
    /*
    func createBlankImage(width: Int, height: Int) -> CGImage? {
        if let colorSpace = CGColorSpace(name: CGColorSpace.sRGB),
            let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bitsPerPixel: 32, bytesPerRow: 4 * width, space: colorSpace, bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue) {
            
            // Fill the context with a blank (transparent) background
            context.clear(CGRect(x: 0, y: 0, width: width, height: height))
            
            // Get the resulting image from the context
            return context.makeImage()
        }
        
        return nil
    }
    */
    
    static func cropAndFit(image source: CGImage, width: Int, height: Int) -> CGImage? {
        
        guard width > 4 else { return nil }
        guard height > 4 else { return nil }
        guard source.width > 4 else { return nil }
        guard source.height > 4 else { return nil }
        
        let size = CGSize(width: width, height: height)
        let fit = size.getAspectFill(CGSize(width: source.width, height: source.height))
        
        let widthf = CGFloat(width)
        let heightf = CGFloat(height)
        
        let x: CGFloat = CGFloat(roundf(Float(widthf * 0.5 - fit.size.width * 0.5)))
        let y: CGFloat = CGFloat(roundf(Float(heightf * 0.5 - fit.size.height * 0.5)))
        
        guard let cgContext = CGContext(data: nil,
                                        width: width,
                                        height: height,
                                        bitsPerComponent: 8,
                                        bytesPerRow: 0,
                                        space: CGColorSpaceCreateDeviceRGB(),
                                        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue), cgContext.data != nil
        else { return nil }
        
        
        
        
        //UIGraphicsBeginImageContext(CGSizeMake(width, height))
        
        //image.draw(in: CGRectMake(x, y, fit.size.width, fit.size.height))
        
        cgContext.draw(source,
                       
                                    in: CGRect(origin: CGPoint(x: x, y: y),
                                  size: CGSize(width: fit.size.width, height: fit.size.height)))
        
        guard let destination = cgContext.makeImage() else {
            print("unable to make destination")
            return nil
        }
        
        print("original size: \(source.width) x \(source.height)")
        print("fit size: \(fit.size.width) x \(fit.size.height)")
        print("final size: \(destination.width) x \(destination.height)")
        
        return destination
        
        //return result
        
    }
    
    
}
