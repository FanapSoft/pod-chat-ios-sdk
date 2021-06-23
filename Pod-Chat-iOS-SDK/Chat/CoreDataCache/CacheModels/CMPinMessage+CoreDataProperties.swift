//
//  CMPinMessage+CoreDataProperties.swift
//  FanapPodChatSDK
//
//  Created by MahyarZhiani on 10/30/1398 AP.
//  Copyright © 1398 Mahyar Zhiani. All rights reserved.
//
//

import Foundation
import CoreData


extension CMPinMessage {

	@available(*,deprecated , message:"Removed in 0.10.5.0 version")
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CMPinMessage> {
        return NSFetchRequest<CMPinMessage>(entityName: "CMPinMessage")
    }

    @NSManaged public var messageId:    NSNumber?
    @NSManaged public var text:         String?
    @NSManaged public var notifyAll:    NSNumber?
    
    @NSManaged public var message:      CMMessage?

}
