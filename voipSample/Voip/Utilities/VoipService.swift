//
//  VoipService.swift
//  voipSample
//
//  Created by Jiwon on 2023/01/31.
//

import PushKit
import CallKit
import UIKit


class VoipService: NSObject {
    
    static let shared = VoipService()
    
    var currentCalls: [CXCall] { self.controller.callObserver.calls }
    
    var voipRegistry: PKPushRegistry!
    let controller = CXCallController()
    var provider: CXProvider!
    var currentCall: CallInfo?
    
    var backgroundTaskId: UIBackgroundTaskIdentifier? = nil
    
    
    private override init() { }
    
    func configuration() {
        provider = CXProvider.default
        voipRegistry = PKPushRegistry(queue: .main)
        voipRegistry.delegate = self
        voipRegistry.desiredPushTypes = [.voIP]
        provider.setDelegate(self, queue: .main)
        
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func shouldProcessCall(for uuid: UUID) -> Bool {
        return !currentCalls.contains { $0.uuid == uuid }
    }
    
    // outgoing call
    func startCall(_ call: CallInfo?, completion: @escaping (Bool) -> Void) {
        print("start call")
        guard let call = call, let uuid = call.uuid else {
            DispatchQueue.main.async {
                completion(false)
            }
            return
        }
        
        let handle = CXHandle(type: .generic, value: call.name)
        let startCallAction = CXStartCallAction(call: uuid, handle: handle)
        startCallAction.isVideo = call.isVideoCall
        
        let transaction = CXTransaction(action: startCallAction)
        
        self.requestTransaction(transaction)
        
        DispatchQueue.main.async {
            completion(true)
        }
    }
    
    func endCall(_ call: CallInfo) {
        guard let currentCall = currentCall, let uuid = currentCall.uuid else { return }
        let endCallAction = CXEndCallAction(call: uuid)
        let transaction = CXTransaction(action: endCallAction)
        
        requestTransaction(transaction)
    }
    
    private func requestTransaction(_ transaction: CXTransaction, action: String = "") {
        controller.request(transaction) { error in
            guard error == nil else {
                print("Error Requesting Transaction: \(String(describing: error))")
                return
            }
            
        }
    }
    
}
