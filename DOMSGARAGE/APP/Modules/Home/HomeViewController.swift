//
//  HomeViewController.swift
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

class HomeViewController: ListViewController {
    var viewModel: IHomeViewModel!
    var router: IHomeRouter?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupComponent()
        initialSetup()
        
        DispatchQueue.main.async {
            self.setupBinding()
            self.viewModel?.setupToolList()
        }
    }

    private func initialSetup() {
        if viewModel.pageType == .friendDetail {
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

        viewModel.tools
            .bind(to: tableView.rx.items(cellIdentifier: viewModel.cellIdentifier, cellType: SomeListTableViewCell.self)) { [weak self] index, tool, cell in
                self?.cellForRow(at: index, tool: tool, cell: cell)
            }
            .disposed(by: disposeBag)

        tableView.rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.handleBorrowAction(at: indexPath.row)
            })
            .disposed(by: disposeBag)
    }

    private func cellForRow(at index: Int, tool: ToolModel, cell: SomeListTableViewCell) {
        cell.nameLabel.text = tool.name
        cell.countLabel.text = "\(tool.current)"
    }

    private func handleBorrowAction(at index: Int) {
        switch viewModel.pageType {
        case .list:
            viewModel.shouldBorrowTool(at: index) { [weak self] should, tool in
                if should {
                    self?.router?.navToFriendList(pageType: .borrowing, tool: tool)
                } else {
                    Alert.show(title: Messages.oops,
                               message: Messages.noItemLeft,
                               actionTitle: Messages.ok)
                }
            }

        case .friendDetail:
            Alert.show(title: Messages.confirm,
                       message: viewModel.confirmMessage(at: index),
                       actionTitle: Messages.yes,
                       cancelTitle: Messages.nope,
                       actionCompletion: { [weak self] in
                           guard let self = self else { return }
                           self.viewModel.returnTool(at: index) {
                               Alert.show(title: Messages.success,
                                          message: Messages.returnSuccess,
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
        viewModel.setupToolList()
    }
}
