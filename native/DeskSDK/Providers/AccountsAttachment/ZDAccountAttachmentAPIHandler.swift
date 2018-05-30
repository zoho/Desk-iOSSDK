//
//  ZDAccountsAttachmentProvoider.swift
//  ZohoDeskSDK
//
//  Created by rajesh-2098 on 09/05/18.
//  Copyright © 2018 rajesh-2098. All rights reserved.
//

import Foundation
@objc public class ZDAccountAttachmentAPIHandler:NSObject{
    
    @objc public static func listAllAttachments(_ orgId:String = String().getOrgId(),accountId:String = "",from:Int = 0,limit:Int = 50,optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping (([ZDAttachment]?,Error?,Int)->())) -> Void{
        
        let path = String(format: URLPathConstants.listAllAccountsAttchements, accountId)
        var params = optionalParams
        params["from"] = from as AnyObject
        params["limit"] = limit as AnyObject
        ZDAttachementProvoider.listAllAttachments(orgId, urlPath: path, parentId: accountId, parentType: .accounts, optionalParams: params, onComplition: onComplition)
        
    }
    
    @objc public static func createAttachement(_ orgId:String = String().getOrgId(),accountId:String,data:Data,fileName:String,onComplition:@escaping ((ZDAttachment?,Error?,Int)->())) -> URLRequest {
        
        let path = String(format: URLPathConstants.createAccountsAttachment, accountId)
        return ZDAttachementProvoider.createAttachement(orgId, path: path, data: data, fileName: fileName, isPublic: false, parentId: accountId, parentType: .accounts, addPublicData: false, onComplition: onComplition)
    }
    
    @objc public static func deleteAttachment(_ orgId:String = String().getOrgId(),accountId:String,attachementId:String,onComplition:@escaping ((Error?,Int)->())) -> Void{
        
        let path = String(format: URLPathConstants.deleteAccountsAttachment, accountId,attachementId)
        ZDAttachementProvoider.deleteAttachment(orgId, path: path, onComplition: onComplition)
        
    }
}
