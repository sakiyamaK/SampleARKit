//
//  Router.swift
//  SampleARKit
//
//  Created by sakiyamaK on 2021/10/07.
//

import UIKit

final class Router {
    static let shared = Router()
    private init() {}

    private var window: UIWindow!

    func showRoot(window: UIWindow) {

        let vc = RootViewController.makeFromStoryboard()
        let nav = UINavigationController(rootViewController: vc)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window
    }

    func showFirst(from: UIViewController) {
        let vc = FirstViewController()
        from.show(next: vc)
    }
}
