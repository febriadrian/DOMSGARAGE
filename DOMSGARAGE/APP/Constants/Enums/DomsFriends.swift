//
//  DomsFriends.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 18/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//

import Foundation

enum DomsFriends: Int, CaseIterable {
    case brian = 90
    case luke = 91
    case letty = 92
    case shaw = 93
    case parker = 94
}

extension DomsFriends {
    var name: String {
        switch self {
        case .brian:
            return "Brian"
        case .luke:
            return "Luke"
        case .letty:
            return "Letty"
        case .shaw:
            return "Shaw"
        case .parker:
            return "Parker"
        }
    }
}
