//
//  UpdateThreadInfoRequestHandler.swift
//  FanapPodChatSDK
//
//  Created by Hamed Hosseini on 2/23/21.
//

import Foundation
import FanapPodAsyncSDK
import Alamofire
import SwiftyJSON


public class UpdateThreadInfoRequestHandler  {
    
    private let chat:Chat
    private let req:NewUpdateThreadInfoRequest
    private let completion:CompletionType<Conversation>
    private let uploadProgress: UploadProgressType
    private let clientSpecificUniqueId:String?
    private let uniqueIdResult:UniqueIdResultType
    private let messageType:NewChatMessageVOTypes
    private let typeCode:String?
    private var uploadProgressValue: Float = 0
    private var calculatedUniqueId:String
    
    public init (_ chat:Chat ,
                 _ req:NewUpdateThreadInfoRequest ,
                 _ uploadProgress:@escaping UploadProgressType ,
                 _ completion:@escaping CompletionType<Conversation> ,
                 _ uniqueIdResult: UniqueIdResultType = nil ,
                 _ messageType:NewChatMessageVOTypes){
        
        self.chat = chat
        self.req = req
        self.completion = completion
        self.messageType = messageType
        self.uniqueIdResult = uniqueIdResult
		self.typeCode = req.typeCode
        self.uploadProgress = uploadProgress
		self.clientSpecificUniqueId = req.uniqueId
        self.calculatedUniqueId = UUID().uuidString
    }
    
    func handle(){
        calculatedUniqueId = clientSpecificUniqueId ?? UUID().uuidString
        uniqueIdResult?(calculatedUniqueId)
        if let _ = req.threadImage{
            uploadImageAndGetResponse()
        }else{
            //update directly without metadata
            updateThreadInfo()
        }
    }
    
    func updateThreadInfo(_ uploadImageModel:UploadImageResponse? = nil) {
        guard let config = chat.config else {return}
        guard let reqContent = req.convertCodableToString() else{return}
        let chatMessage = NewSendChatMessageVO(type:  ChatMessageVOTypes.UPDATE_THREAD_INFO.intValue(),
                                            token:              config.token,
                                            content:            "\(reqContent)",
                                            subjectId:          req.threadId,
                                            typeCode:           typeCode ?? config.typeCode,
                                            uniqueId:           calculatedUniqueId)
        guard let content = chatMessage.convertCodableToString() else{return}
        let asyncMessage = NewSendAsyncMessageVO(content:      content,
                                              ttl: config.msgTTL,
                                              peerName:     config.serverName,
                                              priority:     config.msgPriority)

        chat.callbacksManager.addCallback(uniqueId: calculatedUniqueId, requesType: .UPDATE_THREAD_INFO){ response in
            self.completion(response.result as? Conversation , response.uniqueId, response.error)
        }
        chat.sendToAsync(asyncMessageVO: asyncMessage)
    }
    
    func uploadImageAndGetResponse(){
        guard let config = chat.config , let imageRequest = req.threadImage else {return}
        log.verbose("Try to upload image with this parameters: \n \(imageRequest)", context: "Chat")
        sendToCasheQueee()

        let path = imageRequest.userGroupHash != nil ? "\(SERVICES_PATH.PODSPACE_PUBLIC_UPLOAD_IMAGE.rawValue)" : "\(SERVICES_PATH.PODSPACE_UPLOAD_IMAGE.rawValue)"
        let url = "\(config.podSpaceFileServerAddress)" + path
        let headers:HTTPHeaders = ["_token_"        : config.token,
                                   "_token_issuer_" : "1",
                                   "Content-type"   : "multipart/form-data"]
        
        
        Networking.sharedInstance.upload(toUrl:             url,
                                         withHeaders:       headers,
                                         withParameters:    imageRequest.convertContentToParameters(),
                                         isImage:           true,
                                         isFile:            false,
                                         dataToSend:        imageRequest.dataToSend,
                                         uniqueId:          imageRequest.uniqueId,
                                         progress:
                                            { [weak self] (myProgress) in
                                                self?.notifyUploadProgress(myProgress)
                                            }) { (response) in
            let myResponse: JSON = response as! JSON
            let hasError        = myResponse["hasError"].boolValue
            let errorMessage    = myResponse["message"].stringValue
            let errorCode       = myResponse["errorCode"].intValue
            self.notifyResult( myResponse: myResponse , errorCode: errorCode, errorMessage: errorMessage, hasError: hasError)
        }
    }
    
