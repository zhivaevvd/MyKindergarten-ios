//
//  AppDelegate.swift
//  MyKindergarten
//
//  Created by Headdds and hands on 17.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = AuthVC()
        window?.makeKeyAndVisible()
        return true
    }
}

