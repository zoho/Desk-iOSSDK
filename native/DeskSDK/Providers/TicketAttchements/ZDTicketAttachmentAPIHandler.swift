//
//  ZDTicketAttachementProvoider.swift
//  ZohoDeskSDK
//
//  Created by rajesh-2098 on 09/05/18.
//  Copyright © 2018 rajesh-2098. All rights reserved.
//

import Foundation
@objc public class ZDTicketAttachmentAPIHandler:NSObject{

    @objc public static func listAllAttachments(_ orgID:String = String().getOrgId(),ticketID:String = "",from:Int,limit:Int, optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping (([ZDAttachment]?,Error?,Int)->())) -> Void{
        
        let path = String(format: URLPathConstants.listAllTicketAttchements, ticketID)
        var params = optionalParams
        params["from"] = from as AnyObject
        params["to"] = limit as AnyObject
        ZDAttachementProvoider.listAllAttachments(orgID, urlPath: path, parentId: ticketID, parentType: .ticket, optionalParams: params, onComplition: onComplition)
        
    }
    
    @objc public static func createAttachement(_ orgID:String = String().getOrgId(),ticketID:String,isPublic:Bool,data:Data,fileName:String,onComplition:@escaping ((ZDAttachment?,Error?,Int)->())) -> URLRequest {
        
        let path = String(format: URLPathConstants.createTicketAttachment, ticketID)

        return ZDAttachementProvoider.createAttachement(orgID, path: path, data: data, fileName: fileName, isPublic: isPublic, parentId: ticketID, parentType: .ticket, addPublicData: true, onComplition: onComplition)
    }
    
    @objc public static func updateAttachement(_ orgID:String = String().getOrgId(),ticketID:String,attachementID:String,optionalPrams:Parameters,onComplition:@escaping ((ZDAttachment?,Error?,Int)->())) -> Void{
        let path = String(format: URLPathConstants.updateTicketAttachment, ticketID,attachementID)
        ZDAttachementProvoider.updateAttachement(orgID, path: path, updateDetails: optionalPrams, parentId: ticketID, subParentId: "", parentType: .ticket, onComplition: onComplition)
    }
    
    
    @objc public static func deleteAttachment(_ orgID:String = String().getOrgId(),ticketID:String,attachementID:String,onComplition:@escaping ((Error?,Int)->())) -> Void{
        
        let path = String(format: URLPathConstants.deleteTicketAttachment, ticketID,attachementID)
        ZDAttachementProvoider.deleteAttachment(orgID, path: path, onComplition: onComplition)
        
    }
}
