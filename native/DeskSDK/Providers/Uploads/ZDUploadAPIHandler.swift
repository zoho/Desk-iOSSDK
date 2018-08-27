//
//  ZDUploadProvoider.swift
//  ZohoDeskSDK
//
//  Created by rajesh-2098 on 09/05/18.
//  Copyright © 2018 rajesh-2098. All rights reserved.
//

import Foundation

/// Uploads are temporary attachments that exist with a ticket for just 24 hours.
@objc open class ZDUploadAPIHandler : NSObject {
    
//    https://desk.zoho.com/DeskAPIDocument#Uploads#Uploads_Uploadafile
    @objc open static func uploadFile(_ orgID:String = String().getZDOrgId(),data:Data,fileName:String,onComplition:@escaping ((ZDAttachment?,Error?,Int)->())) -> URLRequest {
        let path = String(format: URLPathConstants.Uploads.uploads)
        return ZDAttachementProvoider.createAttachement(orgID, path: path, data: data, fileName: fileName, isPublic: false, parentId: "", parentType: .none, addPublicData: false, onComplition: onComplition)
    }
    
}
