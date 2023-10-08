//
//  DilationElement.swift
//  Macintosh
//
//  Created by Screwy Uncle Louie on 10/4/23.
//

import Foundation

enum DilationElement: String {
    case rect // 0
    case cross // 1
    case ellipse // 2
}

extension DilationElement: Identifiable {
    var id: Int {
        switch self {
        case .rect:
            return 0
        case .cross:
            return 1
        case .ellipse:
            return 2
        }
    }
}

extension DilationElement: Codable {
    
}

extension DilationElement {
    var index: Int {
        return id
    }
}

extension DilationElement: Hashable {
    
}

extension DilationElement: CustomStringConvertible {
    var description: String {
        switch self {
        case .rect:
            return "rect"
        case .cross:
            return "cross"
        case .ellipse:
            return "ellipse"
        }
    }
}