    private func notifyResult(myResponse:JSON, errorCode:Int ,errorMessage:String , hasError:Bool){
        let success = !hasError
        guard  let imageRequest = req.threadImage else {return}
        if success{
            downloadUploadedImageToCashe(resultData: myResponse["result"])
        }
        let fileInfo = FileInfo(fileName: imageRequest.fileName, fileSize: imageRequest.fileSize)
        let uploadEvent = FileUploadEventModel(type:          success ? .UPLOADING : .UPLOAD_ERROR,
                                               errorCode:       errorCode,
                                               errorMessage:    errorMessage,
                                               errorEvent:      nil,
                                               fileInfo:        fileInfo,
                                               fileObjectData:  success ? nil : imageRequest.dataToSend,
                                               progress:        self.uploadProgressValue,
                                               userGroupHash:   imageRequest.userGroupHash,
                                               uniqueId:        imageRequest.uniqueId)
        Chat.sharedInstance.delegate?.fileUploadEvents(model: uploadEvent)
        
        let uploadImageModel = UploadImageResponse(messageContentJSON: success ? myResponse["result"] : nil,
                                                   errorCode:           errorCode,
                                                   errorMessage:        errorMessage,
                                                   hasError:            hasError)
        updateThreadInfo(uploadImageModel)
    }
    
    private func downloadUploadedImageToCashe(resultData:JSON){
        guard let config = chat.config , let imageRequest = req.threadImage else{return}
        if config.enableCache {
            // save data comes from server to the Cache
            let uploadImageFile = ImageObject(messageContent: resultData)
            Chat.cacheDB.saveImageObject(imageInfo: uploadImageFile, imageData: imageRequest.dataToSend, toLocalPath: config.localImageCustomPath)
            let getImageRequest = GetImageRequest(//imageId:  uploadImageFile.id,
                hashCode: uploadImageFile.hashCode,
                quality:  nil,
                crop:     nil,
                size:     nil,
                serverResponse: true)
            sendRequestToDownloadImage(chat:chat,
                                       withInputModel: getImageRequest,
                                       progress:       { _ in },
                                       completion:     { (_, _) in })
            Chat.cacheDB.deleteWaitUploadImages(uniqueId: imageRequest.uniqueId)
        }
    }
    
    private func notifyUploadProgress(_ uploadProgress:Float){
        guard let imageRequest = req.threadImage else {return}
        self.uploadProgressValue = uploadProgress
        let fileInfo = FileInfo(fileName: imageRequest.fileName,
                                fileSize: imageRequest.fileSize)
        let fUploadedEM = FileUploadEventModel(type:            FileUploadEventTypes.UPLOADING,
                                               errorCode:       nil,
                                               errorMessage:    nil,
                                               errorEvent:      nil,
                                               fileInfo:        fileInfo,
                                               fileObjectData:  nil,
                                               progress:        uploadProgress,
                                               userGroupHash:   imageRequest.userGroupHash,
                                               uniqueId:        imageRequest.uniqueId)
        Chat.sharedInstance.delegate?.fileUploadEvents(model: fUploadedEM)
        self.uploadProgress(uploadProgress)
    }
    
    private func sendToCasheQueee(){
        guard let imageRequest = req.threadImage else {return}
        if (chat.config?.enableCache == true) {
            /**
             seve this upload image on the Cache Wait Queue,
             so if there was an situation that response of the server to this uploading doesn't come, then we know that our upload request didn't sent correctly
             and we will send this Queue to user on the GetHistory request,
             now user knows which upload requests didn't send correctly, and can handle them
             */
            let messageObjectToSendToQueue = QueueOfWaitUploadImagesModel(dataToSend:      imageRequest.dataToSend,
                                                                          fileExtension:   imageRequest.fileExtension,
                                                                          fileName:        imageRequest.fileName,
                                                                          fileSize:        imageRequest.fileSize,
                                                                          isPublic:        imageRequest.isPublic,
                                                                          mimeType:        imageRequest.mimeType,
                                                                          originalName:    imageRequest.originalName,
                                                                          userGroupHash:   imageRequest.userGroupHash,
                                                                          xC:              imageRequest.xC,
                                                                          yC:              imageRequest.yC,
                                                                          hC:              imageRequest.hC,
                                                                          wC:              imageRequest.wC,
                                                                          typeCode:        imageRequest.typeCode,
                                                                          uniqueId:        imageRequest.uniqueId)
            Chat.cacheDB.saveUploadImageToWaitQueue(image: messageObjectToSendToQueue)
        }
    }
    
