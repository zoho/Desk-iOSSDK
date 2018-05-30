//
//  ZDAttachments.swift
//  Pods
//
//  Created by rajeshkumar.l.
//  Copyright © 2017 rajesh-2098. All rights reserved.
//


import Foundation
internal enum ZDAttachmentParent{
    case ticket,contact,accounts,task,thread,comment,none
}

@objc public class ZDAttachment: NSObject {

    internal var parentID        = ""
    internal var subParentID     = ""
    internal var parentType      = ZDAttachmentParent.none

    public var size: Double     = 0
    public var name              = ""
    public var id                = ""
    public var href              = ""
    
    public var creatorId         = ""
    public var isPublic          = false
    public var createdTime       = ""
    
    public var downloadURL       = ""
    internal var orgId           = ""
    
    public var data: Data?
    
    internal class func modelsFrom(json:[String:AnyObject]?,orgId:String,parentID:String,subParentID:String,parentType:ZDAttachmentParent) -> [ZDAttachment]?{
        guard  let attachementArray = json?["data"] as?[[String:AnyObject]] else {return nil}
        return modelsFrom(attachementArray: attachementArray, orgId: orgId, parentID: parentID, subParentID: subParentID, parentType: parentType)
    }
    
    internal class func modelsFrom(attachementArray:[[String:AnyObject]]?,orgId:String,parentID:String,subParentID:String,parentType:ZDAttachmentParent) -> [ZDAttachment]?{
        guard  let nonNilattachementArray = attachementArray else {return nil}
        return nonNilattachementArray.map({ZDAttachment(attachmentJson: $0, orgId: orgId, parentID: parentID, subParentID: subParentID, parentType: parentType)})
    }

    internal init(attachmentJson: [String:AnyObject], orgId:String,parentID:String,subParentID:String,parentType:ZDAttachmentParent) {
        
        super.init()
        
        self.orgId       = orgId
        self.parentID    = parentID
        self.subParentID = subParentID
        self.parentType  = parentType

        size             = attachmentJson["size"].toDouble()
        name             = attachmentJson["name"].toString()
        id               = attachmentJson["id"].toString()
        href             = attachmentJson["href"].toString()

        creatorId        = attachmentJson["creatorId"].toString()
        isPublic         = attachmentJson["isPublic"].toBool()
        createdTime      = attachmentJson["createdTime"].toString()
        
	}


}

extension ZDAttachment{
    public func downloadAttachement(onCompliton:@escaping (Data?,Error?,Int)->()){
        
        if data != nil{onCompliton(data,nil,200);return}
        
        let request = ZDBaseRequest(path: "", headers: ["orgId":self.orgId])
        
        guard let url = URL(string: self.href) else {
            onCompliton(data,NSError(domain: "Invalid URL Found -> \(self.href)", code: 0, userInfo: nil),0)
            return
        }
        
        request.baseURL = url
        
        ZDRequestMaker().makeRequest(for: request, success: { [weak self] (data, statusCode) in
            onCompliton(data,nil,statusCode)
             guard let selfObject = self else{return}
            selfObject.data = data
        }) { (data, error, statusCode) in
            onCompliton(data,error,statusCode)
        }
        
    }
}
