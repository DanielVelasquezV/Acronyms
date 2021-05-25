//
//  AppDelegate.swift
//  Acronyms
//
//  Created by Daniel Velásquez on 23-05-21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = AcronymMeaningFinderViewController(viewModel: AcronymMeaningFinderViewModel())
        window?.makeKeyAndVisible()
        return true
    }
}

