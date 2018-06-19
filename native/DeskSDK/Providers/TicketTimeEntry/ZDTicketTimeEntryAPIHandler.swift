//
//  ZDTicketTimeEntry.swift
//  ZohoDeskSDK
//
//  Created by rajesh-2098 on 09/05/18.
//  Copyright © 2018 rajesh-2098. All rights reserved.
//

import Foundation
@objc public class ZDTicketTimeEntryAPIHandler:NSObject{
    
//    https://desk.zoho.com/DeskAPIDocument#TicketTimeEntry#TicketTimeEntry_GetaTicketTimeEntry
    @objc public static func getTicketTimeEntry(_ orgID:String = String().getOrgId(),ticketId:String,ticketTimeEntryId:String,addtionalParms:Parameters = Parameters(), onComplition:@escaping ((ZDTicketTimeEntry?,[String:AnyObject]?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.getTicketTimeEntry,ticketId,ticketTimeEntryId),parameters:addtionalParms, headers:["orgId":orgID])
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, responceDTA, error, statusCode) in
            guard let timeEntryJson = json else{onComplition(nil,json,error,statusCode);return}
            onComplition(ZDTicketTimeEntry(ticketTimeEntryJson: timeEntryJson, orgId: orgID),timeEntryJson,nil, statusCode)
        }
    }
    
//    https://desk.zoho.com/DeskAPIDocument#TicketTimeEntry#TicketTimeEntry_ListTicketTimeEntries
    @objc public static func getAllTicketTimeEntries(_ orgID:String = String().getOrgId(),ticketId:String,optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping (([ZDTicketTimeEntry]?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.listAllTicketTimeEntry,ticketId), parameters: optionalParams, headers: ["orgId":orgID])
        
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, responceData, error, statusCode) in
            guard let timeEntryJson = json else{onComplition(nil,error,statusCode);return}
            onComplition(ZDTicketTimeEntry.modelsFrom(dic: timeEntryJson, orgId: orgID),nil, statusCode)
        }
    }
    
//    https://desk.zoho.com/DeskAPIDocument#TicketTimeEntry#TicketTimeEntry_AddaTicketTimeEntry
    @objc public static func addTicketTimeEntry(_ orgID:String = String().getOrgId(),ticketId:String,requestChargeType:String,optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping ((ZDTicketTimeEntry?,Error?,Int)->())) -> Void{
        
       let request =  ZDBaseRequest(path: String(format: URLPathConstants.addTicketTimeEntry,ticketId), method: .POST, paramType: .json, parameters: optionalParams, headers: ["orgId":orgID,"content-type": "application/json"])
        request.parameters["requestChargeType"] = requestChargeType
        
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, statusCode) in
            guard let timeEntryJson = json else{onComplition(nil,error,statusCode);return}
            onComplition(ZDTicketTimeEntry(ticketTimeEntryJson: timeEntryJson, orgId: orgID),nil, statusCode)
        }
    }
    
//    https://desk.zoho.com/DeskAPIDocument#TicketTimeEntry#TicketTimeEntry_UpdateaTicketTimeEntry
    @objc public static func updateTicketTimeEntry(_ orgID:String = String().getOrgId(),ticketId:String,ticketTimeEntryId:String,optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping ((ZDTicketTimeEntry?,Error?,Int)->())) -> Void{
        
        let request =  ZDBaseRequest(path: String(format: URLPathConstants.updateTicketTimeEntry,ticketId,ticketTimeEntryId), method: .POST, paramType: .json, parameters: optionalParams, headers: ["orgId":orgID,"content-type": "application/json"])

        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, statusCode) in
                guard let timeEntryJson = json else{onComplition(nil,error,statusCode);return}
                onComplition(ZDTicketTimeEntry(ticketTimeEntryJson: timeEntryJson, orgId: orgID),nil, statusCode)
        }
    }
    
//    https://desk.zoho.com/DeskAPIDocument#TicketTimeEntry#TicketTimeEntry_DeleteaTicketTimeEntry
    @objc public static func deleteTicketTimeEntry(_ orgID:String = String().getOrgId(),ticketID:String,ticketTimeEntryId:String,onComplition:@escaping ((Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.deleteTicketTimeEntry, ticketID,ticketTimeEntryId), method: .DELETE, headers: ["orgId":orgID])
        ZDRequestMaker.sharedInstance.makeRequest(for:request,
                                                  success: { (reponceData,statusCode) in
                                                    onComplition(nil, statusCode)
                                                    
        }) { (reponceData, error, statusCode) in
            onComplition(error, statusCode)
        }
    }
}
