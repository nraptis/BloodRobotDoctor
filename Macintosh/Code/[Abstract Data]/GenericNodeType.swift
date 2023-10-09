//
//  GenericNodeType.swift
//  Macintosh
//
//  Created by Screwy Uncle Louie on 10/9/23.
//

import Foundation

enum GenericNodeType: String, CaseIterable, Codable {
    case none
    case processing
    case learning
}

extension GenericNodeType {
    var name: String {
        switch self {
        case .none:
            return "None"
        case .processing:
            return "Processing"
        case .learning:
            return "Learning"
        }
    }
}

extension GenericNodeType: Identifiable {
    var id: String {
        rawValue
    }
}
