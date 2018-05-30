//
//  ZDThreadDetail.swift
//  Pods
//
//  Created by rajeshkumar.l.
//  Copyright © 2017 rajesh-2098. All rights reserved.
//


import Foundation

@objc public class ZDThreadDetail :NSObject {
    
    public var ticketID:String?
    public var cc:String?
    public var summary          = ""
	public var attachments      = [ZDAttachment]()
    public var bcc:String?
    public var channel:String?
    public var content          = ""
    public var visibity         = ""
    public var isForward        = false
    public var hasAttach:String?
    public var createdTime      = ""
    public var to:String?
    public var id               = ""
    public var fromEmailAddress:String?
	public var actions          = [ZDThreadAction]()
    public var status           = ""
    public var direction        = ""
    public var responderId:String?
    public var phoneno:String?
    public var author:ZDAuthor?
    public var facebookProfile:String?
    public var twitterProfile:String?
    
    internal var orgId = ""
    
    public class func modelsFromArray(array:[[String:AnyObject]],orgId:String,ticketId:String) -> [ZDThreadDetail]
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

@objc public class ZDAuthor:NSObject{
    
    public var email:String?
    public var name  = ""
    public var photoURL:String?
    public var type:String?
    
    internal override init() {}
    
    internal init(author:[String:AnyObject]) {
        super.init()
        self.email = author["email"] as? String
        self.name = author["name"].toString()
        self.photoURL = author["photoURL"] as? String
        self.type = author["type"] as? String
    }
}
