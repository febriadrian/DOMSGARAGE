//
//  Ext+Realm+Results.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 18/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//

import RealmSwift

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0..<count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}
