//
//  ProcessingNode.swift
//  Macintosh
//
//  Created by Sports Dad on 10/3/23.
//

import Foundation

class ProcessingNode: Codable {
    
    static var preview: ProcessingNode {
        let result = ProcessingNode(id: 0)
        return result
    }
    
    var type = ProcessingNodeType.none
    var data = ProcessingNodeData()
    
    enum CodingKeys: String, CodingKey {
        case type, data
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = 0
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
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(data, forKey: .data)
    }
    
    var id: Int
    init(id: Int) {
        self.id = id
    }
    
    func process(rgbaImage: RGBImage) -> RGBImage {
        return data.process(rgbaImage: rgbaImage)
    }
    
    func save() -> Data {
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            return data
        } catch let error {
            print("Error encoding: \(error.localizedDescription)")
            print("Error encoding: \(self)")
            return Data()
        }
    }
    
}

extension ProcessingNode: Identifiable {
    
}
