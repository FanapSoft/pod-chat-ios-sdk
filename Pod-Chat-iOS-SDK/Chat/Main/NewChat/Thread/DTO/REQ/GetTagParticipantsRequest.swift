//
//  GetTagThreadsRequest.swift
//  FanapPodChatSDK
//
//  Created by Hamed Hosseini on 2/22/21.
//

import Foundation
public class GetTagParticipantsRequest: BaseRequest {
	
    public var id    : Int
	
    public init(id:Int, uniqueId: String? = nil, typeCode: String? = nil){
        self.id     = id
        super.init(uniqueId: uniqueId, typeCode: typeCode)
	}
}
