//
//  ProcessingNodeDataDilate.swift
//  Macintosh
//
//  Created by Screwy Uncle Louie on 10/5/23.
//

import Foundation

class ProcessingNodeDataDilate: ProcessingNodeData {
    
    var element = DilationElement.ellipse
    var size: Int = 4
    
    override func process(rgbaImage: RGBImage) -> RGBImage {
        let elementIndex = Int32(element.index)
        return OpenCVWrapper.dilate(rgbaImage, element: elementIndex, size: Int32(size))
    }
}
