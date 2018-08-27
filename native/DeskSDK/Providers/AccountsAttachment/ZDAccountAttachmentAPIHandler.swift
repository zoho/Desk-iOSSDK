//
//  ZDAccountsAttachmentProvoider.swift
//  ZohoDeskSDK
//
//  Created by rajesh-2098 on 09/05/18.
//  Copyright © 2018 rajesh-2098. All rights reserved.
//

import Foundation
@objc open class ZDAccountAttachmentAPIHandler:NSObject{
    
    @objc open static func listAllAttachments(_ orgId:String = String().getZDOrgId(),accountId:String = "",optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping (([ZDAttachment]?,Error?,Int)->())) -> Void{
        
        let path = String(format: URLPathConstants.AccountsAttachments.listAllAccountsAttchements, accountId)
        ZDAttachementProvoider.listAllAttachments(orgId, urlPath: path, parentId: accountId, parentType: .accounts, optionalParams: optionalParams, onComplition: onComplition)
        
    }
    
    @objc open static func createAttachement(_ orgId:String = String().getZDOrgId(),accountId:String,data:Data,fileName:String,onComplition:@escaping ((ZDAttachment?,Error?,Int)->())) -> URLRequest {
        
        let path = String(format: URLPathConstants.AccountsAttachments.createAccountsAttachment, accountId)
        return ZDAttachementProvoider.createAttachement(orgId, path: path, data: data, fileName: fileName, isPublic: false, parentId: accountId, parentType: .accounts, addPublicData: false, onComplition: onComplition)
    }
    
    @objc open static func deleteAttachment(_ orgId:String = String().getZDOrgId(),accountId:String,attachementId:String,onComplition:@escaping ((Error?,Int)->())) -> Void{
        
        let path = String(format: URLPathConstants.AccountsAttachments.deleteAccountsAttachment, accountId,attachementId)
        ZDAttachementProvoider.deleteAttachment(orgId, path: path, onComplition: onComplition)
        
    }
}
