//
//  VoipService+CXProviderDelegate.swift
//  voipSample
//
//  Created by Jiwon on 2023/01/31.
//

import CallKit
import UIKit

extension VoipService: CXProviderDelegate {
    func providerDidReset(_ provider: CXProvider) {
        
    }
    
    func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        guard let currentCall = currentCall else { return }
        
        backgroundTaskId = UIApplication.shared.beginBackgroundTask(withName: "voip_call_task") {
            if let backgroundTaskId = self.backgroundTaskId {
                UIApplication.shared.endBackgroundTask(backgroundTaskId)
            }
            self.backgroundTaskId = nil
            
        }
        UIApplication.shared.showCallController(with: currentCall)
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        
        UIApplication.shared.closeCallController()
      
        action.fulfill()
        if let backgroundTaskId = backgroundTaskId {
            UIApplication.shared.endBackgroundTask(backgroundTaskId)
            self.backgroundTaskId = nil
        }
    
    }
}
