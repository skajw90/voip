//
//  UIViewControllerExtensions.swift
//  voipSample
//
//  Created by Jiwon on 2023/01/31.
//

import UIKit

@nonobjc extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)

        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    static var topViewController: UIViewController? {
        if var topController = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        } else {
            return nil
        }
    }
}
