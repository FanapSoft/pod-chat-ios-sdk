//
//  QueueOfWaitEditMessagesModel.swift
//  FanapPodChatSDK
//
//  Created by Mahyar Zhiani on 11/27/1397 AP.
//  Copyright © 1397 Mahyar Zhiani. All rights reserved.
//

import Foundation
import SwiftyJSON

open class QueueOfWaitEditMessagesModel {
    
    let content:        String?
    let messageType:    MessageType
    let metadata:       String?
    let repliedTo:      Int?
    let messageId:      Int?
    let threadId:       Int?
    
    let typeCode:   String?
    let uniqueId:   String?
    
    init(content:       String?,
         messageType:   MessageType,
         metadata:      String?,
         repliedTo:     Int?,
         messageId:     Int?,
         threadId:      Int?,
         typeCode:      String?,
         uniqueId:      String?) {
        
        self.content        = content
        self.messageType    = messageType
        self.metadata       = metadata
        self.repliedTo      = repliedTo
        self.messageId      = messageId
        self.threadId       = threadId
        self.typeCode       = typeCode
        self.uniqueId       = uniqueId
    }
    
    init(editMessageInputModel: EditTextMessageRequest) {
        self.content        = editMessageInputModel.textMessage
        self.messageType    = editMessageInputModel.messageType
        self.repliedTo      = editMessageInputModel.repliedTo
        self.messageId      = editMessageInputModel.messageId
        self.threadId       = nil
        self.metadata       = nil
        self.typeCode       = editMessageInputModel.typeCode
        self.uniqueId       = editMessageInputModel.uniqueId
    }
    
    
    public func returnDataAsJSON() -> JSON {
        let result: JSON = ["content":      content ?? NSNull(),
                            "messageType":  messageType,
                            "metadata":     metadata ?? NSNull(),
                            "repliedTo":    repliedTo ?? NSNull(),
                            "messageId":    messageId ?? NSNull(),
                            "threadId":     threadId ?? NSNull(),
                            "typeCode":     typeCode ?? NSNull(),
                            "uniqueId":     uniqueId ?? NSNull()]
        return result
    }
    
}
