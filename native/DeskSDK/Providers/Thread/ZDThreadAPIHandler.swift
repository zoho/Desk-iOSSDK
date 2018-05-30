//
//  ZDThreadProvoider.swift
//  Pods
//
//  Created by rajeshkumar.l.
//  Copyright © 2017 rajesh-2098. All rights reserved.
//


import Foundation

@objc public  class ZDThreadAPIHandler: NSObject {
    
    /// This API fetches a single thread from your helpdesk.
    ///
    /// - Parameters:
    ///   - orgID: Selected Organizations Id
    ///   - ticketId: Selected Ticket Id
    ///   - threadId: Thread id for that you need
    ///   - optionalParams:
    ///   - onComplition: ThreadObject,Error (incase),Status code of the reponce.
    //https://desk.zoho.com/DeskAPIDocument#Threads
    @objc public static func getThread(_ orgID:String = String().getOrgId(),
                                  ticketId:String,
                                  threadId:String,
                                  optionalParams:Parameters = Parameters(),
                                  onComplition:@escaping ((ZDThreadDetail?,Error?,Int)->())) -> Void{
        let request = ZDBaseRequest(path: String(format: URLPathConstants.getAThread, ticketId,threadId),parameters:optionalParams,headers:["orgId":orgID])
        
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
            guard let threadJson  = json else{onComplition(nil,error,status);return}
            onComplition(ZDThreadDetail(Json: threadJson, orgId: orgID, ticketId: ticketId), nil, status)
        }
    }
    
//https://desk.zoho.com/DeskAPIDocument#Threads#Threads_Listallthreads
    @objc public static func getAllThreads(_ orgID:String = String().getOrgId(),from:Int = 0,limit:Int = 50,ticketId:String,onComplition:@escaping (([ZDThread]?,Error?,Int)->())) -> Void{
        let request = ZDBaseRequest(path: String(format: URLPathConstants.listAllThreads, ticketId), parameters:["from":from,"limit":limit], headers: ["orgId":orgID])

        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
            guard let threadListJson  = json else{onComplition(nil,error,status);return}
            onComplition(ZDThread.modelsFromJSON(orgId: orgID, ticketId: ticketId, jsonList: threadListJson), nil, status)
        }
    }

//https://desk.zoho.com/DeskAPIDocument#Threads#Threads_SendEmailReply
    @objc public static func sendEmailReply(_ orgID:String = String().getOrgId(),
                                      ticketId:String,
                                      fromEmail:String,
                                      toEmail:String,
                                      content:String,
                                      addtionalParams:[String:AnyObject] = [String:AnyObject](),
                                      onComplition:@escaping ((ZDThreadDetail?,Error?,Int)->())) -> Void{

        sendOrDraftEmailReply(orgID, path: String(format: URLPathConstants.draftEmail, ticketId), ticketId, content, fromEmail, toEmail, addtionalParams, onComplition)

    }
    

//    https://desk.zoho.com/DeskAPIDocument#Threads#Threads_DraftEmailReply
    @objc public static func draftEmailReply(_ orgID:String = String().getOrgId(),
                                      ticketId:String,
                                      fromEmail:String,
                                      toEmail:String,
                                      content:String,
                                      addtionalParams:[String:AnyObject] = [String:AnyObject](),
                                      onComplition:@escaping ((ZDThreadDetail?,Error?,Int)->())) -> Void{
  
        sendOrDraftEmailReply(orgID, path: String(format: URLPathConstants.draftEmail, ticketId), ticketId, content, fromEmail, toEmail, addtionalParams as [String : AnyObject], onComplition)
        
    }
//    https://desk.zoho.com/DeskAPIDocument#Threads#Threads_UpdateDraft
    @objc public static func updateDraft(_ orgID:String = String().getOrgId(),
                                   ticketId:String,
                                   draftId:String,
                                   addtionalParams:[String:AnyObject] = [String:AnyObject](),
                                   onComplition:@escaping ((ZDThreadDetail?,Error?,Int)->())) -> Void{
    
        emailThread(orgID, urlPath: String(format: URLPathConstants.updateDraft, ticketId), params: addtionalParams, method: .PATCH, onComplition: onComplition)

    }

    
//    https://desk.zoho.com/DeskAPIDocument#Threads#Threads_Deleteanattachment
    @objc public static func deleteThreadAttachment(_ orgID:String = String().getOrgId(),
                                              ticketId:String,
                                              threadId:String,
                                              attachmentId:String,
                                              onComplition:@escaping ((Error?,Int)->())) -> Void{
        let path = String(format: URLPathConstants.deleteThreadAttachement, ticketId,threadId,attachmentId)
        ZDAttachementProvoider.deleteAttachment(orgID, path: path, onComplition: onComplition)
    }

    @objc public static func getAllConversation(_ orgID:String = String().getOrgId(),ticketId:String,from:Int,limit:Int,
                                                onComplition:@escaping (([String:AnyObject]?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.listAllConversation, ticketId),headers:["orgId":orgID])
        request.parameters["from"] = from
        request.parameters["limit"] = limit
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, responceData,error, statusCode) in
            onComplition(json, error, statusCode)
        }
    }
    
    @objc public static func conversationParser(orgId:String,ticketId:String,conversationJson:[String:AnyObject]?) -> [ZDConverstaion]?{
        guard let json  = conversationJson  else{return nil}
        return ZDThread.modelsfromConversationAPI(orgId: orgId, ticketId: ticketId, jsonList: json)

    }
}


extension ZDThreadAPIHandler{
    
    internal static func sendOrDraftEmailReply(_ orgID: String,path:String,method:Method = .POST, _ ticketId: String, _ content: String, _ fromEmail: String, _ toEmail: String,_ addtionalParams: [String : AnyObject] , _ onComplition: @escaping ((ZDThreadDetail?, Error?, Int) -> ())) {
        
        var params:Parameters = addtionalParams
        params["content"] = content
        params["channel"] = "EMAIL"
        params["fromEmailAddress"] = fromEmail
        params["to"] = toEmail
        emailThread(orgID, urlPath: path, params: params as [String : AnyObject], method: method, onComplition: onComplition)
    }
    
    internal static func emailThread(_ orgID:String = String().getOrgId(),urlPath:String,
                                     params:[String:AnyObject],method:Method = .POST,
                                     onComplition:@escaping ((ZDThreadDetail?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: urlPath, method: method, paramType: .json, parameters: params, headers: ["orgId":orgID])
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
            guard let threadDetailResponce  = json else{onComplition(nil,error,status);return}
            onComplition(ZDThreadDetail(Json: threadDetailResponce, orgId: orgID, ticketId: ""), nil, status)
        }
        
    }
}
