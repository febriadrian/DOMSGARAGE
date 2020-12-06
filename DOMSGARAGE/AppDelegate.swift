//
//  AppDelegate.swift
//  DOMSGARAGE
//
//  Created by Febri Adrian on 17/11/20.
//  Copyright © 2020 Febri Adrian. All rights reserved.
//

import RealmSwift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.setRootViewController(MainViewController(), options: .init(direction: .fade, style: .easeInOut))
        realmMigration()
        shouldSetInitialDB()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // do something
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // do something
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // do something
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // do something
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // do something
    }
}

extension AppDelegate {
    func realmMigration() {
        let config = Realm.Configuration(
            schemaVersion: 0,
            migrationBlock: { migration, oldSchemaVersion in
                print(migration)
                if oldSchemaVersion < 1 {
                    //
                } else if oldSchemaVersion < 2 {
                    //
                } else if oldSchemaVersion < 3 {
                    //
                }
        })

        Realm.Configuration.defaultConfiguration = config
    }

    func shouldSetInitialDB() {
        let key = "shouldSetInitialDB"
        let should = !UserDefaults.standard.bool(forKey: key)

        if should {
            UserDefaults.standard.set(true, forKey: key)
            DomService.share.setupInitialDatabase()
            FriendService.share.setupInitialDatabase()
        }
    }
}
