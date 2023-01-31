//
//  CallInfo.swift
//  voipSample
//
//  Created by Jiwon on 2023/01/31.
//

import Foundation

struct CallInfo: Codable {
    var uuid: UUID?
    var name: String
    var description: String?
    var url: String?
    
    var isVideoCall: Bool = false
}
