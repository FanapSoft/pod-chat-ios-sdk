//
//  ChangeThreadTypeResposneHandler.swift
//  FanapPodChatSDK
//
//  Created by Hamed Hosseini on 2/28/21.
//

import Foundation
import FanapPodAsyncSDK

class ChangeThreadTypeResposneHandler: ResponseHandler {
    
    static func handle(_ chatMessage: NewChatMessage, _ asyncMessage: NewAsyncMessage) {
        
		let chat = Chat.sharedInstance
        chat.delegate?.threadEvents(model: .init(type: .THREAD_REMOVED_FROM, chatMessage: chatMessage))
        if chat.config?.enableCache == true , let threadId = chatMessage.subjectId {
            CacheFactory.write(cacheType: .DELETE_THREADS([threadId]))
        }
        if let callback = chat.callbacksManager.getCallBack(chatMessage.uniqueId) , let data = chatMessage.content?.data(using: .utf8){
            let thread = try? JSONDecoder().decode(Conversation.self, from: data)
            callback(.init(uniqueId:chatMessage.uniqueId , result: thread))
        }
        chat.callbacksManager.removeCallback(uniqueId: chatMessage.uniqueId, requestType: .CHANGE_THREAD_TYPE)
    }
}
