//
//  SendReplyFileMessageRequest.swift
//  Chat
//
//  Created by Mahyar Zhiani on 10/1/1397 AP.
//  Copyright © 1397 Mahyar Zhiani. All rights reserved.
//

import Foundation
import SwiftyJSON

@available(*,deprecated , message:"Removed in 0.10.5.0 version.")
open class SendReplyFileMessageRequest {
    
    let messageInput:   SendTextMessageRequest
    let uploadInput:    UploadRequest
    
    public init(messageInput:   SendTextMessageRequest,
                uploadInput:    UploadRequest) {
        
        self.messageInput   = messageInput
        self.uploadInput    = uploadInput
    }
    
}

@available(*,deprecated , message:"Removed in 0.10.5.0 version.")
open class SendFileMessageRequestModel: SendReplyFileMessageRequest {
    
}

