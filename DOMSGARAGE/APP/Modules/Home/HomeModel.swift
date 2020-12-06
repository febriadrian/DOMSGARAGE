//
//  HomeModel.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 18/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//  MVVM + RxSwift Templates by:  * Febri Adrian
//                                * febriadrian.dev@gmail.com
//                                * https://github.com/febriadrian

import Foundation

struct ToolModel {
    var name: String
    var id: Int
    var current: Int

    init(initialTools: InitialTools) {
        self.name = initialTools.rawValue
        self.id = initialTools.id
        self.current = initialTools.count
    }

    init(object: ToolListObject) {
        self.name = object.name
        self.id = object.id
        self.current = object.current
    }

    init(object: BorrowedToolObject) {
        self.name = object.name
        self.id = object.id
        self.current = object.current
    }
}
