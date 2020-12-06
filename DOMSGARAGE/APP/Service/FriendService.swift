//
//  FriendService.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 21/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//

import Foundation
import RealmSwift

class FriendService: DBService {
    static let share = FriendService()
    private var object = FriendObject()

    func setupInitialDatabase() {
        guard load(object).count == 0 else { return }
        let friends = DomsFriends.allCases.map { FriendModel(friend: $0) }

        friends.forEach { friend in
            let object = FriendObject()
            object.name = friend.name
            object.id = friend.id

            if let tools = friend.tools, tools.count > 0 {
                tools.forEach { tool in
                    let toolObject = BorrowedToolObject()
                    toolObject.name = tool.name
                    toolObject.id = tool.id
                    toolObject.transactionId = friend.id
                    toolObject.current = tool.current

                    object.tools.append(toolObject)
                }
            }

            saveObject(object)
        }
    }

    func list() -> [FriendModel] {
        return load(object).map { FriendModel(object: $0) }
    }

    func actionIs(_ actionType: BorrowActionType, tool: ToolModel, withFriendId id: Int, completion: @escaping DomVoidCompletion) {
        let filter = "(id = \(id))"
        guard let object = load(object, filteredBy: filter).first else { return }

        if object.tools.count == 0 {
            saveToolObject(object: object, tool: tool) {
                completion()
            }
        } else {
            for item in object.tools {
                let transactionId = uniqueId(object.id, tool.id)

                if item.transactionId != transactionId {
                    if item != object.tools.last {
                        continue
                    } else {
                        saveToolObject(object: object, tool: tool) {
                            completion()
                        }
                    }
                } else {
                    switch actionType {
                    case .borrowing:
                        saveObject(object) {
                            item.current += 1
                        }

                    case .returning:
                        guard item.current > 0 else { return }
                        saveObject(object) {
                            item.current -= 1
                        }

                        if item.current == 0 {
                            deleteObject(item)
                        }
                    }

                    completion()
                    return
                }
            }
        }
    }

    func saveToolObject(object: FriendObject, tool: ToolModel, completion: @escaping DomVoidCompletion) {
        let toolObject = BorrowedToolObject()
        toolObject.name = tool.name
        toolObject.id = tool.id
        toolObject.transactionId = uniqueId(object.id, tool.id)
        toolObject.current = 1

        saveObject(object) {
            object.tools.append(toolObject)
        }

        completion()
    }

    private func uniqueId(_ friendId: Int, _ toolId: Int) -> Int {
        let string = "\(friendId)\(toolId)"
        return Int(string)!
    }
}
