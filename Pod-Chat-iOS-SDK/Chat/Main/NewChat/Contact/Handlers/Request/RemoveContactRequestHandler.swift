//
//  RemoveContactRequestHandler.swift
//  FanapPodChatSDK
//
//  Created by Hamed Hosseini on 3/2/21.
//

import Foundation
import Alamofire

class RemoveContactRequestHandler{
    
    class func handle(_ req:NewRemoveContactsRequest,
                      _ chat:Chat,
                      _ completion: @escaping CompletionType<Bool>,
                      _ uniqueIdResult:UniqueIdResultType = nil){
        
        guard let config = chat.config else {return}
        let url = "\(config.platformHost)\(SERVICES_PATH.REMOVE_CONTACTS.rawValue)"
        let headers: HTTPHeaders    = ["_token_": config.token, "_token_issuer_": "1"]
        chat.restApiRequest(req, decodeType: NewRemoveContactResponse.self,  url: url,bodyParameter: true , method: .post, headers: headers , uniqueIdResult: uniqueIdResult){ response in
            let removeResponse = response.result as? NewRemoveContactResponse
            removeFromCacheIfExist(chat: chat, removeContactResponse: removeResponse, contactId: req.contactId)
            completion(removeResponse?.deteled ?? false , response.uniqueId , response.error)
        }
    }
    
    private class func removeFromCacheIfExist(chat:Chat , removeContactResponse:NewRemoveContactResponse? , contactId:Int){
        if removeContactResponse?.deteled == true{
            CacheFactory.write(cacheType: .DELETE_CONTACTS([contactId]))
			PSM.shared.save()
        }
    }
}
