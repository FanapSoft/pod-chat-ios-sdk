//
//  UploadManager.swift
//  Alamofire
//
//  Created by Hamed Hosseini on 4/1/21.
//

import Foundation
class UploadManager{
    
    class func upload(url:                String,
                   headers:            [String : String]?,
                   parameters:         [String : Any]?,
                   fileData:           Data?,
                   fileName:           String,
                   mimetype:           String?,
                   uniqueId:           String,
                   uploadProgress:     UploadFileProgressType?,
                   completion:         @escaping (Data? , URLResponse? , Error?) ->() ){

        guard let url = URL(string: url) else {return}
        var request = URLRequest(url: url)
        let boundary = "Boundary-\(UUID().uuidString)"
        let body = multipartFormDatas(parameters: parameters , fileName: fileName , mimeType: mimetype , fileData:fileData ,boundary: boundary)
        headers?.forEach({ key ,value in
            request.addValue(value, forHTTPHeaderField: key)
        })
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let delegate = ProgressImplementation(uploadProgress: uploadProgress)
        let session = URLSession(configuration: .default, delegate:delegate, delegateQueue: nil)
        let uploadTask = session.uploadTask(with: request, from: body as Data){ data,response,error in
            DispatchQueue.main.async {
                completion(data, response , error)
                Chat.sharedInstance.callbacksManager.removeUploadTask(uniqueId: uniqueId)
            }
        }
        uploadTask.resume()
        Chat.sharedInstance.callbacksManager.addUploadTask(task: uploadTask, uniqueId: uniqueId)
    }

    class func multipartFormDatas(parameters:[String : Any]? , fileName:String , mimeType :String? , fileData:Data? , boundary:String)-> NSMutableData{
        
        let httpBody = NSMutableData()
        parameters?.forEach{ key ,value in
            if let data = convertFormField(named: key, value: value as! String, boundary: boundary){
                httpBody.append(data)
            }
        }
        
        if let data = fileData{
            httpBody.append(convertFileData(fieldName: "file" ,fileName: fileName , mimeType: mimeType , fileData: data, boundary: boundary))
        }
        
        httpBody.append("--\(boundary)--") // close all boundary
        return httpBody
    }
    
    class func convertFileData(fieldName: String , fileName:String , mimeType:String? , fileData:Data, boundary: String) -> Data {
        let data = NSMutableData()
        let lineBreak = "\r\n"
        let mimeType = mimeType ?? "content-type header"
        data.append("--\(boundary + lineBreak)")
        data.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\(lineBreak)")
        data.append("Content-Type: \(mimeType + lineBreak + lineBreak)")
        data.append(fileData)
        data.append(lineBreak)
        return data as Data
    }
    
    class func convertFormField(named name: String, value: String,boundary: String) -> Data? {
        let lineBreak = "\r\n"
        var fieldString = "--\(boundary + lineBreak)"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\(lineBreak + lineBreak)"
        fieldString += value + lineBreak
        return fieldString.data(using: .utf8)
    }
}

extension NSMutableData {
  func append(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}
