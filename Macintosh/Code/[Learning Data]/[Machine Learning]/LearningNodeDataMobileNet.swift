//
//  ProcessingNodeDataGaussian.swift
//  Macintosh
//
//  Created by Sports Dad on 10/3/23.
//

import Foundation

class LearningNodeDataMobileNet: LearningNodeData {
    
    var junq: Int = 8
    
    override func process(rgbaImage: RGBImage, slice: MedicalSceneSlice) -> RGBImage {
        return rgbaImage.clone()
    }
    
    enum CodingKeys: String, CodingKey {
        case junq
    }
    
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.junq = try container.decode(Int.self, forKey: .junq)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(junq, forKey: .junq)
    }
    
}
