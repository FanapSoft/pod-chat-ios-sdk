//
//  SearchInsideThreadsResponseHandler.swift
//  FanapPodChatSDK
//
//  Created by Hamed Hosseini on 4/11/21.
//

import Foundation
class SearchInsideThreadsResponseHandler: ResponseHandler {

    static func handle(_ chatMessage: NewChatMessage, _ asyncMessage: AsyncMessage) {
		let chat = Chat.sharedInstance
        guard let callback = chat.callbacksManager.getCallBack(chatMessage.uniqueId)else {return}
        guard let data = chatMessage.content?.data(using: .utf8) else {return}
        guard let messages = try? JSONDecoder().decode([Message].self, from: data) else{return}
        callback(.init(uniqueId: chatMessage.uniqueId ,result: messages , contentCount: chatMessage.contentCount ?? 0))
        messages.forEach { message in
            CacheFactory.write(cacheType: .MESSAGE(message))
        }
        chat.callbacksManager.removeCallback(uniqueId: chatMessage.uniqueId)
        CacheFactory.save()
    }
}
