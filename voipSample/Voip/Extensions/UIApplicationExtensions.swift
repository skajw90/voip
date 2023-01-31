//
//  UIApplicationExtensions.swift
//  voipSample
//
//  Created by Jiwon on 2023/01/31.
//

import UIKit

extension UIApplication {
    func showCallController(with call: CallInfo) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            guard let viewController = UIStoryboard(name: "Voip", bundle: nil).instantiateViewController(withIdentifier: "VoiceCall") as? CallViewController else {
                return
            }
            viewController.call = call
            if let topViewController = UIViewController.topViewController {
                if !(topViewController is CallViewController) {
                    topViewController.present(viewController, animated: true)
                }
                else {
//                    (topViewController as! CallViewController).endCall()
//                    DispatchQueue.main.async {
//                        self.showCallController(with: call)
//                    }
                }
            }
            else {
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = viewController
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.makeKeyAndVisible()
            }
        }
    }
    
    func closeCallController() {
        DispatchQueue.main.async {
            if let topViewController = UIViewController.topViewController as? CallViewController {
                topViewController.endCall()
            }
        }
    }
}
