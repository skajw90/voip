//
//  CallViewController.swift
//  voipSample
//
//  Created by Jiwon on 2023/01/31.
//

import UIKit

class CallViewController: UIViewController {
    var call: CallInfo?

    deinit {
        if let call = call {
            VoipService.shared.endCall(call)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                UIViewController.topViewController?.viewWillAppear(true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            // connect to voip call
        })
    }
    
    func endCall() {
        if let call = call {
            VoipService.shared.endCall(call)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
