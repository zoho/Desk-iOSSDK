//
//  ZDLayoutAPIHandler.swift
//  ZohoDeskSDK
//
//  Created by Rajeshkumar Lingavel on 23/07/18.
//

import Foundation

@objc open class ZDLayoutAPIHandler: NSObject {
    
    
    /// This API fetches an Layouts for a module.
    ///
    /// - Parameters:
    ///   - orgId: ID of the organization
    ///   - module: module name
    ///   - onCompletion: List of Layout Json
    @objc open static func getLayouts(_ orgId:String,module:String,optionalParams:Parameters = Parameters(),onCompletion:@escaping (([String:
        AnyObject]?,[ZDLayouts]?,Error?,Int)->())) -> Void{
        
        var params = optionalParams
        params["module"] = module
        let request = ZDBaseRequest(path: URLPathConstants.Layouts.getLayouts, parameters:params, headers: ["orgId":orgId])
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
            onCompletion(json,ZDLayouts.modelsFromArray(responce: json, orgId: orgId),error,status)
        }
    }
    
    
    @objc open static func getMyForm(_ orgId:String,layoutId:String = "",module:String = "",optionalParams:Parameters = Parameters(),onCompletion:@escaping (([String:
        AnyObject]?,ZDMyForm?,Error?,Int)->())) -> Void{
        var params = optionalParams
        params["layoutId"]  = layoutId
        if layoutId.isEmpty{
            params["module"]  = module
        }
        let request = ZDBaseRequest(path: URLPathConstants.Layouts.getMyForm, parameters: params, headers: ["orgId":orgId])
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
            onCompletion(json,ZDMyForm(jsonObject: json, orgId: orgId, layoutId: layoutId),error,status)
        }
    }
    
    
    
}
