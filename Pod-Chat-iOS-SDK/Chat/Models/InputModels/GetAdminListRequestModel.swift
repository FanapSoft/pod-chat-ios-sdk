//
//  GetAdminListRequestModel.swift
//  FanapPodChatSDK
//
//  Created by Mahyar Zhiani on 3/1/1398 AP.
//  Copyright © 1398 Mahyar Zhiani. All rights reserved.
//

import Foundation

open class GetAdminListRequestModel {
    
    public let threadId:    Int
    
    public let uniqueId:    String?
    
    public init(threadId:   Int,
                uniqueId:   String?) {
        self.threadId   = threadId
        self.uniqueId   = uniqueId
    }
    
}


