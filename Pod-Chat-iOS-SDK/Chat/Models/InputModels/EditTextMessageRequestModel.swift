//
//  EditTextMessageRequestModel.swift
//  Chat
//
//  Created by Mahyar Zhiani on 10/1/1397 AP.
//  Copyright © 1397 Mahyar Zhiani. All rights reserved.
//

import Foundation


open class EditTextMessageRequestModel {
    
    public let content:     String
    public let messageType: MessageType
    public let metadata:    String?
    public let repliedTo:   Int?
    public let messageId:   Int
    
    public let typeCode:    String?
    public let uniqueId:    String
    
    public init(content:        String,
                messageType:    MessageType,
                metadata:       String?,
                repliedTo:      Int?,
                messageId:      Int,
                typeCode:       String?,
                uniqueId:       String?) {
        
        self.content        = content
        self.messageType    = messageType
        self.metadata       = metadata
        self.repliedTo      = repliedTo
        self.messageId      = messageId
        
        self.typeCode       = typeCode
        self.uniqueId       = uniqueId ?? UUID().uuidString
    }
    
}


