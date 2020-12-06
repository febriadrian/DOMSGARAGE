//
//  HomeViewModel.swift
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

protocol IHomeViewModel: class {
    var parameters: Parameter? { get }
    var pageType: HomePageType { get }
    var tools: PublishSubject<[ToolModel]> { get }
    var result: PublishSubject<FetchResult> { get }
    var cellIdentifier: String { get set }

    func setupComponent()
    func setupToolList()
    func observeRealmNotification()
    func shouldBorrowTool(at index: Int, completion: @escaping (_ should: Bool, _ tool: ToolModel) -> Void)
    func returnTool(at index: Int, completion: @escaping DomVoidCompletion)
    func confirmMessage(at index: Int) -> String
}

class HomeViewModel: IHomeViewModel {
    var manager: IHomeManager?
    var parameters: Parameter?
    var pageType: HomePageType = .list
    var tools: PublishSubject<[ToolModel]> = PublishSubject()
    var result: PublishSubject<FetchResult> = PublishSubject()
    var list: [ToolModel] = []
    var friend: FriendModel?
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
        pageType = setValueFromParameter(withKey: .pageType) as? HomePageType ?? .list
        friend = setValueFromParameter(withKey: .friend) as? FriendModel

        observeRealmNotification()
    }

    // set value from a parameter with defined key
    func setValueFromParameter(withKey key: HomeParameterKey) -> Any? {
        return parameters?[key.rawValue]
    }

    // setup tool list
    func setupToolList() {
        switch pageType {
        case .list:
            list = DomService.share.list()

        case .friendDetail:
            list = friend?.tools ?? []
        }

        if list.count > 0 {
            result.onNext(.success)
            tools.onNext(list)
        } else {
            result.onNext(.failure(Messages.dataNotFound))
        }
    }

    // check if there is still could be borrowed
    func shouldBorrowTool(at index: Int, completion: @escaping (_ should: Bool, _ tool: ToolModel) -> Void) {
        let item = tool(at: index)
        completion(item.current > 0, item)
    }

    // handle tool returning process
    func returnTool(at index: Int, completion: @escaping DomVoidCompletion) {
        guard let id = friend?.id else { return }
        let item = tool(at: index)

        manager?.manageReturningTool(.returning, tool: item, withFriendId: id) {
            completion()
        }
    }

    // create message to confirm borrowing a tool
    func confirmMessage(at index: Int) -> String {
        let toolName = tool(at: index).name
        let friendName = friend?.name ?? ""
        return Messages.returnConfirm(toolName, friendName)
    }

    // get a tool data
    func tool(at index: Int) -> ToolModel {
        return list[index]
    }

    // will be fired whenever database changed or refresh is required
    func observeRealmNotification() {
        notificationToken = realm?.observe { [weak self] notification, _ in
            switch notification {
            case .didChange:
                TRACER("HomeViewModel | realm notified: .didChange")
            case .refreshRequired:
                TRACER("HomeViewModel | realm notified: .refreshRequired")
            }

            self?.setupToolList()
        }
    }
}
