//
//  ZDSearchAPIHandler.swift
//  ZohoDeskSDK
//
//  Created by Rajeshkumar Lingavel on 25/05/18.
//  Copyright © 2018 rajesh-2098. All rights reserved.
//

import Foundation

@objc public class ZDSearchAPIHandler: NSObject {

    @objc public static func searchAcrossEntities(_ orgId:String = String().getOrgId(),searchKeyWord:String,from:Int = 0,limit:Int = 50,optionalParams:Parameters = Parameters(),onComplition:@escaping (([String:AnyObject]?,Error?,Int)->())) -> Void{
        var params = optionalParams
        params["from"] = from as AnyObject
        params["limit"] = limit as AnyObject
        params ["searchStr"] = searchKeyWord
        
        let request = ZDBaseRequest(path: URLPathConstants.searchAcrossEntities, method: .GET, parameters: params, headers:["orgId":orgId])
        
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, data, error, statusCode) in
            onComplition(json,error,statusCode)
        }
    }
    
    @objc public static func searchTicket(_ orgId:String = String().getOrgId(),subject:String,from:Int = 0,limit:Int = 50,optionalParams:Parameters = Parameters(),onComplition:@escaping ((ZDTicketSearch?,Error?,Int)->())) -> Void{
        
        //"departmentId": departmentId
        var params = optionalParams
        params["from"] = from as AnyObject
        params["limit"] = limit as AnyObject
        params ["subject"] = subject
        
        let request = ZDBaseRequest(path: URLPathConstants.searchTicket, method: .GET, parameters: params, headers:["orgId":orgId])
        
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, data, error, statusCode) in
            guard let ticketJson = json else{onComplition(nil,nil,statusCode);return}            
            onComplition(ZDTicketSearch(json: ticketJson, orgId: orgId),nil,statusCode)
        }
    }
    
    @objc public static func searchAccount(_ orgId:String = String().getOrgId(),accountName:String,from:Int = 0,limit:Int = 50,optionalParams:Parameters = Parameters(),onComplition:@escaping ((ZDAccountSearch?,Error?,Int)->())) -> Void{
        
        //"departmentId": departmentId
        var params = optionalParams
        params["from"] = from as AnyObject
        params["limit"] = limit as AnyObject
        params ["accountName"] = accountName
        
        let request = ZDBaseRequest(path: URLPathConstants.searchAccount, method: .GET, parameters: params, headers:["orgId":orgId])
        
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, data, error, statusCode) in
            guard let accountJson = json else{onComplition(nil,nil,statusCode);return}
            onComplition(ZDAccountSearch(json: accountJson, orgId: orgId),nil,statusCode)
        }
    }
    
    @objc public static func searchContact(_ orgId:String = String().getOrgId(),lastName:String,from:Int = 0,limit:Int = 50,optionalParams:Parameters = Parameters(),onComplition:@escaping ((ZDContactSearch?,Error?,Int)->())) -> Void{
        
        //"departmentId": departmentId
        var params = optionalParams
        params["from"] = from as AnyObject
        params["limit"] = limit as AnyObject
        params ["lastName"] = lastName
        
        let request = ZDBaseRequest(path: URLPathConstants.searchContact, method: .GET, parameters: params, headers:["orgId":orgId])
        
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, data, error, statusCode) in
            guard let contactJson = json else{onComplition(nil,nil,statusCode);return}
            onComplition(ZDContactSearch(json: contactJson, orgId: orgId),nil,statusCode)
        }
    }
    
    @objc public static func searchTask(_ orgId:String = String().getOrgId(),searchKeyWord:String,from:Int = 0,limit:Int = 50,optionalParams:Parameters = Parameters(),onComplition:@escaping ((ZDTaskSearch?,Error?,Int)->())) -> Void{
        
        //"departmentId": departmentId
        var params = optionalParams
        params["from"] = from as AnyObject
        params["limit"] = limit as AnyObject
        params ["subject"] = searchKeyWord
        
        let request = ZDBaseRequest(path: URLPathConstants.searchTask, method: .GET, parameters: params, headers:["orgId":orgId])
        
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, data, error, statusCode) in
            guard let taskJson = json else{onComplition(nil,nil,statusCode);return}
            onComplition(ZDTaskSearch(json: taskJson, orgId: orgId),nil,statusCode)
        }
    }
    
}



