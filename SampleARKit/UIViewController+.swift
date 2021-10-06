//
//  UIViewController+.swift
//  SampleARKit
//
//  Created by sakiyamaK on 2021/10/07.
//

import UIKit

extension UIViewController {
    func show(next: UIViewController) {
        if let nav = self.navigationController {
            nav.pushViewController(next, animated: true)
        } else {
            self.present(next, animated: true, completion: nil)
        }
    }
}
