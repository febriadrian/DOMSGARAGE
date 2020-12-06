//
//  GeneralRoute.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 18/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//  MVVM + RxSwift Templates by:  * Febri Adrian
//                                * febriadrian.dev@gmail.com
//                                * https://github.com/febriadrian

import Foundation
import UIKit

enum GeneralRoute {
    case home(parameters: Parameter)
    case friendList(parameters: Parameter)
}

extension GeneralRoute: IRouter {
    var module: UIViewController? {
        switch self {
        case .home(let parameters):
            return HomeConfiguration.setup(parameters: parameters)
        case .friendList(let parameters):
            return FriendListConfiguration.setup(parameters: parameters)
        }
    }
}
