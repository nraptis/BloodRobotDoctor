//
//  ProcessingNodeDataDilate.swift
//  Macintosh
//
//  Created by Screwy Uncle Louie on 10/5/23.
//

import Foundation

class ProcessingNodeDataDilate: ProcessingNodeData {
    
    var element = ErosionElement.ellipse
    var size: Int = 4
    
    override func process(rgbaImage: RGBImage) -> RGBImage {
        
        let _element: Int32
        switch element {
        case .rect:
            _element = 0
        case .cross:
            _element = 1
        case .ellipse:
            _element = 2
        }
        return OpenCVWrapper.dilate(rgbaImage, element: _element, size: Int32(size))
    }
}
