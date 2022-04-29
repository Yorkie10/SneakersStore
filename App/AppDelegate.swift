//
//  AppDelegate.swift
//  Sneakers
//
//  Created by Yerkebulan Sharipov on 19.04.2022.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: Onbording())
        FirebaseApp.configure()
        return true
    }
}

