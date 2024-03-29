//
//  BotMessageResponseHandler.swift
//  FanapPodChatSDK
//
//  Created by Hamed Hosseini on 3/14/21.
//

import Foundation
import FanapPodAsyncSDK

class BotMessageResponseHandler: ResponseHandler {
    
    static func handle(_ chatMessage: NewChatMessage, _ asyncMessage: NewAsyncMessage) {
		let chat = Chat.sharedInstance
        chat.delegate?.botEvents(model: .init(type: .BOT_MESSAGE, message:chatMessage.content))
        chat.callbacksManager.removeCallback(uniqueId: chatMessage.uniqueId, requestType: .BOT_MESSAGE)
    }
}
