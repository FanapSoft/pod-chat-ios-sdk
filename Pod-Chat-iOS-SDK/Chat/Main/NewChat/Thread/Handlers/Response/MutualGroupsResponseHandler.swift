//
//  MutalGroupsResponseHandler.swift
//  FanapPodChatSDK
//
//  Created by Hamed Hosseini on 4/14/21.
//

import Foundation
import FanapPodAsyncSDK

class MutualGroupsResponseHandler: ResponseHandler {

    static func handle(_ chatMessage: NewChatMessage, _ asyncMessage: NewAsyncMessage) {
		let chat = Chat.sharedInstance
        guard let callback = chat.callbacksManager.getCallBack(chatMessage.uniqueId)else {return}
        guard let data = chatMessage.content?.data(using: .utf8) else {return}
        guard let mutalGroups = try? JSONDecoder().decode([Conversation].self, from: data) else{return}
        callback(.init(uniqueId:chatMessage.uniqueId , result: mutalGroups))
        chat.callbacksManager.removeCallback(uniqueId: chatMessage.uniqueId, requestType: .MUTUAL_GROUPS)
    }
}
