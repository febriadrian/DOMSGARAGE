//
//  ListViewController.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 22/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class ListViewController: UIViewController {
    convenience init() {
        self.init(nibName: "ListViewController", bundle: nil)
    }

    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    var disposeBag: DisposeBag!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponent()
    }

    func setupComponent() {
        disposeBag = DisposeBag()

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(startRefreshing), for: .valueChanged)

        tableView.refreshControl = refreshControl
    }

    func registerTableViewCell(completion: @escaping (_ cellId: String) -> Void) {
        tableView.registerCellType(SomeListTableViewCell.self) { identifier in
            completion(identifier)
        }
    }

    func handleFetchResult(_ result: FetchResult) {
        switch result {
        case .success:
            refreshControl.endRefreshing()
        case .failure(let message):
            TRACER(message)
        }
    }

    @objc func handleDismiss() {
        dismiss()
    }

    @objc func startRefreshing() {
        // do something
    }
}
