//
//  NSUserActivityExtension.swift
//  voipSample
//
//  Created by Jiwon on 2023/01/31.
//

import Intents

extension NSUserActivity {

    var startCallHandle: String? {
        guard let startCallIntent = interaction?.intent as? INStartCallIntent else {
            return nil
        }
        return startCallIntent.contacts?.first?.personHandle?.value
    }

}
