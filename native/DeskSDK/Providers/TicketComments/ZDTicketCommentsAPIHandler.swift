//
//  ZDTicketsCommentsProvoider.swift
//  ZohoDeskSDK
//
//  Created by rajesh-2098 on 08/05/18.
//  Copyright © 2018 rajesh-2098. All rights reserved.
//

import Foundation

//Ticket comments are ticket-related conversations that occur mainly between different agents in the help desk. Comments marked as private in a ticket are visible only to agents, whereas comments marked as public appear on the customer portal too.
@objc public class ZDTicketCommentsAPIHandler : NSObject{
    
    /// This API adds a comment to a ticket. To include an @mention, follow this format: zsu[@user:{zuid}]zsu.
    ///
    /// - Parameters:
    ///   - orgID: Unique ID of the Organization
    ///   - ticketID: Unique ID of the Ticket
    ///   - isPublic: Making ticket public or private
    ///   - content: Conent of the Ticket. To include an @mention, follow this format: zsu[@user:{zuid}]zsu.
    ///   - addtionalParams: Optional paramerters can be given by
    ///   - onComplition: Oncomplition data will ticket object or Error message and status code of the reponce.
    @objc public static func createTicketComment(_ orgID:String = String().getZDOrgId(),ticketID:String,isPublic:Bool,content:String,addtionalParams:Parameters = Parameters(),onComplition:@escaping ((ZDTicketComment?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.TicketsComments.createTicketComment, ticketID), method: .POST, paramType: .json, parameters: addtionalParams, headers: ["orgId":orgID])
        request.parameters["isPublic"] = "\(isPublic)"
        request.parameters["content"] = content
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponseData, error, statusCode) in
            guard let ticketCommentJson  = json else{return}
            onComplition(ZDTicketComment(ordId: orgID, ticketId: ticketID, ticketCommentJSON: ticketCommentJson), nil, statusCode)
        }
    }
    
    @objc public static func updateTicketComment(_ orgID:String = String().getZDOrgId(),ticketID:String,commendId:String,content:String,addtionalParams:Parameters = Parameters(),onComplition:@escaping ((ZDTicketComment?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.TicketsComments.updateTicketComment, ticketID,commendId), method: .PATCH, paramType: .json,parameters:addtionalParams, headers: ["orgId":orgID])
        request.parameters = ["content":content]
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, responceData, error, statusCode) in
            guard let ticketCommentJson  = json else{return}
            onComplition(ZDTicketComment(ordId: orgID, ticketId: ticketID, ticketCommentJSON: ticketCommentJson), nil, statusCode)
        }
    }
    
    @objc public static func deleteTicketComment(_ orgID:String = String().getZDOrgId(),ticketID:String,commendId:String,onComplition:@escaping ((Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path:  String(format: URLPathConstants.TicketsComments.deleteTicketComment, ticketID,commendId), method: .DELETE, paramType: .path, headers: ["orgId":orgID])
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, data, error, statusCode) in
            onComplition(error, statusCode)
        }
    }
    
    @objc public static func getTicketComment(_ orgID:String = String().getZDOrgId(),ticketID:String,commendId:String,onComplition:@escaping ((ZDTicketComment?,Error?,Int)->())) -> Void{
        let request = ZDBaseRequest(path: String(format: URLPathConstants.TicketsComments.getTicketComment, ticketID,commendId),headers:["orgId":orgID])
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, statusCode) in
            guard let ticketCommentJson = json else{onComplition(nil,error,statusCode);return}
            onComplition(ZDTicketComment(ordId: orgID, ticketId: ticketID, ticketCommentJSON: ticketCommentJson), nil, statusCode)
        }
    }
    
    @objc public static func getAllTicketComments(_ orgID:String = String().getZDOrgId(),ticketID:String,from:Int = 0,limit:Int = 50,additionalParams:Parameters = Parameters(), onComplition:@escaping (([ZDTicketComment]?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.TicketsComments.getAllTicketComment, ticketID),parameters:additionalParams, headers:["orgId":orgID])
        request.parameters["from"] = from
        request.parameters["limit"] = limit
        
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, statusCode) in
            guard let ticketCommentListJson  = json else{onComplition(nil, nil, statusCode);return}
            onComplition(ZDTicketComment.modelsFromArrayOfDictionary(JSONDictionary: ticketCommentListJson, ordId: orgID, ticketId: ticketID), nil, statusCode)
        }

    }
    
}
