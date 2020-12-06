//
//  TabBarType.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 21/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//

import UIKit

enum TabBarType: Int {
    case home = 0
    case friend = 1
}

extension TabBarType {
    var title: String {
        switch self {
        case .home:
            return "My Tools"
        default:
            return "My Friends"
        }
    }

    var image: UIImage? {
        switch self {
        case .home:
            return UIImage(named: "tab_home")
        case .friend:
            return UIImage(named: "tab_favorite")
        }
    }
}
