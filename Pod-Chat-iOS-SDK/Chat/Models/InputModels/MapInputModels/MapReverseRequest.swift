//
//  MapReverseRequest.swift
//  FanapPodChatSDK
//
//  Created by Mahyar Zhiani on 10/11/1397 AP.
//  Copyright © 1397 Mahyar Zhiani. All rights reserved.
//

import Foundation

@available(*,deprecated , message:"Removed in 0.10.5.0 version.")
open class MapReverseRequest {
    
    public let lat:     Double
    public let lng:     Double
    
    public init(lat:    Double,
                lng:    Double) {
        
        self.lat    = lat
        self.lng    = lng
    }
    
}


@available(*,deprecated , message:"Removed in 0.10.5.0 version.")
open class MapReverseRequestModel: MapReverseRequest {
    
}






