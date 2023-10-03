//
//  ProcessingNode.swift
//  Macintosh
//
//  Created by Sports Dad on 10/3/23.
//

import Foundation

class ProcessingNode {
    
    static var preview: ProcessingNode {
        let result = ProcessingNode(id: 0)
        return result
    }
    
    var type = ProcessingNodeType.none
    
    var id: Int
    init(id: Int) {
        self.id = id
    }
    
    func process(rgbaImage: RGBImage) -> RGBImage {
        let result = RGBImage(width: rgbaImage.width,
                              height: rgbaImage.height)
        return result
    }
    
}

extension ProcessingNode: Identifiable {
    
}
