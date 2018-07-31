//
//  ZDTask.swift
//  Pods
//
//  Created by rajeshkumar.l.
//  Copyright © 2017 rajesh-2098. All rights reserved.
//

import Foundation

@objc public class ZDTask : ZDSearch {

    @objc public var modifiedTime  = ""
    @objc public var subject       = ""
    @objc public var completedTime:String?
    @objc public var dueDate:String?
    @objc public var departmentId  = ""
    @objc public var creatorId     = ""
    @objc public var taskdescription:String?
    @objc public var ownerId       = ""
    @objc public var priority      = ""
    @objc public var isCommented   = false
    @objc public var createdTime   = ""
    @objc public var id            = ""
    @objc public var category:String?
    @objc public var ticketId:String?
    @objc public var status        = ""
    @objc public var customFields:[String:AnyObject]?
    @objc public var ticket        : ZDTaskTicket?
    
    internal var orgId = ""
    
    public class func modelsFromDictionaryArray(dic:[String:AnyObject]?,orgId:String) -> [ZDTask]?
    {
        var models:[ZDTask] = []
        guard let array = dic?["data"] as? [[String:AnyObject]] else{return models}
        for item in array
        {
            if let taskObject = ZDTask(taskJsonReponce: item, orgId: orgId){
                models.append(taskObject)
            }
        }
        return models
    }

    init?(taskJsonReponce: [String:AnyObject]?,orgId:String) {
        guard let taskJson = taskJsonReponce else { return nil }
        self.orgId = orgId

        modifiedTime    = taskJson["modifiedTime"].toString()
        subject         = taskJson["subject"].toString()
        completedTime   = taskJson["completedTime"] as? String
        dueDate         = taskJson["dueDate"] as? String
        departmentId    = taskJson["departmentId"].toString()
        creatorId       = taskJson["creatorId"].toString()
        taskdescription = taskJson["description"] as? String
        ownerId         = taskJson["ownerId"].toString()
        priority        = taskJson["priority"].toString()
        isCommented     = taskJson["isCommented"].toBool()
        createdTime     = taskJson["createdTime"].toString()
        id              = taskJson["id"].toString()
        category        = taskJson["category"] as? String
        ticketId        = taskJson["ticketId"] as? String
        status          = taskJson["status"].toString()
        customFields    =  taskJson["customFields"] as? [String:AnyObject]
        
        if let ticket = taskJson["ticket"] as? [String:AnyObject]{
            self.ticket = ZDTaskTicket(taskTicket: ticket, orgId: orgId)
        }
        
	}
}

@objc public class ZDTaskTicket:NSObject{
    
    @objc public var orgId = ""
    
    @objc public var ticketNumber = ""
    @objc public var contact:ZDTaskContact?
    @objc public var id = ""

    @objc public override init() {}
    
    @objc public init(taskTicket:[String:AnyObject], orgId:String) {
        super.init()
        self.orgId = orgId
        
        self.ticketNumber = taskTicket["ticketNumber"].toString()
        self.id = taskTicket["id"].toString()
        
        if let contactJson = taskTicket["contact"] as? [String:AnyObject]{
            self.contact = ZDTaskContact(taskContact: contactJson, orgId: orgId)
        }
    }
}

@objc public class ZDTaskContact:NSObject{
    
    @objc public var orgId = ""
    @objc public var firstName:String?
    @objc public var lastName  = ""
    @objc public var id = ""
    
    
    @objc public override init() {}
    
    @objc public init(taskContact:[String:AnyObject],orgId:String) {
        super.init()
        
        self.orgId = orgId
        
        self.firstName = taskContact["firstName"] as? String
        self.id = taskContact["id"].toString()
        self.lastName = taskContact["lastName"].toString()
    }
}
