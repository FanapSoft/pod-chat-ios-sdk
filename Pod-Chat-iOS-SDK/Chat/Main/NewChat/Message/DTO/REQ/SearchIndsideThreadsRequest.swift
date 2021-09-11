//
//  SearchIndsideThreadsRequest.swift
//  FanapPodChatSDK
//
//  Created by Hamed Hosseini on 3/9/21.
//

import Foundation
public class SearchIndsideThreadsRequest: BaseRequest {
    
    public let count             :Int
    public let offset            :Int
    public let fromTime          :UInt?
    public let fromTimeNanos     :UInt?
    public let toTime            :UInt?
    public let toTimeNanos       :UInt?
    public let messageId         :Int?
    public let messageType       :Int?
    public let order             :String?
    public let query             :String?
    public let metadataCriteria  :String?
    public let uniqueIds         :[String]?
    public let userId            :Int?
    public let hashtag           :String?
    
    public let historyTime       :UInt?
    public let allMentioned      :Bool?
    public let unreadMentioned   :Bool?
    public let lastMessageTime   :Int?
    public let audience          :Int?
    public let historyEndTime    :UInt?
    public let searchInAllThread :Bool?
    public let messageThreadId   :Int?
    public let userName          :String?
    public let firstMessageId    :Int?
    public let lastMessageId     :Int?
    public let senderId          :Int?
    
    public init(count             : Int?        = nil ,
                offset            : Int?        = nil ,
                fromTime          : UInt?       = nil ,
                fromTimeNanos     : UInt?       = nil ,
                toTime            : UInt?       = nil ,
                toTimeNanos       : UInt?       = nil ,
                messageId         : Int?        = nil ,
                messageType       : Int?        = nil ,
                order             : String?     = nil ,
                query             : String?     = nil ,
                metadataCriteria  : String?     = nil ,
                uniqueIds         : [String]?   = nil ,
                userId            : Int?        = nil ,
                hashtag           : String?     = nil ,
                historyTime       : UInt?       = nil,
                allMentioned      : Bool?       = nil,
                unreadMentioned   : Bool?       = nil,
                lastMessageTime   : Int?        = nil,
                audience          : Int?        = nil,
                historyEndTime    : UInt?       = nil,
                searchInAllThread : Bool?       = nil,
                messageThreadId   : Int?        = nil,
                userName          : String?     = nil,
                firstMessageId    : Int?        = nil,
                lastMessageId     : Int?        = nil,
                senderId          : Int?        = nil,
                uniqueId          : String?     = nil ,
                typeCode          : String?     = nil
    ) {
        self.count             = count ?? 50
        self.offset            = offset ?? 0
        self.fromTime          = fromTime
        self.fromTimeNanos     = fromTimeNanos
        self.toTime            = toTime
        self.toTimeNanos       = toTimeNanos
        self.messageId         = messageId
        self.messageType       = messageType
        self.order             = order
        self.query             = query
        self.metadataCriteria  = metadataCriteria
        self.uniqueIds         = uniqueIds
        self.userId            = userId
        self.hashtag           = hashtag
        
        self.historyTime       = historyTime
        self.allMentioned      = allMentioned
        self.unreadMentioned   = unreadMentioned
        self.lastMessageTime   = lastMessageTime
        self.audience          = audience
        self.historyEndTime    = historyEndTime
        self.searchInAllThread = searchInAllThread
        self.messageThreadId   = messageThreadId
        self.userName          = userName
        self.firstMessageId    = firstMessageId
        self.lastMessageId     = lastMessageId
        self.senderId          = senderId
        super.init(uniqueId: uniqueId, typeCode: typeCode)
    }
    
    private enum CodingKeys : String , CodingKey{
        case count            = "count"
        case offset           = "offset"
        case fromTime         = "fromTime"
        case fromTimeNanos    = "fromTimeNanos"
        case messageId        = "id"
        case messageType      = "messageType"
        case metadataCriteria = "metadataCriteria"
        case order            = "order"
        case query            = "query"
        case toTime           = "toTime"
        case hashtag          = "hashtag"
        case toTimeNanos      = "toTimeNanos"
        case uniqueIds        = "uniqueIds"
        case userId           = "userId"
        
        case historyTime       = "historyTime"
        case allMentioned      = "allMentioned"
        case unreadMentioned   = "unreadMentioned"
        case lastMessageTime   = "lastMessageTime"
        case audience          = "audience"
        case historyEndTime    = "historyEndTime"
        case searchInAllThread = "searchInAllThread"
        case messageThreadId   = "messageThreadId"
        case userName          = "userName"
        case firstMessageId    = "firstMessageId"
        case lastMessageId     = "lastMessageId"
        case senderId          = "senderId"
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(count , forKey: .count)
        try container.encode(offset , forKey: .offset)
        try container.encodeIfPresent(messageId , forKey: .messageId)
        try container.encodeIfPresent(fromTime , forKey: .fromTime)
        try container.encodeIfPresent(fromTimeNanos , forKey: .fromTimeNanos)
        try container.encodeIfPresent(toTime , forKey: .toTime)
        try container.encodeIfPresent(toTimeNanos , forKey: .toTimeNanos)
        try container.encodeIfPresent(order , forKey: .order)
        try container.encodeIfPresent(query?.getCustomTextToSendWithRemoveSpaceAndEnter() , forKey: .query)
        try container.encodeIfPresent(metadataCriteria?.getCustomTextToSendWithRemoveSpaceAndEnter() , forKey: .metadataCriteria)
        try container.encodeIfPresent(uniqueIds, forKey: .uniqueIds)
        try container.encodeIfPresent(messageType, forKey: .messageType)
        try container.encodeIfPresent(userId, forKey: .userId)
        try container.encodeIfPresent(hashtag, forKey: .hashtag)
        
        try container.encodeIfPresent(historyTime,forKey: .historyTime)
        try container.encodeIfPresent(allMentioned,forKey: .allMentioned)
        try container.encodeIfPresent(unreadMentioned,forKey: .unreadMentioned)
        try container.encodeIfPresent(lastMessageTime,forKey: .lastMessageTime)
        try container.encodeIfPresent(audience,forKey: .audience)
        try container.encodeIfPresent(historyEndTime,forKey: .historyEndTime)
        try container.encodeIfPresent(searchInAllThread,forKey: .searchInAllThread)
        try container.encodeIfPresent(messageThreadId,forKey: .messageThreadId)
        try container.encodeIfPresent(userName,forKey: .userName)
        try container.encodeIfPresent(firstMessageId,forKey: .firstMessageId)
        try container.encodeIfPresent(lastMessageId,forKey: .lastMessageTime)
        try container.encodeIfPresent(senderId,forKey: .senderId)
    }
}
