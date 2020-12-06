//
//  FriendListRouter.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 18/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//  MVVM + RxSwift Templates by:  * Febri Adrian
//                                * febriadrian.dev@gmail.com
//                                * https://github.com/febriadrian

import UIKit

protocol IFriendListRouter: class {
    func navToHome(pageType: HomePageType, friend: FriendModel)
}

class FriendListRouter: IFriendListRouter {
    weak var view: FriendListViewController?

    init(view: FriendListViewController?) {
        self.view = view
    }

    func navToHome(pageType: HomePageType, friend: FriendModel) {
        view?.navigate(type: .presentWithNavigation, module: GeneralRoute.home(parameters: [
            HomeParameterKey.pageType.rawValue: pageType,
            HomeParameterKey.friend.rawValue: friend
        ]), completion: { controller in
            guard let _ = controller as? HomeViewController else { return }
        })
    }
}
