//
//  FriendListPageType.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 21/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//

import Foundation

enum FriendListPageType: String {
    case list = "My Friends"
    case borrowing = "Borrowing"
}

enum FriendListParameterKey: String {
    case pageType
    case tool
}
