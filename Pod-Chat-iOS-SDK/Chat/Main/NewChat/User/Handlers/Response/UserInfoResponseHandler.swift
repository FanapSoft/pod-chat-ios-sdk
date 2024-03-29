//
//  UserInfoResponseHandler.swift
//  FanapPodChatSDK
//
//  Created by Hamed Hosseini on 2/24/21.
//

import Foundation
import FanapPodAsyncSDK

class UserInfoResponseHandler: ResponseHandler{
	
	static func handle(_ chatMessage: NewChatMessage, _ asyncMessage: NewAsyncMessage) {
		
		let chat = Chat.sharedInstance
        chat.delegate?.systemEvents(model: .init(type: .SERVER_TIME, time: chatMessage.time))
        guard let callback = chat.callbacksManager.getCallBack(chatMessage.uniqueId)else {return}
		guard let data = chatMessage.content?.data(using: .utf8) else {return}
		guard let user = try? JSONDecoder().decode(User.self, from: data) else {return}
		callback(.init(uniqueId: chatMessage.uniqueId ,result: user))
        CacheFactory.write(cacheType: .USER_INFO(user))
        PSM.shared.save()
        chat.callbacksManager.removeCallback(uniqueId: chatMessage.uniqueId, requestType: .USER_INFO)
	}
}
