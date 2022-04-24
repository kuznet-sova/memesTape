//
//  AppDelegate.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 18.03.2022.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        return true
    }
    
    func setupWindow() {
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController.init(rootViewController: MainVC())
        window?.makeKeyAndVisible()
    }
    
}
