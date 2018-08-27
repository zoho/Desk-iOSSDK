//
//  ZDTicketAttachementProvoider.swift
//  ZohoDeskSDK
//
//  Created by rajesh-2098 on 09/05/18.
//  Copyright © 2018 rajesh-2098. All rights reserved.
//

import Foundation
@objc open class ZDTicketAttachmentAPIHandler:NSObject{

    @objc open static func listAllAttachments(_ orgID:String = String().getZDOrgId(),ticketID:String = "", optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping (([ZDAttachment]?,Error?,Int)->())) -> Void{
        
        let path = String(format: URLPathConstants.TicketAttachments.listAllTicketAttchements, ticketID)
        ZDAttachementProvoider.listAllAttachments(orgID, urlPath: path, parentId: ticketID, parentType: .ticket, optionalParams: optionalParams, onComplition: onComplition)
        
    }
    
    @objc open static func createAttachement(_ orgID:String = String().getZDOrgId(),ticketID:String,isPublic:Bool,data:Data,fileName:String,onComplition:@escaping ((ZDAttachment?,Error?,Int)->())) -> URLRequest {
        
        let path = String(format: URLPathConstants.TicketAttachments.createTicketAttachment, ticketID)

        return ZDAttachementProvoider.createAttachement(orgID, path: path, data: data, fileName: fileName, isPublic: isPublic, parentId: ticketID, parentType: .ticket, addPublicData: true, onComplition: onComplition)
    }
    
    @objc open static func updateAttachement(_ orgID:String = String().getZDOrgId(),ticketID:String,attachementID:String,optionalPrams:Parameters,onComplition:@escaping ((ZDAttachment?,Error?,Int)->())) -> Void{
        let path = String(format: URLPathConstants.TicketAttachments.updateTicketAttachment, ticketID,attachementID)
        ZDAttachementProvoider.updateAttachement(orgID, path: path, updateDetails: optionalPrams, parentId: ticketID, subParentId: "", parentType: .ticket, onComplition: onComplition)
    }
    
    
    @objc open static func deleteAttachment(_ orgID:String = String().getZDOrgId(),ticketID:String,attachementID:String,onComplition:@escaping ((Error?,Int)->())) -> Void{
        
        let path = String(format: URLPathConstants.TicketAttachments.deleteTicketAttachment, ticketID,attachementID)
        ZDAttachementProvoider.deleteAttachment(orgID, path: path, onComplition: onComplition)
        
    }
}
