//
//  PinThreadRequestHandler.swift
//  FanapPodChatSDK
//
//  Created by Hamed Hosseini on 3/3/21.
//

import Foundation
class PinThreadRequestHandler {
	
	class func handle( _ request:NewPinUnpinThreadRequest,
					   _ chat:Chat,
					   _ completion: @escaping CompletionType<Int>,
					   _ uniqueIdResult: UniqueIdResultType = nil
	){
		
		chat.prepareToSendAsync(req: nil,
								clientSpecificUniqueId: request.uniqueId,
								typeCode: request.typeCode,
								subjectId: request.threadId ,
								messageType: .PIN_THREAD,
                                uniqueIdResult: uniqueIdResult){ response in
            let pinResponse = response.result as? PinThreadResponse
            completion(pinResponse?.threadId,response.uniqueId , response.error)
        }
	}
}

	
