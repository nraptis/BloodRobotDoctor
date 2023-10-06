//
//  ProcessingNodeDataErode.swift
//  Macintosh
//
//  Created by Screwy Uncle Louie on 10/5/23.
//

import Foundation

class ProcessingNodeDataErode: ProcessingNodeData {
    
    var element = ErosionElement.cross
    var size: Int = 4
    
    override func process(rgbaImage: RGBImage) -> RGBImage {
        let elementIndex = Int32(element.index)
        return OpenCVWrapper.erode(rgbaImage, element: elementIndex, size: Int32(size))
    }
}
