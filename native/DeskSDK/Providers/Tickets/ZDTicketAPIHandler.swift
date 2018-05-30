//
//  ZDTicketProvoider.swift
//  Pods
//
//  Created by rajeshkumar.l on 17/10/17.
//
//

import Foundation

//Tickets
//Tickets are organizing units using which service agents handle customer enquiries, requests, complaints, and other such interactions in Zoho Desk.
@objc public class ZDTicketAPIHandler: NSObject {}

extension ZDTicketAPIHandler{
    
    /// This API fetches a single ticket from your helpdesk.
    ///
    /// - Parameters:
    ///   - orgID: Unique ID of the Organization
    ///   - ticketId: Unique ID of the ticket
    ///   - include: Zoho Desk enables you to retrieve different related resources through a single API request, which is made possible by the include query param. This query param takes a comma separated list of values corresponding to the API.
    ///   - optionalParams: optional params provoided by developer
    ///   - onCompletion: Oncomplition data will ticket object or Error message and status code of the reponce.
    @objc public static func getTicketDetails(_ orgID:String = String().getOrgId(),ticketId:String,include:String = "",optionalParams:Parameters = Parameters(),onCompletion:@escaping((ZDTicketDetail?,Error?,Int)->())) -> Void{
        
       let request =  ZDBaseRequest(path: String(format: URLPathConstants.getATicket, ticketId), parameters: optionalParams, headers: ["orgId":orgID])
        request.parameters["include"] = include
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, data, error, status) in
            guard let ticketDetailsJson = json else{onCompletion(nil,error,status);return}
            onCompletion(ZDTicketDetail(ticketDetailJsonObject: ticketDetailsJson, orgId: orgID),error,status)
        }
    }

    
    /// This API lists all tickets in your helpdesk.
    ///   for more details https://desk.zoho.com/DeskAPIDocument#Tickets#Tickets_Listalltickets
    /// - Parameters:
    ///   - orgID: Unique ID of the Organization
    ///   - from: From index
    ///   - limit: No. of tickets to fetch
    ///   - optionalParams: optional params provoided by developer
    ///   - onCompletion: Oncomplition data will ticket object or Error message and status code of the reponce.
    @objc public static func getAllTickets(_ orgID:String = String().getOrgId(),
                                     from:Int = 0,limit:Int = 50,
                                     optionalParams:Parameters = Parameters(),
                                     onCompletion:@escaping(([ZDTicket]?,Error?,Int)->())) -> Void{
        let request = ZDBaseRequest(path: URLPathConstants.listAllTickets, parameters: optionalParams, headers: ["orgId":orgID])
        request.parameters["from"] = from
        request.parameters["limit"] = limit
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, data, error, statusCode) in
            guard let ticketListJson = json else{onCompletion(nil,error, statusCode);return}
            onCompletion(ZDTicket.modelsFromDictionary(dictionary: ticketListJson, orgId: orgID),error,statusCode)
        }
    }
    
//    https://desk.zoho.com/DeskAPIDocument#Tickets#Tickets_Createaticket
    @objc public static func createTicket(_ orgID:String = String().getOrgId(),departmentId:String,subject:String,contactId:String,optionalParams:[String:AnyObject] = [String:AnyObject](),onCompletion:@escaping((ZDTicketDetail?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: URLPathConstants.createTicket, method: .POST, paramType: .json, parameters: optionalParams, headers: ["orgId":orgID])
        
        request.parameters["subject"] = subject
        request.parameters["departmentId"] = departmentId
        request.parameters["contactId"] = contactId
        
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, data, error, status) in
            guard let ticketDetailsJson = json else{onCompletion(nil,error, status);return}
            onCompletion(ZDTicketDetail(ticketDetailJsonObject: ticketDetailsJson, orgId: orgID),error,status)
        }
    }

