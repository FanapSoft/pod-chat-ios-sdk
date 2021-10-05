//
//  StartCallRequestResponseHandler.swift
//  FanapPodChatSDK
//
//  Created by Hamed Hosseini on 6/29/21.
//

import Foundation

fileprivate let RECEIVE_CALL_NAME        = "RECEIVE_CALL_NAME"
public var RECEIVE_CALL_NAME_OBJECT = Notification.Name.init(RECEIVE_CALL_NAME)

class StartCallRequestResponseHandler {
    
	
	///Only call on receivers side. The starter of call never get this event.
    static func handle(_ chatMessage: NewChatMessage, _ asyncMessage: AsyncMessage) {
        
        let chat = Chat.sharedInstance
        guard let data = chatMessage.content?.data(using: .utf8) else {return}
		guard let createCall = try? JSONDecoder().decode(CreateCall.self, from: data) else{return}
        
        //SEND type 73 . This mean client receive call and showing ringing mode on call creator.        
        chat.callReceived(.init(callId: createCall.callId))
        
        chat.callbacksManager.callRequestArriveDelegate?(createCall,chatMessage.uniqueId)
		NotificationCenter.default.post(name: RECEIVE_CALL_NAME_OBJECT ,object: createCall)
    }
}
