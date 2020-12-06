//
//  ToolListObject.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 21/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//

import RealmSwift

class ToolListObject: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var current: Int = 0

    override class func primaryKey() -> String? {
        return "id"
    }
}
