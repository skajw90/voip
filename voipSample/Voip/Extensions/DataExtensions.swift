//
//  DataExtensions.swift
//  voipSample
//
//  Created by Jiwon on 2023/01/31.
//

import Foundation

extension Data {
    func toHexString() -> String {
        return self.map { String(format: "%02x", $0) }.joined()
    }
}
