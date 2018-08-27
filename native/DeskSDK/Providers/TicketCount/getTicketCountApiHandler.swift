//
//  File.swift
//  ZohoDeskSDK
//
//  Created by Rajeshkumar Lingavel on 20/08/18.
//  Copyright © 2018 rajesh-2098. All rights reserved.
//

import Foundation
@objc open class getTicketCountApiHandler : NSObject{
    
    @objc open static func getTicketCount(_ orgId:String = String().getZDOrgId(),optionalParams:Parameters = Parameters(),onComplition:@escaping ((ZDTicketsCount?,Error?,Int)->())) -> Void {
        let request = ZDBaseRequest(path: String(format: URLPathConstants.TicketCount.getTicketCount),parameters:optionalParams, headers: ["orgId":orgId])
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, data, error, statusCode) in
            onComplition(ZDTicketsCount(json: json),error,statusCode)
        }
    }
    @objc open static func getTicketCountByField(_ orgId:String = String().getZDOrgId(),fieldName:String,optionalParams:Parameters = Parameters(),onComplition:@escaping (([String:AnyObject]?,Error?,Int)->())) -> Void {
        let request = ZDBaseRequest(path: String(format: URLPathConstants.TicketCount.getTicketCountByField),parameters:optionalParams, headers: ["orgId":orgId])
        request.parameters["fieldName"] = fieldName
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, data, error, statusCode) in
            onComplition(json,error,statusCode)
        }
    }
}
