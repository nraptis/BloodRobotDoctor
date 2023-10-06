//
//  ErosionElement.swift
//  Macintosh
//
//  Created by Screwy Uncle Louie on 10/4/23.
//

import Foundation

enum ErosionElement: Int {
    case rect // 0
    case cross // 1
    case ellipse // 2
}

extension ErosionElement: Identifiable {
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

extension ErosionElement: Hashable {
    
}

extension ErosionElement: CustomStringConvertible {
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
