//
//  ProcessingNodeType.swift
//  Macintosh
//
//  Created by Sports Dad on 10/3/23.
//

import Foundation

enum LearningNodeType: String, CaseIterable, Codable {
    case none
    case mobileNet
}

extension LearningNodeType {
    var name: String {
        switch self {
        case .none:
            return "None"
        case .mobileNet:
            return "MobileNet"
        }
    }
}

extension LearningNodeType: Identifiable {
    var id: String {
        rawValue
    }
}
