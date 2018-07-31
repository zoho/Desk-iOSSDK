//
//  ZDThread.swift
//  Pods
//
//  Created by rajeshkumar.l.
//  Copyright © 2017 rajesh-2098. All rights reserved.
//


import Foundation

@objc public class ZDThread : ZDConverstaion {

    @objc public var ticketId    = ""

    @objc public var summary     = ""
    @objc public var createdTime = ""
    @objc public var id          = ""
    @objc public var actions     = [ZDThreadAction]()
    @objc public var status      = ""
    @objc public var direction   = ""
    @objc public var isForward   = false
    @objc public var visibity    = ""

    @objc public var channel:String?
    @objc public var fromEmailAddress:String?
    @objc public var bcc:String?
    @objc public var to:String?
    @objc public var cc:String?
    @objc public var phoneno:String?
    @objc public var responderId:String?
    @objc public var facebookProfile:String?
    @objc public var twitterProfile:String?
    
    @objc public var threadDetails:ZDThreadDetail?
    
    @objc public override init() {super.init()}

    @objc public class func modelsFromJSON(orgId:String,ticketId:String,jsonList:[String : AnyObject]) -> [ZDThread]{
        
        guard let array = jsonList["data"] as? [[String:AnyObject]] else{return [ZDThread]()}
        let models = array.map{ZDThread(orgId: orgId,ticketId: ticketId,JSONThread: $0)}
        return models
        
    }


    @objc public  init(orgId:String,ticketId:String,JSONThread: [String:AnyObject]) {
        
        super.init()

        self.orgId = orgId
        self.ticketId = ticketId
        self.type = .thread
        
        summary          = JSONThread["summary"].toString()
        phoneno          = JSONThread["phoneno"].toString()
        hasAttach        = JSONThread["hasAttach"].toBool()
        isForward        = JSONThread["isForward"].toBool()
        visibity         = JSONThread["visibility"].toString()
        facebookProfile  = JSONThread["facebookProfile"].toString()
        twitterProfile   = JSONThread["twitterProfile"].toString()
        channel          = JSONThread["channel"].toString()
        createdTime      = JSONThread["createdTime"].toString()
        id               = JSONThread["id"].toString()
        fromEmailAddress = JSONThread["fromEmailAddress"].toString()
        status           = JSONThread["status"].toString()
        direction        = JSONThread["direction"].toString()
        to               = JSONThread["to"].toString()
        bcc              = JSONThread["bcc"].toString()
        cc               = JSONThread["cc"].toString()
        responderId      = JSONThread["responderId"].toString()

        if let author = JSONThread["author"] as? [String:AnyObject]{
            self.author = ZDAuthor(author: author)
        }
        
        if let actions = JSONThread["actions"] as? [[String:AnyObject]]{
            self.actions = ZDThreadAction.initWithArray(orgId: orgId, actions: actions)
        }
        
	}
    
    internal  class func modelsfromConversationAPI(orgId:String,ticketId:String,jsonList:[String : AnyObject]) -> [ZDConverstaion]{
        var coversationObjects = [ZDConverstaion]()
        guard let conversation = jsonList["data"] as? [[String:AnyObject]] else{return coversationObjects}
        
        
        coversationObjects = conversation.map { (jsonObject) -> ZDConverstaion in
            if jsonObject["type"].toString() == "thread"{
                return ZDThread(orgId: orgId, ticketId: ticketId, JSONThread: jsonObject)
            }
            else if jsonObject["type"].toString() == "comment"{
                return ZDTicketComment(ordId: orgId, ticketId: ticketId, ticketCommentJSON: jsonObject)
            }
            return ZDConverstaion()
        }
        
        return coversationObjects

    }
    
    fileprivate func getThreadDetail(onComplition:@escaping ((ZDThreadDetail?,Error?,Int)->())) -> Void {
        if threadDetails != nil{onComplition(threadDetails,nil,200);return}
        ZDThreadAPIHandler.getThread(orgId, ticketId: ticketId, threadId: self.id) { [weak self](threadDetail, error, status) in
            self?.threadDetails = threadDetail
            onComplition(threadDetail,error,status)
        }
    }
}
