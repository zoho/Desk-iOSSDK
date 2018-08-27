//
//  ZDAgentProvoider.swift
//  Pods
//
//  Created by rajeshkumar.l on 30/10/17.
//
//

import Foundation

@objc open class ZDAgentAPIHandler: NSObject {
    @objc public static func getAgent(_ orgId:String = String().getZDOrgId(),agentId:String,optionalParams:[String:AnyObject], onComplition:@escaping ((ZDAgentDetail?,Error?,Int)->())) -> Void{
        let details = ZDBaseRequest(path: String(format: URLPathConstants.Agents.getAAgent, agentId),parameters:optionalParams,headers:["orgId":orgId])
        ZDBaseRequester.getJsonDicReponce(baseRequest: details) { (json, reponceData, error, status) in
            onComplition(ZDAgentDetail(orgId: orgId, agentJsonReponce: json), error, status)
        }
    }
    
    @objc open static func listAllAgents(_ orgID:String = String().getZDOrgId(),optionalParams:Parameters = Parameters(),onComplition:@escaping (([ZDAgent]?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: URLPathConstants.Agents.listAllAgent,parameters:optionalParams,headers:["orgId":orgID])
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
            onComplition(ZDAgent.modelsFrom(orgId: orgID, dic: json), error, status)
        }
    }
}
