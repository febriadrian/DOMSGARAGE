//
//  DBService.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 20/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//

import Foundation
import RealmSwift

enum FetchResult {
    case success
    case failure(String)
}

class DBService {
    private var realm: Realm?

    init() {
        do {
            self.realm = try Realm()
        } catch {
            TRACER(error.localizedDescription)
        }
    }

    func saveObject(_ object: Object, otherTasks: (DomVoidCompletion)? = nil) {
        do {
            try realm?.write {
                otherTasks?()
                realm?.add(object, update: .all)
            }
        } catch {
            TRACER(error.localizedDescription)
        }
    }

    func deleteObject(_ object: Object, otherTasks: (DomVoidCompletion)? = nil) {
        do {
            try realm?.write {
                otherTasks?()
                realm?.delete(object)
            }
        } catch {
            TRACER(error.localizedDescription)
        }
    }

    func load<T: Object>(_ object: T) -> [T] {
        if let results = realm?.objects(T.self).toArray(ofType: T.self) {
            return results as [T]
        }
        return []
    }

    func load<T: Object>(_ object: T, filteredBy filter: String) -> [T] {
        if !filter.isEmpty {
            if let results = realm?.objects(T.self).filter(filter).toArray(ofType: T.self) {
                return results as [T]
            }
        }
        return []
    }
}

public func TRACER(_ data: String? = nil) {
    var separator: String {
        var s = ""
        for _ in 0...69 {
            s.append("=")
        }
        return s
    }

    let trace = """
    \(separator)
    
    \(data == nil ? "NO RESULT" : data!)
    
    \(separator)
    """

    print(trace)
}
