//
//  ZDAgentProvoider.swift
//  Pods
//
//  Created by rajeshkumar.l on 30/10/17.
//
//

import Foundation

@objc public class ZDAgentAPIHandler: NSObject {
    @objc public static func getAgent(_ orgId:String = String().getOrgId(),agentId:String,optionalParams:[String:AnyObject], onComplition:@escaping ((ZDAgentDetail?,Error?,Int)->())) -> Void{
        let details = ZDBaseRequest(path: String(format: URLPathConstants.getAAgent, agentId),parameters:optionalParams,headers:["orgId":orgId])
        ZDBaseRequester.getJsonDicReponce(baseRequest: details) { (json, reponceData, error, status) in
            onComplition(ZDAgentDetail(orgId: orgId, agentJsonReponce: json), error, status)
        }
    }
    
    @objc public static func listAllAgents(_ orgID:String = String().getOrgId(),from:Int = 0,limit:Int = 50,optionalParams:Parameters = Parameters(),onComplition:@escaping (([ZDAgent]?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: URLPathConstants.listAllAgent,parameters:optionalParams,headers:["orgId":orgID])
        request.parameters["from"] = from
        request.parameters["limit"] = limit
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
            onComplition(ZDAgent.modelsFrom(orgId: orgID, dic: json), error, status)
        }
    }
}
