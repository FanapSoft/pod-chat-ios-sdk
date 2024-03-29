//
//  Invitee.swift
//  Chat
//
//  Created by Mahyar Zhiani on 7/23/1397 AP.
//  Copyright © 1397 Mahyar Zhiani. All rights reserved.
//

import Foundation
import SwiftyJSON

open class Invitee : Codable{
    /*
     * + InviteeVO       {object}
     *    - id           {string}
     *    - idType       {int}
     */
    
    public var id:     String?
    public var idType: Int?
    
    @available(*,deprecated , message:"Removed in 0.10.5.0 version")
    public init(messageContent: JSON) {
        self.id = messageContent["id"].string
        if let myIdType = messageContent["idType"].string {
            switch myIdType {
            case InviteeVoIdTypes.TO_BE_USER_SSO_ID.stringValue():              self.idType = 1
            case InviteeVoIdTypes.TO_BE_USER_CONTACT_ID.stringValue():          self.idType = 2
            case InviteeVoIdTypes.TO_BE_USER_CELLPHONE_NUMBER.stringValue():    self.idType = 3
            case InviteeVoIdTypes.TO_BE_USER_USERNAME.stringValue():            self.idType = 4
            case InviteeVoIdTypes.TO_BE_USER_ID.stringValue():                  self.idType = 5
            default: break
            }
        } else if let myIdType = messageContent["idType"].int {
            self.idType = myIdType
        }
    }
    
    @available(*,deprecated , message:"Removed in 0.10.5.0 version")
    public init(id:     String?,
                idType: String?) {
        
        self.id = id
        if let myIdType = idType {
            switch myIdType {
            case InviteeVoIdTypes.TO_BE_USER_SSO_ID.stringValue(),
                 "\(InviteeVoIdTypes.TO_BE_USER_SSO_ID.intValue())":                self.idType = 1
                
            case InviteeVoIdTypes.TO_BE_USER_CONTACT_ID.stringValue(),
                 "\(InviteeVoIdTypes.TO_BE_USER_CONTACT_ID.stringValue())":         self.idType = 2
                
            case InviteeVoIdTypes.TO_BE_USER_CELLPHONE_NUMBER.stringValue(),
                 "\(InviteeVoIdTypes.TO_BE_USER_CELLPHONE_NUMBER.stringValue())":   self.idType = 3
                
            case InviteeVoIdTypes.TO_BE_USER_USERNAME.stringValue(),
                 "\(InviteeVoIdTypes.TO_BE_USER_USERNAME.stringValue())":           self.idType = 4
                
            case InviteeVoIdTypes.TO_BE_USER_ID.stringValue(),
                 "\(InviteeVoIdTypes.TO_BE_USER_ID.stringValue())":                 self.idType = 5
            default: break
            }
        }
        
    }
    
    public init(id:     String?,
                idType: InviteeVoIdTypes?) {
        
        self.id = id
        if let myIdType = idType {
            switch myIdType {
            case InviteeVoIdTypes.TO_BE_USER_SSO_ID:            self.idType = 1
            case InviteeVoIdTypes.TO_BE_USER_CONTACT_ID:        self.idType = 2
            case InviteeVoIdTypes.TO_BE_USER_CELLPHONE_NUMBER:  self.idType = 3
            case InviteeVoIdTypes.TO_BE_USER_USERNAME:          self.idType = 4
            case InviteeVoIdTypes.TO_BE_USER_ID:                self.idType = 5
            case InviteeVoIdTypes.TO_BE_CORE_USER_ID:           self.idType = 6
            }
        }
        
    }
    
    @available(*,deprecated , message:"Removed in 0.10.5.0 version")
    public init(theInvitee: Invitee) {
        
        self.id     = theInvitee.id
        self.idType = theInvitee.idType
        
    }
    
    @available(*,deprecated , message:"Removed in 0.10.5.0 version")
    public func formatDataToMakeInvitee() -> Invitee {
        return self
    }
    
    @available(*,deprecated , message:"Removed in 0.10.5.0 version")
    public func formatToJSON() -> JSON {
        let result: JSON = ["id":               id ?? NSNull(),
                            "idType":           idType ?? NSNull()]
        return result
    }
    
}
