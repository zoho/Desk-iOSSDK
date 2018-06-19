//
//  ZDContractsProvoider.swift
//  ZohoDeskSDK
//
//  Created by rajesh-2098 on 09/05/18.
//  Copyright © 2018 rajesh-2098. All rights reserved.
//

import Foundation

//Contracts help you organize your desk commitments, enabling you to deliver more professional and dedicated customer service. By defining contracts, you can determine the level of service to offer and set the contract period for an account or a product.
@objc public class ZDContractAPIHandler:NSObject{
    
    @objc public static func getContract(_ orgId:String = String().getOrgId(),contractId:String,onComplition:@escaping ((ZDContract?,[String:AnyObject]?,Error?,Int)->())) -> Void {
        let request = ZDBaseRequest(path: String(format: URLPathConstants.getAContact,contractId), headers: ["orgId":orgId])
        
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, data, error, statusCode) in
            guard let contractJson = json else{onComplition(nil,json,error,statusCode);return}
            onComplition(ZDContract(json: contractJson, orgId: orgId),json,error,statusCode)
        }
    }
    
    @objc public static func listAllContracts(_ orgID:String = String().getOrgId(),from:Int = 0,limit:Int = 50,optionalParams:Parameters = Parameters(),onComplition:@escaping (([ZDContract]?,Error?,Int)->())) -> Void {
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.listAllContracts),parameters:optionalParams, headers: ["orgId":orgID])
        request.parameters["from"] = from
        request.parameters["limit"] = limit
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, data, error, statusCode) in
            guard let contractJson = json else{onComplition(nil,error,statusCode);return}
            onComplition(ZDContract.modelsFromDArray(json: contractJson, orgId: orgID),error,statusCode)
        }
    }
    
}
