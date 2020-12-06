//
//  FriendListManager.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 18/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//  MVVM + RxSwift Templates by:  * Febri Adrian
//                                * febriadrian.dev@gmail.com
//                                * https://github.com/febriadrian

import Foundation

protocol IFriendListManager: class {
    func manageBorrowingTool(_ actionType: BorrowActionType, tool: ToolModel, withFriendId id: Int, completion: @escaping DomVoidCompletion)
}

class FriendListManager: IFriendListManager {
    func manageBorrowingTool(_ actionType: BorrowActionType, tool: ToolModel, withFriendId id: Int, completion: @escaping DomVoidCompletion) {
        FriendService.share.actionIs(actionType, tool: tool, withFriendId: id) {
            DomService.share.actionIs(actionType, toolWithId: tool.id) {
                completion()
            }
        }
    }
}
