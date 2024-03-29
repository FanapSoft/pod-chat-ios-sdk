//
//  QueueOfUploadImages+extenstions.swift
//  FanapPodChatSDK
//
//  Created by Hamed Hosseini on 3/2/21.
//

import Foundation

extension QueueOfUploadImages{
    
    public static let crud = CoreDataCrud<QueueOfUploadImages>(entityName: "QueueOfUploadImages")
    
    public func getCodable() -> NewUploadImageRequest?{
        
        guard let fileData = dataToSend as Data? else{return nil}
        let uploadRequest = NewUploadImageRequest(data          : fileData,
                                                  xC            : (xC as? Int) ?? 0,
                                                  yC            : (yC as? Int) ?? 0,
                                                  hC            : (hC as? Int) ?? 0,
                                                  wC            : (wC as? Int) ?? 0,
                                                  fileExtension : fileExtension,
                                                  fileName      : fileName,
                                                  mimeType      : mimeType,
                                                  originalName  : originalName,
                                                  userGroupHash : userGroupHash,
                                                  typeCode      : typeCode,
                                                  uniqueId      : uniqueId)
        return uploadRequest
    }
    
    public class func convertFileToCM(request:NewUploadImageRequest ,entity:QueueOfUploadImages? = nil) -> QueueOfUploadImages{
        
        let model            = entity ?? QueueOfUploadImages()
        
        model.dataToSend    = request.data as NSData
        model.fileExtension = request.fileExtension
        model.fileName      = request.fileName
        model.isPublic      = request.isPublic as NSNumber?
        model.mimeType      = request.mimeType
        model.originalName  = request.originalName
        model.userGroupHash = request.userGroupHash
        model.typeCode      = request.typeCode
        model.fileSize      = request.fileSize as NSNumber?
        model.xC            = request.xC as NSNumber?
        model.yC            = request.yC as NSNumber?
        model.hC            = request.hC as NSNumber?
        model.wC            = request.wC as NSNumber?
        model.uniqueId      = request.uniqueId
        
        return model
    }
    
    public class func insert(request:NewUploadImageRequest , resultEntity:((QueueOfUploadImages)->())? = nil){
        if let entity = QueueOfUploadImages.crud.find(keyWithFromat: "uniqueId == %@", value: request.uniqueId){
            resultEntity?(entity)
            return
        }
        QueueOfUploadImages.crud.insert { cmEntity in
            let cmEntity = convertFileToCM(request: request , entity: cmEntity)
            resultEntity?(cmEntity)
        }
    }
    
}
