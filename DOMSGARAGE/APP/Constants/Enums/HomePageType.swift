//
//  HomePageType.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 21/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//

import Foundation

enum HomePageType: String {
    case list = "My Tools"
    case friendDetail = "Borrowed Tools"
}

enum HomeParameterKey: String {
    case pageType
    case friend
}
