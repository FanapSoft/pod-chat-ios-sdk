//
//  IsAvailableNameResponse.swift
//  FanapPodChatSDK
//
//  Created by MahyarZhiani on 12/25/1398 AP.
//  Copyright © 1398 Mahyar Zhiani. All rights reserved.
//

import Foundation
import SwiftyJSON

@available(*,deprecated , message:"Removed in 0.10.5.0 version")
open class IsAvailableNameModel: ResponseModel, ResponseModelDelegates {
    
    public let uniqueName:  String?
    
    public init(messageContent: JSON,
                hasError:       Bool,
                errorMessage:   String,
                errorCode:      Int) {
        
        self.uniqueName = messageContent["uniqueName"].string
        super.init(hasError: hasError, errorMessage: errorMessage, errorCode: errorCode)
    }
    
    public init(uniqueName:     String?,
                hasError:       Bool,
                errorMessage:   String,
                errorCode:      Int) {
        
        self.uniqueName = uniqueName
        super.init(hasError: hasError, errorMessage: errorMessage, errorCode: errorCode)
    }
    
    public func returnDataAsJSON() -> JSON {
        let result: JSON = ["uniqueName":   uniqueName ?? NSNull()]
        
        let resultAsJSON: JSON = ["result":         result,
                                  "hasError":       hasError,
                                  "errorMessage":   errorMessage,
                                  "errorCode":      errorCode]
        
        return resultAsJSON
    }
    
}

@available(*,deprecated , message:"Removed in 0.10.5.0 version")
open class IsAvailableNameResponse: IsAvailableNameModel {
    
}


