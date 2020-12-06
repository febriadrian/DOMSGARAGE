//
//  Messages.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 19/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//

import Foundation

struct Messages {
    static let dataNotFound = "Data not found, please contact Admin.."
    static let unknownError = "Unknown Error.."
    static let confirm = "Confirmation"
    static let helloDom = "Hello, Dom!"
    static let yes = "Yes"
    static let nope = "No"
    static let oops = "Ooops!"
    static let noItemLeft = "There's no item left..\nAsk your friend to return some..\nHope they didn't sell them haha!"
    static let ok = "OK"
    static let success = "Success"
    static let borrowSucces = "Your friend already brought your tool home.."
    static let returnSuccess = "Thank God your friend didn't sell it haha.."

    static func borrowConfirm(_ toolName: String, _ friendName: String) -> String {
        return "Do You want to loan \(toolName) to \(friendName)?"
    }

    static func returnConfirm(_ toolName: String, _ friendName: String) -> String {
        return "Have you received \(toolName) from \(friendName)?"
    }
    
    static func notBorrower(_ friendName: String) -> String {
        return "\(friendName) is not borrowing anything from you ^_^"
    }
}
