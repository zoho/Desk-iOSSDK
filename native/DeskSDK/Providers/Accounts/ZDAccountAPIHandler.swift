//
//  ZDAccountsProvoider.swift
//  Pods
//
//  Created by rajeshkumar.l on 30/10/17.
//
//

import Foundation

@objc open class ZDAccountAPIHandler: NSObject {
    
    /// This API fetches an account from your helpdesk.
    ///    https://desk.zoho.com/DeskAPIDocument#Accounts#Accounts_Getanaccount
    /// - Parameters:
    ///   - orgID: Unique Organiazation ID
    ///   - accountId: Unique Account ID
    ///   - onComplition: Oncomplition data will Account Detail object or Error message and status code of the reponce.
    @objc open static func getAccount(_ orgID:String = String().getZDOrgId(),accountId:String,onComplition:@escaping ((ZDAccountDetail?,[String:AnyObject]?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.Accounts.getAAccounts, accountId),headers:["orgId":orgID])
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
            onComplition(ZDAccountDetail(accountJsonReponce: json, orgId: orgID),json, error, status)
        }
    }
    
//
    
    /// This API lists all accounts in your helpdesk.
    /// https://desk.zoho.com/DeskAPIDocument#Accounts#Accounts_Listallaccounts
    /// - Parameters:
    ///   - orgID: Unique Organiazation ID
    ///   - from: From index
    ///   - limit: No. of accounts to fetch
    ///   - optionalParams:  Additional params for customized result
    ///   - onComplition: Oncomplition data will arry of Account  object or Error message and status code of the reponce.
    @objc open static func listAllAccounts(_ orgID:String = String().getZDOrgId(),optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping (([ZDAccount]?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: URLPathConstants.Accounts.listAllAccounts, parameters: optionalParams, headers: ["orgId":orgID])
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
            onComplition(ZDAccount.modelsFromArray(dic: json, orgId: orgID), error, status)
        }
    }
 
    
    /// This API creates an account in your helpdesk.
    ///  https://desk.zoho.com/DeskAPIDocument#Accounts#Accounts_Createanaccount
    /// - Parameters:
    ///   - orgID: Unique Organiazation ID
    ///   - accountName: Name of the account
    ///   - optionalParams: Additional params for customized result
    ///   - onComplition: Oncomplition data will Account object or Error message and status code of the reponce.
    @objc open static func createAnAccount(_ orgID:String = String().getZDOrgId(),accountName:String,optionalParams:Parameters = Parameters(),onComplition:@escaping ((ZDAccount?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.Accounts.createAccounts), method: .POST, paramType: .json, parameters: optionalParams, headers: ["orgId":orgID])
        request.parameters["accountName"] = accountName
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
            onComplition(ZDAccount(accountJsonReponce: json, orgId: orgID), error, status)
        }
        
    }
    
//    https://desk.zoho.com/DeskAPIDocument#Accounts#Accounts_Updateanaccount
    
    /// This API updates details of an existing account.
    /// https://desk.zoho.com/DeskAPIDocument#Accounts#Accounts_Updateanaccount
    /// - Parameters:
    ///   - orgID:  Unique Organiazation ID
    ///   - accountId: Unique Account ID
    ///   - optionalParams: Additional params for customized result
    ///   - onComplition: Oncomplition data will Account object or Error message and status code of the reponce.
    @objc open static func updateAnAccount(_ orgID:String = String().getZDOrgId(),accountId:String,optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping ((ZDAccount?,Error?,Int)->())) -> Void{
  
        let request = ZDBaseRequest(path: String(format: URLPathConstants.Accounts.createAccounts), method: .POST, paramType: .json, parameters: optionalParams, headers: ["orgId":orgID])
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
            onComplition(ZDAccount(accountJsonReponce: json, orgId: orgID), error, status)
        }
    }
    
    
    /// This API lists tickets received from a specific account.
    ///
    /// - Parameters:
    ///   - orgId: Unique Organiazation ID
    ///   - accountId: Unique Account ID
    ///   - from: From index
    ///   - limit: No. of accounts to fetch
    ///   - optionalParams: Additional params for customized result
    ///   - onComplition: Oncomplition data will Array of ticket object or Error message and status code of the reponce.
    @objc open static func getTicketsByAccount(_ orgId:String = String().getZDOrgId(),accountId:String,optionalParams:Parameters = Parameters(),onComplition:@escaping (([ZDTicket]?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.Accounts.getTicketsByAccount,accountId), method: .POST, paramType: .json, parameters: optionalParams, headers: ["orgId":orgId])
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, statusCode) in
            guard let ticketListJson = json else{onComplition(nil,error,statusCode);return}
            onComplition(ZDTicket.modelsFromDictionary(dictionary: ticketListJson, orgId: orgId),error,statusCode)
        }
    }
    
}
