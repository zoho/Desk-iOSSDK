//
//  ZDThreadDetail.swift
//  Pods
//
//  Created by rajeshkumar.l.
//  Copyright © 2017 rajesh-2098. All rights reserved.
//


import Foundation

@objc open class ZDThreadDetail :NSObject {
    
    @objc public var ticketID:String?
    @objc public var cc:String?
    @objc public var summary          = ""
	@objc public var attachments      = [ZDAttachment]()
    @objc public var bcc:String?
    @objc public var channel:String?
    @objc public var content          = ""
    @objc public var visibity         = ""
    @objc public var isForward        = false
    @objc public var hasAttach:String?
    @objc public var createdTime      = ""
    @objc public var to:String?
    @objc public var id               = ""
    @objc public var fromEmailAddress:String?
	@objc public var actions          = [ZDThreadAction]()
    @objc public var status           = ""
    @objc public var direction        = ""
    @objc public var responderId:String?
    @objc public var phoneno:String?
    @objc public var author:ZDAuthor?
    @objc public var facebookProfile:String?
    @objc public var twitterProfile:String?
    
    @objc public  var orgId = ""
    
    @objc open  class func modelsFromArray(array:[[String:AnyObject]],orgId:String,ticketId:String) -> [ZDThreadDetail]
    {
        return array.map{ZDThreadDetail(Json: $0, orgId: orgId, ticketId: ticketId)}
        
    }
    
    internal init(Json: [String:AnyObject],orgId:String,ticketId:String) {

        self.orgId = orgId
        
        visibity           = Json["visibility"].toString()
        phoneno            = Json["phoneno"].toString()
        cc                 = Json["cc"].toString()
        summary            = Json["summary"].toString()
        bcc                = Json["bcc"].toString()
        channel            = Json["channel"].toString()
        facebookProfile    = Json["facebookProfile"].toString()
        twitterProfile     = Json["twitterProfile"].toString()
        responderId        = Json["responderId"].toString()
        content            = Json["content"].toString()
        isForward          = Json["isForward"].toBool()
        hasAttach          = Json["hasAttach"].toString()
        createdTime        = Json["createdTime"].toString()
        to                 = Json["to"].toString()
        id                 = Json["id"].toString()
        fromEmailAddress   = Json["fromEmailAddress"].toString()
        status             = Json["status"].toString()
        direction          = Json["direction"].toString()
        
        if let author = Json["author"] as? [String:AnyObject]{
            self.author = ZDAuthor(author: author)
        }

        if let actions = Json["actions"] as? [[String:AnyObject]]{
            self.actions = ZDThreadAction.initWithArray(orgId: orgId, actions: actions)
        }

        if let attachments = Json["attachments"] as? [[String:AnyObject]]{
            self.attachments = ZDAttachment.modelsFrom(attachementArray: attachments, orgId: orgId, parentID: ticketId, subParentID: self.id, parentType: .thread)!
        }
	}
}

@objc open class ZDAuthor:NSObject{
    
    @objc public var email:String?
    @objc public var name  = ""
    @objc public var photoURL:String?
    @objc public var type:String?
    
    @objc public  override init() {}
    
    @objc public  init(author:[String:AnyObject]) {
        super.init()
        self.email = author["email"] as? String
        self.name = author["name"].toString()
        self.photoURL = author["photoURL"] as? String
        self.type = author["type"] as? String
    }
}
