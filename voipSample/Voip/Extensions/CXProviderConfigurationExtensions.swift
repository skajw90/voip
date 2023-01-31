//
//  CXProviderConfigurationExtensions.swift
//  voipSample
//
//  Created by Jiwon on 2023/01/31.
//

import UIKit
import CallKit

extension CXProviderConfiguration {
    // The app's provider configuration, representing its CallKit capabilities
    static var `default`: CXProviderConfiguration {
        let providerConfiguration = CXProviderConfiguration()
        if let image = UIImage(named: "icLogoSymbolInverse") {
            providerConfiguration.iconTemplateImageData = image.pngData()
        }
        providerConfiguration.supportsVideo = true
        providerConfiguration.maximumCallsPerCallGroup = 1
        providerConfiguration.maximumCallGroups = 1
        providerConfiguration.supportedHandleTypes = [.generic]
        providerConfiguration.ringtoneSound = "ringing.mp3"
        
        return providerConfiguration
    }
}
