//
//  GenericNode.swift
//  Macintosh
//
//  Created by Sports Dad on 10/9/23.
//

import Foundation

class GenericNode: Codable, Identifiable {
    var nodeType = GenericNodeType.none
    
    enum CodingKeys: String, CodingKey {
        case nodeType
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = 0
        self.nodeType = try container.decode(GenericNodeType.self, forKey: .nodeType)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(nodeType, forKey: .nodeType)
    }
    
    var id: Int
    init(id: Int) {
        self.id = id
    }
    
    func process(rgbaImage: RGBImage, slice: MedicalSceneSlice) -> RGBImage {
        return rgbaImage.clone()
    }
}
