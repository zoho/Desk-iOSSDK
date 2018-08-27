//
//  ZDAgentSignaturesAPIHandler.swift
//  Pods-DeskSDKDemo
//
//  Created by Rajeshkumar Lingavel on 30/07/18.
//

import Foundation
@objc open class ZDAgentSignaturesAPIHelper: NSObject {
    
    @objc open static func getSignaturesOfAgent(_ orgID:String = String().getZDOrgId(),agentID:String,optionalParam:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping ((ZDAgentSignatures?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.AgentSignatures.getAgentSignatures, agentID),parameters:optionalParam,headers:["orgId":orgID])
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
            onComplition(ZDAgentSignatures(json: json, orgId: orgID), error, status)
        }
    }
    
    @objc open static func updateSignaturesOfAgent(_ orgID:String = String().getZDOrgId(),agentID:String,signature:[String:AnyObject],onComplition:@escaping ((ZDAgentSignatures?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.AgentSignatures.updateAgentSignatures, agentID),method:.PATCH,paramType:.json, parameters:signature,headers:["orgId":orgID])
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
            onComplition(ZDAgentSignatures(json: json, orgId: orgID), error, status)
        }
    }
    
    @objc open static func updateCustomizedSignatureOfAgent(_ orgID:String = String().getZDOrgId(),agentID:String,customSignature:[String:AnyObject],onComplition:@escaping ((ZDAgentSignatures?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.AgentSignatures.updateCustomizedSignature, agentID),method:.POST,paramType:.json,parameters:customSignature,headers:["orgId":orgID])
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
                onComplition(ZDAgentSignatures(json: json, orgId: orgID), error, status)
        }
    }
    
}
