//
//  ContactsRequest.swift
//  FanapPodChatSDK
//
//  Created by Hamed Hosseini on 3/1/21.
//

import Foundation

import FanapPodAsyncSDK

public class ContactsRequest : BaseRequest {
	
	public var size       		: Int = 50
	public var offset      		: Int = 0
	//use in cashe
	public let id       			: Int? //contact id to client app can query and find a contact in cache core data with id
	public let cellphoneNumber 		: String?
	public let email           	: String?
	public let order           	: String?
	public let query           	: String?
	public var summery         	: Bool? = nil
	
	
    public init( id                   : Int?       = nil,
                 count                : Int        = 50,
                 cellphoneNumber      : String?    = nil,
                 email                : String?    = nil,
                 offset               : Int        = 0 ,
                 order                : Ordering?  = nil,
                 query                : String?    = nil,
                 summery              : Bool?      = nil,
                 uniqueId             : String?    = nil,
                 typeCode             : String?    = nil
                 ) {
		
		self.size     		 	= count
		self.offset     		= offset
		self.id         	    = id
		self.cellphoneNumber   	= cellphoneNumber
		self.email             	= email
		self.order             	= order?.rawValue ?? nil
		self.query             	= query
		self.summery           	= summery
        super.init(uniqueId: uniqueId, typeCode: typeCode)
	}
	
	private enum CodingKeys:String ,CodingKey{
		case size
		case offset
		case id
		case cellphoneNumber
		case email
		case order
		case query
		case summery
	}
	
	public override func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try? container.encodeIfPresent(size, forKey: .size)
		try? container.encodeIfPresent(offset, forKey: .offset)
		try? container.encodeIfPresent(id, forKey: .id)
		try? container.encodeIfPresent(cellphoneNumber, forKey: .cellphoneNumber)
		try? container.encodeIfPresent(email, forKey: .email)
		try? container.encodeIfPresent(order, forKey: .order)
		try? container.encodeIfPresent(summery, forKey: .summery)
		try? container.encodeIfPresent(query, forKey: .query)
	}
	
}
