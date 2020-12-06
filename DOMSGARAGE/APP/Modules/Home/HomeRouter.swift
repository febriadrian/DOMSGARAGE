//
//  HomeRouter.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 18/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//  MVVM + RxSwift Templates by:  * Febri Adrian
//                                * febriadrian.dev@gmail.com
//                                * https://github.com/febriadrian

import UIKit

protocol IHomeRouter: class {
    func navToFriendList(pageType: FriendListPageType, tool: ToolModel)
}

class HomeRouter: IHomeRouter {
    weak var view: HomeViewController?

    init(view: HomeViewController?) {
        self.view = view
    }

    func navToFriendList(pageType: FriendListPageType, tool: ToolModel) {
        view?.navigate(type: .presentWithNavigation, module: GeneralRoute.friendList(parameters: [
            FriendListParameterKey.pageType.rawValue: pageType,
            FriendListParameterKey.tool.rawValue: tool
        ]), completion: { controller in
            guard let _ = controller as? FriendListViewController else { return }
        })
    }
}
