//
//  ProcessingNodeDataGray.swift
//  Macintosh
//
//  Created by Sports Dad on 10/5/23.
//

import Foundation

class ProcessingNodeDataGray: ProcessingNodeData {
    
    override func process(rgbaImage: RGBImage, slice: MedicalSceneSlice) -> RGBImage {
        return OpenCVWrapper.gray(rgbaImage)
    }
}
