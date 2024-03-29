//
//  MessageChangeState.swift
//  Chat
//
//  Created by Mahyar Zhiani on 7/23/1397 AP.
//  Copyright © 1397 Mahyar Zhiani. All rights reserved.
//

import Foundation
import SwiftyJSON


open class MessageChangeState {
    /*
     * + MessageChangeStateVO   MessageChangeState:
     *    - messageId               Int?
     *    - senderId                Int?
     *    - threadId                Int?
     */
    
    public var messageId:  Int?
    public var senderId:   Int?
    public var threadId:   Int?
    
    @available(*,deprecated , message:"Removed in 0.10.5.0 version")
    public init(messageContent: JSON) {
        self.messageId  = messageContent["messageId"].int
        self.senderId   = messageContent["senderId"].int
        self.threadId   = messageContent["threadId"].int
    }
    
    public init(messageId:  Int?,
                senderId:   Int?,
                threadId:   Int?) {
        
        self.messageId  = messageId
        self.senderId   = senderId
        self.threadId   = threadId
    }
    
    @available(*,deprecated , message:"Removed in 0.10.5.0 version")
    public init(theMessageChangeState: MessageChangeState) {
        
        self.messageId  = theMessageChangeState.messageId
        self.senderId   = theMessageChangeState.senderId
        self.threadId   = theMessageChangeState.threadId
    }
    
    @available(*,deprecated , message:"Removed in 0.10.5.0 version")
    public func formatDataToMakeMessageChangeState() -> MessageChangeState {
        return self
    }
    
    @available(*,deprecated , message:"Removed in 0.10.5.0 version")
    public func formatToJSON() -> JSON {
        let result: JSON = ["messageId":        messageId ?? NSNull(),
                            "senderId":         senderId ?? NSNull(),
                            "threadId":         threadId ?? NSNull()]
        return result
    }
    
}
