//
//  StartBotRequestHandler.swift
//  FanapPodChatSDK
//
//  Created by Hamed Hosseini on 3/3/21.
//

import Foundation
class StartBotRequestHandler {
	
	class func handle( _ req:NewStartStopBotRequest,
					   _ chat:Chat,
					   _ completion: @escaping CompletionType<String> ,
					   _ uniqueIdResult: UniqueIdResultType = nil
	){
		chat.prepareToSendAsync(req: req,
								clientSpecificUniqueId: req.uniqueId,
								typeCode: req.typeCode ,
								subjectId: req.threadId,
								messageType: .START_BOT,
                                uniqueIdResult: uniqueIdResult){ response in
            completion(response.result as? String , response.uniqueId , response.error)
        }
	}
}
