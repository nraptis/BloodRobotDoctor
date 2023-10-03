//
//  ProcessingStep.swift
//  Macintosh
//
//  Created by Screwy Uncle Louie on 10/2/23.
//

import Foundation

class ProcessingStep {
    
    func process(rgbaImage: RGBImage) -> RGBImage {
        let result = RGBImage(width: rgbaImage.width,
                              height: rgbaImage.height)
        return result
    }
    
}