    private func sendRequestToDownloadImage(chat:Chat,
                                            withInputModel getImageInput: GetImageRequest,
                                            progress:      @escaping (Float) -> (),
                                            completion:    @escaping (Data?, DownloadImageModel) -> ()) {
        guard let fileServer = chat.config?.fileServer else {return}
        let url = "\(fileServer)\(SERVICES_PATH.DRIVE_DOWNLOAD_IMAGE.rawValue)"
        let method:     HTTPMethod  = HTTPMethod.get
        let headers:    HTTPHeaders = ["_token_": chat.config?.token ?? "", "_token_issuer_": "1"]
        
        Networking.sharedInstance.download(fromUrl:         url,
                                           withMethod:      method,
                                           withHeaders:     headers,
                                           withParameters:  getImageInput.convertContentToParameters()
        , progress: { (myProgress) in
            progress(myProgress)
        }) { (imageDataResponse, responseHeader)  in
            if let myData = imageDataResponse {
                // save data comes from server to the Cache
                let fileName = responseHeader["name"].string
                let fileType = responseHeader["type"].string
                let fileSize = responseHeader["size"].int
                let theFinalFileName = "\(fileName ?? "default").\(fileType ?? "none")"
                let uploadImage = ImageObject(actualHeight: nil,
                                              actualWidth:  nil,
                                              hashCode:     getImageInput.hashCode,
                                              height:       nil,
//                                              id:           getImageInput.imageId,
                                              name:         theFinalFileName,
                                              size:         fileSize ?? myData.count,
                                              width:        nil)
                
                if chat.config?.enableCache == true {
                    if UpdateThreadInfoRequestHandler.checkIfDeviceHasFreeSpace(needSpaceInMB: Int64(myData.count / 1024), turnOffTheCache: true, errorDelegate: chat.delegate) {
                        if getImageInput.quality == 0.123 {
                            Chat.cacheDB.saveThumbnailImageObject(imageInfo: uploadImage, imageData: myData, toLocalPath: chat.config?.localImageCustomPath)
                        } else {
                            Chat.cacheDB.saveImageObject(imageInfo: uploadImage, imageData: myData, toLocalPath: chat.config?.localImageCustomPath)
                        }
                    }
                }
                
                let uploadImageModel = DownloadImageModel(messageContentModel: uploadImage, errorCode: 0, errorMessage: "", hasError: false)
                completion(myData, uploadImageModel)
            } else {
                let errorUploadImageModel = DownloadImageModel(messageContentModel: nil,
                                                               errorCode:           responseHeader["errorCode"].int ?? 999,
                                                               errorMessage:        responseHeader["errorMessage"].string ?? "",
                                                               hasError:            responseHeader["hasError"].bool ?? false)
                completion(nil, errorUploadImageModel)
            }
        }
    }
    
    class func checkIfDeviceHasFreeSpace(needSpaceInMB: Int64, turnOffTheCache: Bool , errorDelegate:ChatDelegates?) -> Bool {
        let availableSpace = DiskStatus.freeDiskSpaceInBytes
        if availableSpace < (needSpaceInMB * 1024 * 1024) {
            var message = "your disk space is less than \(DiskStatus.MBFormatter(DiskStatus.freeDiskSpaceInBytes))MB."
            if turnOffTheCache {
                message += " " + "so, the cache will be switch OFF!"
            }
            if Chat.sharedInstance.config?.useNewSDK == true{
                (errorDelegate as? NewChatDelegate)?.chatError(error: .init(code: .OUT_OF_STORAGE, message: message))
            }else{
                errorDelegate?.chatError(errorCode: 6401, errorMessage: message, errorResult: nil)
            }
            return false
        } else {
            return true
        }
    }
    
}
