//
//  GetAllUnreadMessageCountResponse.swift
//  FanapPodChatSDK
//
//  Created by MahyarZhiani on 12/25/1398 AP.
//  Copyright © 1398 Mahyar Zhiani. All rights reserved.
//

import Foundation
import SwiftyJSON

@available(*,deprecated , message:"Removed in 0.10.5.0 version")
open class UnreadMessageCountModel: ResponseModel, ResponseModelDelegates {
    
    public let unreadCount: Int
    
    public init(unreadCount:    Int,
                hasError:       Bool,
                errorMessage:   String,
                errorCode:      Int) {
        
        self.unreadCount    = unreadCount
        super.init(hasError: hasError, errorMessage: errorMessage, errorCode: errorCode)
    }
    
    public func returnDataAsJSON() -> JSON {
        let result: JSON = ["unreadCount":  unreadCount]
        
        let resultAsJSON: JSON = ["result":         result,
                                  "hasError":       hasError,
                                  "errorMessage":   errorMessage,
                                  "errorCode":      errorCode]
        
        return resultAsJSON
    }
    
}

@available(*,deprecated , message:"Removed in 0.10.5.0 version")
open class GetAllUnreadMessageCountResponse: UnreadMessageCountModel{
    
}


