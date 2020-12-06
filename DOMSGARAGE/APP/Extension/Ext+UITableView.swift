//
//  Ext+UITableView.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 18/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//

import UIKit

extension UITableView {
    func registerCellType<T>(_ cellClass: T.Type, completion: @escaping (_ identifier: String) -> Void) where T: AnyObject {
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 80

        let identifier = "\(cellClass)"
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        completion(identifier)
    }

    func dequeueReusableCell<T>(_ cellClass: T.Type, for indexPath: IndexPath) -> T where T: AnyObject {
        let identifier = "\(cellClass)"
        if let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T {
            return cell
        }

        fatalError("Error dequeueing cell")
    }
}
