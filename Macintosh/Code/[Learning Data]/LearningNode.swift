//
//  ProcessingNode.swift
//  Macintosh
//
//  Created by Sports Dad on 10/3/23.
//

import Foundation

class LearningNode: GenericNode {
    
    static var preview: LearningNode {
        let result = LearningNode()
        return result
    }
    
    var type = LearningNodeType.none
    var data = LearningNodeData()
    
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
        self.type = try container.decode(LearningNodeType.self, forKey: .type)
        switch self.type {
        case .none:
            self.data = try container.decode(LearningNodeData.self, forKey: .data)
        case .mobileNet:
            self.data = try container.decode(LearningNodeDataMobileNet.self, forKey: .data)
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

