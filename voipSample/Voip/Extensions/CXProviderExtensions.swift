//
//  CXProviderExtensions.swift
//  voipSample
//
//  Created by Jiwon on 2023/01/31.
//

import CallKit

extension CXProvider {
    static var `default`: CXProvider {
        CXProvider(configuration: .`default`)
    }
}
