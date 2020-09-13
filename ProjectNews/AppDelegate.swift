//
//  AppDelegate.swift
//  ProjectNews
//
//  Created by Luu Hong Son on 9/11/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var homeCoordinator: HomeCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        homeCoordinator = HomeCoordinator(window: window)
        homeCoordinator.start()
        
        return true
    }


}

