//
//  ZDContactAttachementProvoider.swift
//  ZohoDeskSDK
//
//  Created by rajesh-2098 on 09/05/18.
//  Copyright © 2018 rajesh-2098. All rights reserved.
//

import Foundation
@objc open class ZDContactAttachmentAPIHandler:NSObject{
    
   @objc open static func listAllAttachments(_ orgID:String = String().getZDOrgId(),contactID:String,optionalParams:Parameters = Parameters(),onComplition:@escaping (([ZDAttachment]?,Error?,Int)->())) -> Void{
        
        let path = String(format: URLPathConstants.ContactsAttachments.listAllContactAttchements, contactID)
        ZDAttachementProvoider.listAllAttachments(orgID, urlPath: path, parentId: contactID, parentType: .contact, optionalParams: optionalParams as [String : AnyObject], onComplition: onComplition)
        
    }
    
    @objc open static func createAttachement(_ orgID:String = String().getZDOrgId(),contactID:String,data:Data,fileName:String,onComplition:@escaping ((ZDAttachment?,Error?,Int)->())) -> URLRequest {
        
        let path = String(format: URLPathConstants.ContactsAttachments.createContactAttachment, contactID)
        return ZDAttachementProvoider.createAttachement(orgID, path: path, data: data, fileName: fileName, isPublic: false, parentId: contactID, parentType: .contact, addPublicData: false, onComplition: onComplition)
    }
    
    @objc open static func deleteAttachment(_ orgID:String = String().getZDOrgId(),contactID:String,attachementID:String,onComplition:@escaping ((Error?,Int)->())) -> Void{
        
        let path = String(format: URLPathConstants.ContactsAttachments.deleteContactAttachment, contactID,attachementID)
        ZDAttachementProvoider.deleteAttachment(orgID, path: path, onComplition: onComplition)
        
    }
}
