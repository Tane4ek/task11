//
//  AppDelegate.swift
//  RSSchool_T11
//
//  Created by Татьяна Лузанова on 09.09.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rocketList = RocketListViewController()
        let navControllerRocket = UINavigationController(rootViewController: rocketList)
        navControllerRocket.tabBarItem = UITabBarItem(title: "Rockets", image: UIImage(named: "rocket"), tag: 0)
        let launchesList = LaunchesListViewController()
        let navControllerLaunch = UINavigationController(rootViewController: launchesList)
        navControllerLaunch.tabBarItem = UITabBarItem(title: "Launches", image: UIImage(named: "mixer"), tag: 1)
        let launchpadsList = LaunchpadsListViewController()
        let navControllerlaunchpadsList = UINavigationController(rootViewController: launchpadsList)
        navControllerlaunchpadsList.tabBarItem = UITabBarItem(title: "Launchpads", image: UIImage(named: "legoseriousplay"), tag: 2)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [navControllerRocket, navControllerLaunch, navControllerlaunchpadsList]

        UITabBar.appearance().tintColor = UIColor(named: "Coral")
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "White")
        UITabBar.appearance().barTintColor = UIColor(named: "Queen Blue")

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        return true
    }



}

