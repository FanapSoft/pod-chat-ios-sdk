//
//  AddContactRequestHandler.swift
//  FanapPodChatSDK
//
//  Created by Hamed Hosseini on 3/2/21.
//

import Foundation
import Alamofire

class AddContactRequestHandler{
    
    class func handle(_ req:NewAddContactRequest,
                      _ chat:Chat,
                      _ completion: @escaping CompletionType<[Contact]>,
                      _ uniqueIdResult:UniqueIdResultType = nil){
        
        guard let config = chat.config else {return}
        let url = "\(config.platformHost)\(SERVICES_PATH.ADD_CONTACTS.rawValue)"
        let headers: HTTPHeaders    = ["_token_": config.token, "_token_issuer_": "1"]
        chat.restApiRequest(req, decodeType: NewContactResponse.self,url: url , headers: headers , uniqueIdResult: uniqueIdResult) { response in
            let contactResponse = response.result as? NewContactResponse
            addToCacheIfEnabled(chat: chat, contactsResponse: contactResponse)
            completion(contactResponse?.contacts , response.uniqueId , response.error)
        }
    }
    
    class func addToCacheIfEnabled(chat:Chat , contactsResponse:NewContactResponse?){
        if chat.config?.enableCache  == true , let contacts = contactsResponse?.contacts{
            CMContact.insertOrUpdate(contacts: contacts)
        }
    }
}
