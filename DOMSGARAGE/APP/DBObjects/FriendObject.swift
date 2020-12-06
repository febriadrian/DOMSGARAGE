//
//  FriendObject.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 21/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//

import RealmSwift

class FriendObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    let tools = List<BorrowedToolObject>()

    override class func primaryKey() -> String? {
        return "id"
    }
}
