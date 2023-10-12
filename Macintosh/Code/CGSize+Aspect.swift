//
//  CGSize+Aspect.swift
//  Macintosh
//
//  Created by Screwy Uncle Louie on 10/11/23.
//

import Foundation

extension CGSize {
    
    // Fit the entire "image" inside this box...
    public func getAspectFit(_ size: CGSize) -> (size: CGSize, scale: CGFloat) {
        let epsilon: CGFloat = 0.1
        var result = (size: CGSize(width: width, height: height), scale: CGFloat(1.0))
        if width > epsilon && height > epsilon && size.width > epsilon && size.height > epsilon {
            if (size.width / size.height) > (width / height) {
                result.scale = width / size.width
                result.size.width = width
                result.size.height = result.scale * size.height
            } else {
                result.scale = height / size.height
                result.size.width = result.scale * size.width
                result.size.height = height
            }
        }
        return result
    }
    
    //  Fill the entire box with this "image"...
    public func getAspectFill(_ size: CGSize) -> (size: CGSize, scale: CGFloat) {
        let epsilon: CGFloat = 0.1
        var result = (size: CGSize(width: width, height: height), scale: CGFloat(1.0))
        if width > epsilon && height > epsilon && size.width > epsilon && size.height > epsilon {
            if (size.width / size.height) < (width / height) {
                result.scale = width / size.width
                result.size.width = width
                result.size.height = result.scale * size.height
            } else {
                result.scale = height / size.height
                result.size.width = result.scale * size.width
                result.size.height = height
            }
        }
        return result
    }
}
