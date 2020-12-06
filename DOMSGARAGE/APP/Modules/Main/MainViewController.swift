//
//  MainViewController.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 18/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    var homeVC: HomeViewController!
    var friendVC: FriendListViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponent()
    }

    private func setupComponent() {
        homeVC = HomeConfiguration.setup() as? HomeViewController
        friendVC = FriendListConfiguration.setup() as? FriendListViewController

        homeVC.tabBarItem = tabBarItem(type: .home)
        friendVC.tabBarItem = tabBarItem(type: .friend)

        viewControllers = [homeVC, friendVC].map { UINavigationController(rootViewController: $0)
        }

        tabBar.tintColor = Colors.lightBlue
    }

    private func tabBarItem(type: TabBarType) -> UITabBarItem {
        let item = UITabBarItem(title: type.title,
                                image: type.image,
                                tag: type.rawValue)
        return item
    }
}
