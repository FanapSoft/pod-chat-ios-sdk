//
//  PinThreadCallback.swift
//  FanapPodChatSDK
//
//  Created by MahyarZhiani on 10/7/1398 AP.
//  Copyright © 1398 Mahyar Zhiani. All rights reserved.
//

import Foundation
import SwiftyBeaver
import FanapPodAsyncSDK


extension Chat {
    
    /// PinThread Response comes from server
    ///
    /// - Outputs:
    ///    - it doesn't have direct output,
    ///    - but on the situation where the response is valid,
    ///    - it will call the "onResultCallback" callback to pinThread function (by using "pinThreadCallbackToUser")
    @available(*,deprecated , message:"Removed in 0.10.5.0 version")
    func responseOfPinThread(withMessage message: ChatMessage) {
        log.verbose("Message of type 'PIN_THREAD' recieved", context: "Chat")
        
        let tPinEM = ThreadEventModel(type:         ThreadEventTypes.THREAD_PIN,
                                      participants: nil,
                                      threads:      nil,
                                      threadId:     message.subjectId,
                                      senderId:     nil,
                                      unreadCount:  message.content?.convertToJSON()["unreadCount"].int,
                                      pinMessage:   nil)
        delegate?.threadEvents(model: tPinEM)
        
        let returnData = CreateReturnData(hasError:         false,
                                          errorMessage:     "",
                                          errorCode:        0,
                                          result:           nil,
                                          resultAsArray:    nil,
                                          resultAsString:   message.content,
                                          contentCount:     nil,
                                          subjectId:        message.subjectId)
        
        if enableCache {
            if let thId = message.subjectId {
                Chat.cacheDB.savePinUnpinCMConversationEntity(withThreadId: thId, isPinned: true)
            }
        }
        
        if Chat.map[message.uniqueId] != nil {
            let callback: CallbackProtocol = Chat.map[message.uniqueId]!
            callback.onResultCallback(uID:      message.uniqueId,
                                      response: returnData,
                                      success:  { (successJSON) in
                self.pinThreadCallbackToUser?(successJSON)
            }) { _ in }
            Chat.map.removeValue(forKey: message.uniqueId)
        }
    }
    
    @available(*,deprecated , message:"Removed in 0.10.5.0 version")
    public class PinThreadCallbacks: CallbackProtocol {
        func onResultCallback(uID:      String,
                              response: CreateReturnData,
                              success:  @escaping callbackTypeAlias,
                              failure:  @escaping callbackTypeAlias) {
            log.verbose("PinThreadCallbacks", context: "Chat")
            
            if let stringContent = response.resultAsString {
                let muteModel = PinUnpinThreadResponse(threadId:        Int(stringContent) ?? 0,
                                                       hasError:        response.hasError,
                                                       errorMessage:    response.errorMessage,
                                                       errorCode:       response.errorCode)
                success(muteModel)
            }
            
        }
        
    }
    
}
