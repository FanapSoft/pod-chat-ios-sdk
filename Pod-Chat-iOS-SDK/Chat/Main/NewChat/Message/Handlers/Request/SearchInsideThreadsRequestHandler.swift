//
//  SearchInsideThreadsRequestHandler.swift
//  FanapPodChatSDK
//
//  Created by Hamed Hosseini on 3/3/21.
//

import Foundation
class SearchInsideThreadsRequestHandler {
	
	class func handle( _ request:SearchIndsideThreadsRequest,
					   _ chat:Chat,
					   _ completion:@escaping PaginationCompletionType<[Message]>,
					   _ uniqueIdResult: UniqueIdResultType = nil
	){
		
		chat.prepareToSendAsync(req: request,
								clientSpecificUniqueId: request.uniqueId,
								typeCode: request.typeCode,
								messageType: .SEARCH_INSIDE_THREADS,
                                uniqueIdResult: uniqueIdResult){ response in
            let pagination = Pagination(count: request.count, offset: request.offset, totalCount: response.contentCount)
            completion(response.result as? [Message] ,response.uniqueId , pagination , response.error)
        }
	}
}

	
