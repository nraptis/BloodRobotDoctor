//
//  ProcessingNodeDataGaussian.swift
//  Macintosh
//
//  Created by Sports Dad on 10/3/23.
//

import Foundation

class ProcessingNodeDataGaussian: ProcessingNodeData {
    
    var sizeX: Int = 8
    var sizeY: Int = 8
    
    var sigmaX: Float = 0.0
    var sigmaY: Float = 0.0
    
    override func process(rgbaImage: RGBImage, slice: MedicalSceneSlice) -> RGBImage {
        return OpenCVWrapper.gaussian(rgbaImage, sizeX: Int32(sizeX), sizeY: Int32(sizeY), sigmaX: sigmaX, sigmaY: sigmaY)
    }
    
    enum CodingKeys: String, CodingKey {
        case sizeX, sizeY, sigmaX, sigmaY
    }
    
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sizeX = try container.decode(Int.self, forKey: .sizeX)
        self.sizeY = try container.decode(Int.self, forKey: .sizeY)
        self.sigmaX = try container.decode(Float.self, forKey: .sigmaX)
        self.sigmaY = try container.decode(Float.self, forKey: .sigmaY)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sizeX, forKey: .sizeX)
        try container.encode(sizeY, forKey: .sizeY)
        try container.encode(sigmaX, forKey: .sigmaX)
        try container.encode(sigmaY, forKey: .sigmaY)
    }
    
}
