//
//  FriendListViewController.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 18/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//  MVVM + RxSwift Templates by:  * Febri Adrian
//                                * febriadrian.dev@gmail.com
//                                * https://github.com/febriadrian

import RxCocoa
import RxSwift
import UIKit

class FriendListViewController: ListViewController {
    var viewModel: IFriendListViewModel!
    var router: IFriendListRouter?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupComponent()
        initialSetup()

        DispatchQueue.main.async {
            self.setupBinding()
            self.viewModel.setupFriendList()
        }
    }

    private func initialSetup() {
        if viewModel.pageType == .borrowing {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismiss))
        }

        title = viewModel.pageType.rawValue

        registerTableViewCell { identifier in
            self.viewModel.cellIdentifier = identifier
        }
    }

    private func setupBinding() {
        viewModel.result
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                self?.handleFetchResult(result)
            })
            .disposed(by: disposeBag)

        viewModel?.friendList
            .bind(to: tableView.rx.items(cellIdentifier: viewModel.cellIdentifier, cellType: SomeListTableViewCell.self)) { [weak self] index, friend, cell in
                self?.cellForRow(at: index, friend: friend, cell: cell)
            }
            .disposed(by: disposeBag)

        tableView.rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.didSelectCell(at: indexPath.row)
            })
            .disposed(by: disposeBag)
    }

    private func cellForRow(at index: Int, friend: FriendModel, cell: SomeListTableViewCell) {
        cell.nameLabel.text = friend.name

        switch viewModel.pageType {
        case .list:
            cell.countLabel.text = viewModel.totalCount(at: index)
            cell.countLabel.isHidden = false
        case .borrowing:
            cell.countLabel.isHidden = true
        }
    }

    private func didSelectCell(at index: Int) {
        switch viewModel.pageType {
        case .list:
            viewModel.shouldShowDetail(at: index) { [weak self] should, friend in
                if should {
                    self?.router?.navToHome(pageType: .friendDetail, friend: friend)
                } else {
                    Alert.show(title: Messages.helloDom,
                               message: Messages.notBorrower(friend.name),
                               actionTitle: Messages.ok)
                }
            }

        case .borrowing:
            Alert.show(title: Messages.confirm,
                       message: viewModel.confirmMessage(at: index),
                       actionTitle: Messages.yes,
                       cancelTitle: Messages.nope,
                       actionCompletion: { [weak self] in
                           guard let self = self else { return }
                           self.viewModel.borrow(at: index) {
                               Alert.show(title: Messages.success,
                                          message: Messages.borrowSucces,
                                          actionTitle: Messages.ok,
                                          actionCompletion: {
                                              self.dismiss()
                               })
                           }
            })
        }
    }

    @objc override func startRefreshing() {
        super.startRefreshing()
        viewModel.setupFriendList()
    }
}
