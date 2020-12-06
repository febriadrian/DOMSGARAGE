//
//  HomeManager.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 18/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//  MVVM + RxSwift Templates by:  * Febri Adrian
//                                * febriadrian.dev@gmail.com
//                                * https://github.com/febriadrian

import Foundation

protocol IHomeManager: class {
    func manageReturningTool(_ actionType: BorrowActionType, tool: ToolModel, withFriendId id: Int, completion: @escaping DomVoidCompletion)
}

class HomeManager: IHomeManager {
    func manageReturningTool(_ actionType: BorrowActionType, tool: ToolModel, withFriendId id: Int, completion: @escaping DomVoidCompletion) {
        DomService.share.actionIs(actionType, toolWithId: tool.id) {
            FriendService.share.actionIs(actionType, tool: tool, withFriendId: id) {
                completion()
            }
        }
    }
}
