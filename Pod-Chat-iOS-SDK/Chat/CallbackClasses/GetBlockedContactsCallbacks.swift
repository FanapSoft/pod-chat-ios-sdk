//
//  GetBlockedContactsCallbacks.swift
//  FanapPodChatSDK
//
//  Created by Mahyar Zhiani on 3/18/1398 AP.
//  Copyright © 1398 Mahyar Zhiani. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftyBeaver
import FanapPodAsyncSDK


extension Chat {
    
    /*
     * GetBlockContact Response comes from server
     *
     *  send Event to client if needed!
     *  call the "onResultCallback"
     *
     *  + Access:   - private
     *  + Inputs:
     *      - message:      ChatMessage
     *  + Outputs:
     *      - it doesn't have direct output,
     *          but on the situation where the response is valid,
     *          it will call the "onResultCallback" callback to getBlockedContacts function (by using "blockCallbackToUser")
     *
     */
    func responseOfGetBlockContact(withMessage message: ChatMessage) {
        log.verbose("Message of type 'GET_BLOCKED' recieved", context: "Chat")
        
        let returnData = CreateReturnData(hasError:         false,
                                          errorMessage:     "",
                                          errorCode:        0,
                                          result:           nil,
                                          resultAsArray:    message.content?.convertToJSON().array,
                                          resultAsString:   nil,
                                          contentCount:     message.contentCount,
                                          subjectId:        message.subjectId)
        
        if Chat.map[message.uniqueId] != nil {
            let callback: CallbackProtocol = Chat.map[message.uniqueId]!
            callback.onResultCallback(uID:      message.uniqueId,
                                      response: returnData,
                                      success:  { (successJSON) in
                self.getBlockedCallbackToUser?(successJSON)
            }) { _ in }
            Chat.map.removeValue(forKey: message.uniqueId)
        }
        
    }
    
    
    public class GetBlockedContactsCallbacks: CallbackProtocol {
        var sendParams: SendChatMessageVO
        init(parameters: SendChatMessageVO) {
            self.sendParams = parameters
        }
        func onResultCallback(uID:      String,
                              response: CreateReturnData,
                              success:  @escaping callbackTypeAlias,
                              failure:  @escaping callbackTypeAlias) {
            log.verbose("GetBlockListCallback", context: "Chat")
            
            if let arrayContent = response.resultAsArray as? [JSON] {
                let content = sendParams.content?.convertToJSON()
                let getBlockedModel = GetBlockedContactListModel(messageContent:    arrayContent,
                                                                 contentCount:      response.contentCount,
                                                                 count:             content?["count"].intValue ?? 0,
                                                                 offset:            content?["offset"].intValue ?? 0,
                                                                 hasError:          response.hasError,
                                                                 errorMessage:      response.errorMessage,
                                                                 errorCode:         response.errorCode)
                success(getBlockedModel)
            }
            
        }
    }
    
}
