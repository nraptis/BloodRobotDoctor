//
//  ProcessingNodeData.swift
//  Macintosh
//
//  Created by Sports Dad on 10/3/23.
//

import Foundation

class ProcessingNodeData: Codable {
    
    func process(rgbaImage: RGBImage) -> RGBImage {
        return rgbaImage.clone()
    }
    
    
}
