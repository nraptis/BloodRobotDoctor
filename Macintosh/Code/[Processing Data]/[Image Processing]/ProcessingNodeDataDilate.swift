//
//  ProcessingNodeDataDilate.swift
//  Macintosh
//
//  Created by Sports Dad on 10/5/23.
//

import Foundation

class ProcessingNodeDataDilate: ProcessingNodeData {
    
    var element = DilationElement.ellipse
    var size: Int = 4
    
    override func process(rgbaImage: RGBImage, slice: MedicalSceneSlice) -> RGBImage {
        let elementIndex = Int32(element.index)
        return OpenCVWrapper.dilate(rgbaImage, element: elementIndex, size: Int32(size))
    }
    
    enum CodingKeys: String, CodingKey {
        case element, size
    }
    
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.element = try container.decode(DilationElement.self, forKey: .element)
        self.size = try container.decode(Int.self, forKey: .size)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(element, forKey: .element)
        try container.encode(size, forKey: .size)
    }
}
