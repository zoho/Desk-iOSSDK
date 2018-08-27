//
//  ZDTicketTimeEntry.swift
//  ZohoDeskSDK
//
//  Created by rajesh-2098 on 09/05/18.
//  Copyright © 2018 rajesh-2098. All rights reserved.
//

import Foundation
@objc open class ZDTicketTimeEntryAPIHandler:NSObject{
    
//    https://desk.zoho.com/DeskAPIDocument#TicketTimeEntry#TicketTimeEntry_GetaTicketTimeEntry
    @objc open static func getTicketTimeEntry(_ orgID:String = String().getZDOrgId(),ticketId:String,ticketTimeEntryId:String,addtionalParms:Parameters = Parameters(), onComplition:@escaping ((ZDTicketTimeEntry?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.TicketTimeEntry.getTicketTimeEntry,ticketId,ticketTimeEntryId),parameters:addtionalParms, headers:["orgId":orgID])
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, responceDTA, error, statusCode) in
            guard let timeEntryJson = json else{onComplition(nil,error,statusCode);return}
            onComplition(ZDTicketTimeEntry(ticketTimeEntryJson: timeEntryJson, orgId: orgID),nil, statusCode)
        }
    }
    
//    https://desk.zoho.com/DeskAPIDocument#TicketTimeEntry#TicketTimeEntry_ListTicketTimeEntries
    @objc open static func getAllTicketTimeEntries(_ orgID:String = String().getZDOrgId(),ticketId:String,optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping (([ZDTicketTimeEntry]?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.TicketTimeEntry.listAllTicketTimeEntry,ticketId), parameters: optionalParams, headers: ["orgId":orgID])
        
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, responceData, error, statusCode) in
            guard let timeEntryJson = json else{onComplition(nil,error,statusCode);return}
            onComplition(ZDTicketTimeEntry.modelsFrom(dic: timeEntryJson, orgId: orgID),nil, statusCode)
        }
    }
    
//    https://desk.zoho.com/DeskAPIDocument#TicketTimeEntry#TicketTimeEntry_AddaTicketTimeEntry
    @objc open static func addTicketTimeEntry(_ orgID:String = String().getZDOrgId(),ticketId:String,requestChargeType:String,optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping ((ZDTicketTimeEntry?,Error?,Int)->())) -> Void{
        
       let request =  ZDBaseRequest(path: String(format: URLPathConstants.TicketTimeEntry.addTicketTimeEntry,ticketId), method: .POST, paramType: .json, parameters: optionalParams, headers: ["orgId":orgID,"content-type": "application/json"])
        request.parameters["requestChargeType"] = requestChargeType
        
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, statusCode) in
            guard let timeEntryJson = json else{onComplition(nil,error,statusCode);return}
            onComplition(ZDTicketTimeEntry(ticketTimeEntryJson: timeEntryJson, orgId: orgID),nil, statusCode)
        }
    }
    
//    https://desk.zoho.com/DeskAPIDocument#TicketTimeEntry#TicketTimeEntry_UpdateaTicketTimeEntry
    @objc open static func updateTicketTimeEntry(_ orgID:String = String().getZDOrgId(),ticketId:String,ticketTimeEntryId:String,optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping ((ZDTicketTimeEntry?,Error?,Int)->())) -> Void{
        
        let request =  ZDBaseRequest(path: String(format: URLPathConstants.TicketTimeEntry.updateTicketTimeEntry,ticketId,ticketTimeEntryId), method: .POST, paramType: .json, parameters: optionalParams, headers: ["orgId":orgID,"content-type": "application/json"])

        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, statusCode) in
                guard let timeEntryJson = json else{onComplition(nil,error,statusCode);return}
                onComplition(ZDTicketTimeEntry(ticketTimeEntryJson: timeEntryJson, orgId: orgID),nil, statusCode)
        }
    }
    
//    https://desk.zoho.com/DeskAPIDocument#TicketTimeEntry#TicketTimeEntry_DeleteaTicketTimeEntry
    @objc open static func deleteTicketTimeEntry(_ orgID:String = String().getZDOrgId(),ticketID:String,ticketTimeEntryId:String,onComplition:@escaping ((Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.TicketTimeEntry.deleteTicketTimeEntry, ticketID,ticketTimeEntryId), method: .DELETE, headers: ["orgId":orgID])
        ZDRequestMaker.sharedInstance.makeRequest(for:request,
                                                  success: { (reponceData,statusCode) in
                                                    onComplition(nil, statusCode)
                                                    
        }) { (reponceData, error, statusCode) in
            onComplition(error, statusCode)
        }
    }
}
