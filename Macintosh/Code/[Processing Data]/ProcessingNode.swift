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
    var data = ProcessingNodeData()
    
    var id: Int
    init(id: Int) {
        self.id = id
    }
    
    func process(rgbaImage: RGBImage) -> RGBImage {
        return data.process(rgbaImage: rgbaImage)
    }
    
    
}

extension ProcessingNode: Identifiable {
    
}
