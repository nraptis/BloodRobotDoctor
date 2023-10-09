//
//  ProcessingNode.swift
//  Macintosh
//
//  Created by Sports Dad on 10/3/23.
//

import Foundation

class ProcessingNode: GenericNode {
    
    static var preview: ProcessingNode {
        let result = ProcessingNode()
        return result
    }
    
    var type = ProcessingNodeType.none
    var data = ProcessingNodeData()
    
    enum CodingKeys: String, CodingKey {
        case type, data
    }
    
    init() {
        super.init(id: 0)
    }
    
    override init(id: Int) {
        super.init(id: id)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(ProcessingNodeType.self, forKey: .type)
        switch self.type {
            
        case .none:
            self.data = try container.decode(ProcessingNodeData.self, forKey: .data)
        case .gray:
            self.data = try container.decode(ProcessingNodeDataGray.self, forKey: .data)
        case .gauss:
            self.data = try container.decode(ProcessingNodeDataGaussian.self, forKey: .data)
        case .erosion:
            self.data = try container.decode(ProcessingNodeDataErode.self, forKey: .data)
        case .dilation:
            self.data = try container.decode(ProcessingNodeDataDilate.self, forKey: .data)
        }
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(data, forKey: .data)
        try super.encode(to: encoder)
    }
    
    override func process(rgbaImage: RGBImage, slice: MedicalSceneSlice) -> RGBImage {
        return data.process(rgbaImage: rgbaImage, slice: slice)
    }
}
