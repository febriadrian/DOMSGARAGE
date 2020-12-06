//
//  Alert.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 20/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//

import UIKit

struct Alert {
    static func show(title: String, message: String, actionTitle: String, cancelTitle: String? = nil, actionCompletion: (DomVoidCompletion)? = nil, cancelCompletion: (DomVoidCompletion)? = nil) {
        guard let vc = UIApplication.shared.topMostViewController() else { return }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        if let cancelTitle = cancelTitle {
            let cancel = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
                cancelCompletion?()
            }

            alert.addAction(cancel)
        }

        let action = UIAlertAction(title: actionTitle, style: .default) { _ in
            actionCompletion?()
        }

        alert.addAction(action)

        vc.present(alert, animated: true, completion: nil)
    }
}
