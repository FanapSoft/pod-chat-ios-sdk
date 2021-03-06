//
//  GetContactsRequestModel.swift
//  Chat
//
//  Created by Mahyar Zhiani on 10/1/1397 AP.
//  Copyright © 1397 Mahyar Zhiani. All rights reserved.
//

import FanapPodAsyncSDK
import SwiftyJSON

open class GetContactsRequest {
    
    public let count:       Int?
    public let offset:      Int?
    public let query:       String?
    
    public let typeCode:    String?
    public let uniqueId:    String
    
    public init(count:      Int?,
                offset:     Int?,
                query:      String?,
                typeCode:   String?,
                uniqueId:   String?) {
        
        self.count      = count
        self.offset     = offset
        self.query      = query
        
        self.typeCode   = typeCode
        self.uniqueId   = uniqueId ?? UUID().uuidString
    }
    
    public init(json: JSON) {
        self.count      = json["count"].int
        self.offset     = json["offset"].int
        self.query      = json["query"].string
        
        self.typeCode   = json["typeCode"].string
        self.uniqueId   = json["uniqueId"].string ?? UUID().uuidString
    }
    
    public func convertContentToJSON() -> JSON {
        var content: JSON = [:]
        
        content["size"]     = JSON(self.count ?? 50)
        content["offset"]   = JSON(self.offset ?? 0)
        if let query = self.query {
            let theQuery = MakeCustomTextToSend(message: query).replaceSpaceEnterWithSpecificCharecters()
            content["query"] = JSON(theQuery)
        }
        
        return content
    }
    
    public func convertContentToJSONArray() -> [JSON] {
        return []
    }
    
}

/// MARK: -  this class will be deprecate (use this class instead: 'GetContactsRequest')
open class GetContactsRequestModel: GetContactsRequest {
    
}

