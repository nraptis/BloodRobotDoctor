//
//  ProcessingNodeDataGaussian.swift
//  Macintosh
//
//  Created by Sports Dad on 10/3/23.
//

import Foundation

class ProcessingNodeDataGaussian: ProcessingNodeData {
    
    var sizeX: Int = 8
    var sizeY: Int = 8
    
    var sigmaX: Float = 0.0
    var sigmaY: Float = 0.0
    
    override func process(rgbaImage: RGBImage) -> RGBImage {
        return OpenCVWrapper.gaussian(rgbaImage, sizeX: Int32(sizeX), sizeY: Int32(sizeY), sigmaX: sigmaX, sigmaY: sigmaY)
    }
}
