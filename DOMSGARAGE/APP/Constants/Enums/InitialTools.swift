//
//  InitialTools.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 18/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//

import Foundation

enum InitialTools: String, CaseIterable {
    case wrench = "Wrench"
    case cutter = "Cutter"
    case pliers = "Pliers"
    case screwdriver = "Screwdriver"
    case weldingMachine = "Welding Machine"
    case weldingGlasses = "Welding Glasses"
    case hammer = "Hammer"
    case measuringTape = "Measuring Tape"
    case alanKeySet = "Alan Key Set"
    case airCompressor = "Air Compressor"
}

extension InitialTools {
    var id: Int {
        switch self {
        case .wrench:
            return 10
        case .cutter:
            return 11
        case .pliers:
            return 12
        case .screwdriver:
            return 13
        case .weldingMachine:
            return 14
        case .weldingGlasses:
            return 15
        case .hammer:
            return 16
        case .measuringTape:
            return 17
        case .alanKeySet:
            return 18
        case .airCompressor:
            return 19
        }
    }

    var count: Int {
        switch self {
        case .wrench:
            return 6
        case .cutter:
            return 15
        case .pliers:
            return 12
        case .screwdriver:
            return 13
        case .weldingMachine:
            return 3
        case .weldingGlasses:
            return 7
        case .hammer, .alanKeySet:
            return 4
        case .measuringTape:
            return 9
        case .airCompressor:
            return 2
        }
    }
}
