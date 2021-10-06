//
//  AppDelegate.swift
//  SampleARKit
//
//  Created by sakiyamaK on 2020/10/03.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        Router.shared.showRoot(window: .init(frame: UIScreen.main.bounds))
        return true
    }
}

