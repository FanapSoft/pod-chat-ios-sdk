//
//  CreateThreadWithFileMessageRequestModel.swift
//  FanapPodChatSDK
//
//  Created by MahyarZhiani on 10/11/1398 AP.
//  Copyright © 1398 Mahyar Zhiani. All rights reserved.
//

import Foundation

open class CreateThreadWithFileMessageRequestModel {
    
    let creatThreadWithMessageInput:    CreateThreadWithMessageRequestModel
    let uploadInput:                    UploadRequestModel
    
//    let uploadfileInput:                UploadFileRequestModel?
//    let uploadImageInput:               UploadImageRequestModel?
    
    init(creatThreadWithMessageInput:   CreateThreadWithMessageRequestModel,
//         uploadfileInput:               UploadFileRequestModel?,
//         uploadImageInput:              UploadImageRequestModel?
         uploadInput:                   UploadRequestModel) {
        
        self.creatThreadWithMessageInput    = creatThreadWithMessageInput
//        self.uploadfileInput                = uploadfileInput
//        self.uploadImageInput               = uploadImageInput
        self.uploadInput                    = uploadInput
    }
    
}
