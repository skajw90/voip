//
//  VoipService+PKPushRegistryDelegate.swift
//  voipSample
//
//  Created by Jiwon on 2023/01/31.
//

import CallKit
import PushKit
import AVFAudio

extension VoipService: PKPushRegistryDelegate {
    
    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        AppInfo.shared.voipPushToken = pushCredentials.token
        
        // TODO: - send voip token to server
        print("Voip Token is \(pushCredentials.token.toHexString())")
    }
    
    
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        
        print(payload.dictionaryPayload)
        
        let uuid = UUID()

        // TODO: - encode data
        if let dict = payload.dictionaryPayload as NSDictionary as? [String: [String: Any]]?,
           let call = dict?["aps"]?["call"] as? [String: String] {
            let name = call["name"]
            let description = call["description"]
            let url = call["url"]
            currentCall = CallInfo(uuid: uuid, name: name ?? "핏타민", description: description, url: url)
        }
        
        if currentCall == nil {
            currentCall = CallInfo(uuid: uuid, name: "핏타민")
        }
        
        do {
            // prepare audio activate
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .voiceChat, options: [.allowBluetooth, .duckOthers])
            try AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print(error.localizedDescription)
        }
        
        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .generic, value: currentCall!.name)
        
        provider.reportNewIncomingCall(with: uuid, update: update, completion: { error in
            if let error = error {
                print(error)
                self.provider.reportCall(with: uuid, endedAt: Date(), reason: .failed)
            }
            completion()
        })
    }
}
