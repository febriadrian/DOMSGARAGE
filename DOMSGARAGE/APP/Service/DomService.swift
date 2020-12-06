//
//  DomService.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 21/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//

import Foundation
import RealmSwift

class DomService: DBService {
    static let share = DomService()
    private var object = ToolListObject()

    func setupInitialDatabase() {
        guard load(object).count == 0 else { return }
        let tools = InitialTools.allCases.map { ToolModel(initialTools: $0) }

        tools.forEach { tool in
            let object = ToolListObject()
            object.name = tool.name
            object.id = tool.id
            object.current = tool.current

            saveObject(object)
        }
    }

    func list() -> [ToolModel] {
        var tools = load(object).map { ToolModel(object: $0) }
        tools.sort(by: { $0.name < $1.name })
        return tools
    }

    func actionIs(_ actionType: BorrowActionType, toolWithId id: Int, completion: @escaping DomVoidCompletion) {
        let filter = "(id = \(id))"
        guard let object = load(object, filteredBy: filter).first else { return }

        switch actionType {
        case .borrowing:
            guard object.current > 0 else { return }
            saveObject(object) {
                object.current -= 1
            }

        case .returning:
            saveObject(object) {
                object.current += 1
            }
        }

        completion()
    }
}
