//
//  FriendListViewModel.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 18/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//  MVVM + RxSwift Templates by:  * Febri Adrian
//                                * febriadrian.dev@gmail.com
//                                * https://github.com/febriadrian

import Foundation
import RealmSwift
import RxCocoa
import RxSwift

protocol IFriendListViewModel: class {
    var parameters: Parameter? { get }
    var pageType: FriendListPageType { get }
    var friendList: PublishSubject<[FriendModel]> { get }
    var result: PublishSubject<FetchResult> { get }
    var cellIdentifier: String { get set }

    func setupComponent()
    func setupFriendList()
    func borrow(at index: Int, completion: @escaping DomVoidCompletion)
    func shouldShowDetail(at index: Int, completion: @escaping (_ should: Bool, _ friend: FriendModel) -> Void)
    func totalCount(at index: Int) -> String
    func confirmMessage(at index: Int) -> String
}

class FriendListViewModel: IFriendListViewModel {
    var manager: IFriendListManager?
    var parameters: Parameter?
    var pageType: FriendListPageType = .list
    var friendList: PublishSubject<[FriendModel]> = PublishSubject()
    var result: PublishSubject<FetchResult> = PublishSubject()
    var list: [FriendModel] = []
    var tool: ToolModel?
    var realm: Realm?
    var notificationToken: NotificationToken?
    var cellIdentifier: String = ""

    init() {
        do {
            self.realm = try Realm()
        } catch {
            TRACER(error.localizedDescription)
        }
    }

    deinit {
        notificationToken?.invalidate()
    }

    // setup initial state for viewModel
    func setupComponent() {
        pageType = setValueFromParameter(withKey: .pageType) as? FriendListPageType ?? .list
        tool = setValueFromParameter(withKey: .tool) as? ToolModel

        observeRealmNotification()
    }

    // set value from a parameter with defined key
    func setValueFromParameter(withKey key: FriendListParameterKey) -> Any? {
        return parameters?[key.rawValue]
    }

    // setup friend list
    func setupFriendList() {
        list = FriendService.share.list()

        if list.count > 0 {
            result.onNext(.success)
            friendList.onNext(list)
        } else {
            result.onNext(.failure(Messages.dataNotFound))
        }
    }

    // handle tool borrowing process
    func borrow(at index: Int, completion: @escaping DomVoidCompletion) {
        guard let tool = tool else { return }
        let id = friend(at: index).id

        manager?.manageBorrowingTool(.borrowing, tool: tool, withFriendId: id) {
            completion()
        }
    }

    // check if your friend has some items borrowed
    func shouldShowDetail(at index: Int, completion: @escaping (_ should: Bool, _ friend: FriendModel) -> Void) {
        let borrower = friend(at: index)
        guard let total = Int(borrower.total) else { return }

        completion(total > 0, borrower)
    }

    // get total count of borrowed items
    func totalCount(at index: Int) -> String {
        return list[index].total
    }

    // create message to confirm returning a tool
    func confirmMessage(at index: Int) -> String {
        let friendName = friend(at: index).name
        let toolName = tool?.name ?? ""
        return Messages.borrowConfirm(toolName, friendName)
    }

    // get a friend data
    func friend(at index: Int) -> FriendModel {
        return list[index]
    }

    // will be fired whenever database changed or refresh is required
    func observeRealmNotification() {
        guard pageType == .list else { return }

        notificationToken = realm?.observe { [weak self] notification, _ in
            switch notification {
            case .didChange:
                TRACER("FriendListViewModel | realm notified: .didChange")
            case .refreshRequired:
                TRACER("FriendListViewModel | realm notified: .refreshRequired")
            }

            self?.setupFriendList()
        }
    }
}
