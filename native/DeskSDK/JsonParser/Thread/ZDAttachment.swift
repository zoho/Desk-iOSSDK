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

@objc open class ZDAttachment: NSObject {

    internal var parentID        = ""
    internal var subParentID     = ""
    internal var parentType      = ZDAttachmentParent.none

    @objc public var size: Double      = 0
    @objc public var name              = ""
    @objc public var id                = ""
    @objc public var href              = ""
    
    @objc public var creatorId         = ""
    @objc public var isPublic          = false
    @objc public var createdTime       = ""
    
    @objc public var downloadURL       = ""
    @objc public var  orgId            = ""
    
    @objc public var data: Data?
    
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
    fileprivate func downloadAttachement(onCompliton:@escaping (Data?,Error?,Int)->()){
        
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
