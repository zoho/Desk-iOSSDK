//
//  ZDAPIExtension.swift
//  ZohoDeskSDK
//
//  Created by Rajeshkumar Lingavel on 18/05/18.
//  Copyright © 2018 rajesh-2098. All rights reserved.
//

import Foundation
@objc public class ZDAPIExtension:NSObject {
    @objc public static func makeAPIRequest(url:URL,method:String = "GET",paramType:String,parameters:Parameters,header:[String:String],onCompletion:@escaping((Data?,Error?,Int)->())){
        
        
        guard let method = Method(rawValue: method) else{
            let error = NSError(domain:"Invalid Method allowed values are GET, POST, PUT, DELETE , PATCH", code: 0, userInfo: nil)
            onCompletion(nil,error,0)
            return
        }
        guard let paramType = ParamType(rawValue:paramType) else{
            let error = NSError(domain:"Invalid Param type allowed values are json, path, data", code: 0, userInfo: nil)
            onCompletion(nil,error,0)
            return
        }
        let request = ZDBaseRequest(path: "", method: method, paramType:paramType, parameters: parameters, headers: header)
        request.baseURL = url
        request.genralAPI = true
        ZDRequestMaker.sharedInstance.makeRequest(for: request, success: { (data, statusCode) in
            onCompletion(data,nil,statusCode)
        }) { (data, error, statusCode) in
            onCompletion(data,error,statusCode)
        }
        
    }
}
