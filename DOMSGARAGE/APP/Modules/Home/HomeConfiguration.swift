//
//  HomeConfiguration.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 18/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//  MVVM + RxSwift Templates by:  * Febri Adrian
//                                * febriadrian.dev@gmail.com
//                                * https://github.com/febriadrian

import Foundation
import UIKit

struct HomeConfiguration {
    static func setup(parameters: Parameter = [:]) -> UIViewController {
        let controller = HomeViewController()
        let router = HomeRouter(view: controller)
        let viewModel = HomeViewModel()
        let manager = HomeManager()

        viewModel.parameters = parameters
        viewModel.manager = manager
        controller.viewModel = viewModel
        controller.router = router
        return controller
    }
}
