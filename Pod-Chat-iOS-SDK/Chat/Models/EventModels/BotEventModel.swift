//
//  BotEventModel.swift
//  FanapPodChatSDK
//
//  Created by MahyarZhiani on 10/3/1398 AP.
//  Copyright © 1398 Mahyar Zhiani. All rights reserved.
//

import Foundation


open class BotEventModel {
    
    public let type:    BotEventTypes
    public let message: Any?
    
    init(type: BotEventTypes, message: Any?) {
        self.type       = type
        self.message    = message
    }
    
}