//    https://desk.zoho.com/DeskAPIDocument#Tickets#Tickets_Updateaticket
    @objc public static func updateTicket(_ orgID:String = String().getOrgId(),ticketId:String,optionalParams:[String:AnyObject] = [String:AnyObject](),onCompletion:@escaping((ZDTicketDetail?,Error?,Int)->())) -> Void{
    
           let request =  ZDBaseRequest(path: String(format: URLPathConstants.updateTicket,ticketId), method: .PATCH, paramType: .json, parameters: optionalParams, headers: ["orgId":orgID])
            
            ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, data, error, status) in
                guard let ticketDetailsJson = json else{onCompletion(nil,error, status);return}
                onCompletion(ZDTicketDetail(ticketDetailJsonObject: ticketDetailsJson, orgId: orgID),error,status)
            }
        }
    
//    https://desk.zoho.com/DeskAPIDocument#Tickets#Tickets_Mergetwotickets
    @objc public static func mergeTwoTickets(_ orgID:String = String().getOrgId(),ticketId:String,ticketidsTobeMerged:[String],optionalParams:[String:AnyObject] = [String:AnyObject](),onCompletion:@escaping((ZDTicketDetail?,Error?,Int)->())) -> Void{
        
        let request =  ZDBaseRequest(path: String(format: URLPathConstants.mergeTicket,ticketId), method: .POST, paramType: .json, parameters: optionalParams, headers: ["orgId":orgID])
        request.parameters["ids"] = ticketidsTobeMerged
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, data, error, status) in
            guard let ticketDetailsJson = json else{onCompletion(nil,error, status);return}
            onCompletion(ZDTicketDetail(ticketDetailJsonObject: ticketDetailsJson, orgId: orgID),error,status)
        }
    }
    
 //https://desk.zoho.com/DeskAPIDocument#Tickets_Moveticket
    @objc public static func moveTicket(_ orgID:String = String().getOrgId(),ticketId:String,departmentId:String,onComplition:@escaping ((Error?,Int)->())) -> Void{
        
        let request =  ZDBaseRequest(path: String(format: URLPathConstants.moveTicket,ticketId), method: .POST,parameters:["departmentId":departmentId], headers: ["orgId":orgID])
        ZDRequestMaker.sharedInstance.makeRequest(for:request,
                                                  success: { (reponceData,statusCode) in
                                                    onComplition(nil, statusCode)
                                                    
        }) { (reponceData, error, statusCode) in
            onComplition(error, statusCode)
        }
    }

    //https://desk.zoho.com/DeskAPIDocument#Tickets#Tickets_Splittickets
    @objc public static func splitTickets(_ orgID:String = String().getOrgId(),ticketId:String,threadId:String,onCompletion:@escaping((ZDTicketDetail?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.splitTicket,ticketId,threadId), method: .POST, headers: ["orgId":orgID])
        
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, data, error, status) in
            guard let ticketJson = json else{onCompletion(nil,error, status);return}
            onCompletion(ZDTicketDetail(ticketDetailJsonObject: ticketJson, orgId: orgID),error,status)
        }
    }
    
    
//    https://desk.zoho.com/DeskAPIDocument#Tickets#Tickets_Updatemanytickets
    @objc public static func updateManyTickets(_ orgID:String = String().getOrgId(),fieldName:String,fieldValue:String, optionalParams:[String:AnyObject] = [String:AnyObject](),onCompletion:@escaping((Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.updateManyTicket), method: .POST, paramType: .json, parameters: optionalParams, headers: ["orgId":orgID])
        request.parameters["fieldName"] = fieldName
        request.parameters["fieldValue"] = fieldValue
        
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, data, error, status) in
            onCompletion(error,status)
        }
        
    }

//    https://desk.zoho.com/DeskAPIDocument#Tickets#Tickets_Markspam
    @objc public static func markTicketsAsSPAM(_ orgId:String = String().getOrgId(),isMakingSpam:Bool,ticketIDS:[String],onComplition:@escaping ((Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: URLPathConstants.ticketMarkASSPAM, method: .POST, paramType: .json, parameters: ["ids":ticketIDS], headers: ["orgId":orgId])
        request.parameters["isSpam"] = isMakingSpam ? "true" : "false"
        ZDRequestMaker.sharedInstance.makeRequest(for:request,
                                                  success: { (reponceData,statusCode) in
                                                    onComplition(nil, statusCode)
        }) { (reponceData, error, statusCode) in
            onComplition(error, statusCode)
        }
    }
}



