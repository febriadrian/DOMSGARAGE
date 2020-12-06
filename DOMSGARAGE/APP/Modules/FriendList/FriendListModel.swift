//
//  FriendListModel.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 18/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//  MVVM + RxSwift Templates by:  * Febri Adrian
//                                * febriadrian.dev@gmail.com
//                                * https://github.com/febriadrian

import Foundation

struct FriendModel {
    var id: Int
    var name: String
    var tools: [ToolModel]?
    var total: String = "0"

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    init(friend: DomsFriends) {
        self.id = friend.rawValue
        self.name = friend.name
    }

    init(object: FriendObject) {
        self.id = object.id
        self.name = object.name
        self.tools = object.tools.map { ToolModel(object: $0) }

        guard let tools = self.tools else { return }
        var count: Int = 0

        tools.forEach { tool in
            count += tool.current
        }

        self.total = "\(count)"
    }
}
