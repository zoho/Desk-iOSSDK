//
//  ZDAccountsProvoider.swift
//  Pods
//
//  Created by rajeshkumar.l on 30/10/17.
//
//

import Foundation

@objc public class ZDAccountAPIHandler: NSObject {
    
//    https://desk.zoho.com/DeskAPIDocument#Accounts#Accounts_Getanaccount
    @objc public static func getAccount(_ orgID:String = String().getOrgId(),accountId:String,onComplition:@escaping ((ZDAccountDetail?,[String:AnyObject]?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.getAAccounts, accountId),headers:["orgId":orgID])
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
            onComplition(ZDAccountDetail(accountJsonReponce: json, orgId: orgID),json,error, status)
        }
    }
    
//    https://desk.zoho.com/DeskAPIDocument#Accounts#Accounts_Listallaccounts
    @objc public static func listAllAccounts(_ orgID:String = String().getOrgId(),from:Int = 0,limit:Int = 50,optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping (([ZDAccount]?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: URLPathConstants.listAllAccounts, parameters: optionalParams, headers: ["orgId":orgID])
        request.parameters["from"] = from
        request.parameters["limit"] = limit
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
            onComplition(ZDAccount.modelsFromArray(dic: json, orgId: orgID), error, status)
        }
    }
 
//    https://desk.zoho.com/DeskAPIDocument#Accounts#Accounts_Createanaccount
    @objc public static func createAnAccount(_ orgID:String = String().getOrgId(),accountName:String,optionalParams:Parameters = Parameters(),onComplition:@escaping ((ZDAccount?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.createAccounts), method: .POST, paramType: .json, parameters: optionalParams, headers: ["orgId":orgID])
        request.parameters["accountName"] = accountName
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
            onComplition(ZDAccount(accountJsonReponce: json, orgId: orgID), error, status)
        }
        
    }
    
//    https://desk.zoho.com/DeskAPIDocument#Accounts#Accounts_Updateanaccount
    @objc public static func updateAnAccount(_ orgID:String = String().getOrgId(),accountId:String,optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping ((ZDAccount?,Error?,Int)->())) -> Void{
  
        let request = ZDBaseRequest(path: String(format: URLPathConstants.createAccounts), method: .POST, paramType: .json, parameters: optionalParams, headers: ["orgId":orgID])
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
            onComplition(ZDAccount(accountJsonReponce: json, orgId: orgID), error, status)
        }
    }
    
    @objc public static func getTicketsByAccount(_ orgId:String = String().getOrgId(),accountId:String,from:Int = 0,limit:Int = 50,optionalParams:Parameters = Parameters(),onComplition:@escaping (([ZDTicket]?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.getTicketsByAccount,accountId), method: .POST, paramType: .json, parameters: optionalParams, headers: ["orgId":orgId])
        request.parameters["from"] = from
        request.parameters["limit"] = limit
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, statusCode) in
            guard let ticketListJson = json else{onComplition(nil,error,statusCode);return}
            onComplition(ZDTicket.modelsFromDictionary(dictionary: ticketListJson, orgId: orgId),error,statusCode)
        }
    }
    
}
