//
//  ZDTicketComment.swift
//  Pods
//
//  Created by rajeshkumar.l.
//  Copyright © 2017 rajesh-2098. All rights reserved.
//


import Foundation

@objc public class ZDTicketComment : ZDConverstaion{

    public var ticketID       = ""
    public var commentedTime  = ""
    public var isPublic       = true
    public var id             = ""
    public var content        = ""
    public var commenterId    = ""
    public var encodedContent = ""
    public var attachments    = [ZDAttachment]()
    
    public var modifiedTime:String?

    private override init() {
        super.init()
    }

    
    internal class func modelsFromArrayOfDictionary(JSONDictionary:[String:AnyObject],ordId:String,ticketId:String) -> [ZDTicketComment] {
        var models:[ZDTicketComment] = []
        
        guard let array = JSONDictionary["data"] as? [[String:AnyObject]] else{return models}
        
        for item in array{
            models.append(ZDTicketComment(ordId: ordId, ticketId: ticketId, ticketCommentJSON: item))
        }
        return models
    }


    internal init(ordId:String,ticketId:String,ticketCommentJSON: [String:AnyObject]) {

        super.init()
        
        self.orgId = ordId
        self.ticketID = ticketId
        self.type = .comment
        
        modifiedTime  = ticketCommentJSON["modifiedTime"] as? String
        commentedTime = ticketCommentJSON["commentedTime"].toString()
        isPublic      = ticketCommentJSON["isPublic"].toBool()
        id            = ticketCommentJSON["id"].toString()
        content       = ticketCommentJSON["content"].toString()
        commenterId   = ticketCommentJSON["commenterId"].toString()
        commenterId   = ticketCommentJSON["encodedContent"].toString()

        guard let attachArray = ticketCommentJSON["attachments"] as? [[String:AnyObject]] else {return}
        for item in attachArray{
            hasAttach = true
            attachments.append(ZDAttachment(attachmentJson: item, orgId: ordId, parentID: ticketID, subParentID: id, parentType: .comment))
        }
        if let author = ticketCommentJSON["commenter"] as? [String:AnyObject]{
            self.author = ZDAuthor(author: author)
        }
        
    }

    public func deleteComment(onComplition:@escaping ((Error?,Int)->())){
//        ZDTicketProvoider.deleteTicketComment(orgID, ticketID: ticketID, commendId: id, onComplition: onComplition)
    }


}
