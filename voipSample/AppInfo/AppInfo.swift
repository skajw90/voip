//
//  AppInfo.swift
//  voipSample
//
//  Created by Jiwon on 2023/01/31.
//

import Foundation

class AppInfo {
    static let shared = AppInfo()
    
    private init() { }
    
    var version: String? {
        if let info: [String: Any] = Bundle.main.infoDictionary,
            let currentVersion = info["CFBundleShortVersionString"] as? String { return currentVersion }
        else { return nil }
    }
    
    var fcmToken: String?
    
    var voipPushToken: Data?
}
