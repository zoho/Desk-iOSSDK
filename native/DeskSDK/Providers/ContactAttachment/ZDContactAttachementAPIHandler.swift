//
//  ZDContactAttachementProvoider.swift
//  ZohoDeskSDK
//
//  Created by rajesh-2098 on 09/05/18.
//  Copyright © 2018 rajesh-2098. All rights reserved.
//

import Foundation
@objc public class ZDContactAttachmentAPIHandler:NSObject{
    
   @objc public static func listAllAttachments(_ orgID:String = String().getOrgId(),contactID:String,from:Int = 0,limit:Int=0,optionalParams:Parameters = Parameters(),onComplition:@escaping (([ZDAttachment]?,Error?,Int)->())) -> Void{
        
        let path = String(format: URLPathConstants.listAllContactAttchements, contactID)
        var params = optionalParams
        params["from"] = from
        params["limit"] = limit
        ZDAttachementProvoider.listAllAttachments(orgID, urlPath: path, parentId: contactID, parentType: .contact, optionalParams: params as [String : AnyObject], onComplition: onComplition)
        
    }
    
    @objc public static func createAttachement(_ orgID:String = String().getOrgId(),contactID:String,data:Data,fileName:String,onComplition:@escaping ((ZDAttachment?,Error?,Int)->())) -> URLRequest {
        
        let path = String(format: URLPathConstants.createContactAttachment, contactID)
        return ZDAttachementProvoider.createAttachement(orgID, path: path, data: data, fileName: fileName, isPublic: false, parentId: contactID, parentType: .contact, addPublicData: false, onComplition: onComplition)
    }
    
    @objc public static func deleteAttachment(_ orgID:String = String().getOrgId(),contactID:String,attachementID:String,onComplition:@escaping ((Error?,Int)->())) -> Void{
        
        let path = String(format: URLPathConstants.deleteContactAttachment, contactID,attachementID)
        ZDAttachementProvoider.deleteAttachment(orgID, path: path, onComplition: onComplition)
        
    }
}
