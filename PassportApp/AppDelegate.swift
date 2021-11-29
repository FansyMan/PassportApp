//
//  AppDelegate.swift
//  PassportApp
//
//  Created by Surgeont on 22.11.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = AddInfoViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

