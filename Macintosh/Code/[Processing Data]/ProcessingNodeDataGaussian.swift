//
//  ProcessingNodeDataGaussian.swift
//  Macintosh
//
//  Created by Sports Dad on 10/3/23.
//

import Foundation

class ProcessingNodeDataGaussian: ProcessingNodeData {
    
    var size: Int = 8
    var sigma: Float = 0.0
    
    override func process(rgbaImage: RGBImage) -> RGBImage {
        return OpenCVWrapper.gaussian(rgbaImage, size: Int32(size), sigma: sigma)
    }
}
