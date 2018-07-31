
//  ZDTicket.swift
//  Pods
//
//  Created by rajeshkumar.l.
//  Copyright © 2017 rajesh-2098. All rights reserved.
//

import Foundation
 
///Tickets
///Tickets are organizing units using which service agents handle customer enquiries, requests, complaints, and other such interactions in Zoho Desk.
@objc public class ZDTicket : NSObject {

    @objc public var ticketNumber         = ""
    @objc public var customerResponseTime = ""

    ///Product to which the ticket is mapped
    @objc public var productId:String?

    ///Contact who raised the ticket.
    @objc public var contactId            = ""

    ///Ticket subject
    @objc public var subject              = ""

    //Ticket dueDate
    @objc public var dueDate:String?

    //Department to which the ticket belongs.
    @objc public var departmentId         = ""

    //Channel through which the ticket originated.
    @objc public var channel:String?
    @objc public var threadCount          = ""

    //Ticket priority
    @objc public var priority:String?

    ///ID of agent to whom the ticket is assigned.
    @objc public var assigneeId:String?
    @objc public var closedTime:String?
    @objc public var commentCount         = ""

    //Phone number in the ticket
    @objc public var phone:String?
    @objc public var createdTime          = ""

    ///Id of the ticket.
    @objc public var id                   = ""

    ///Email ID in the ticket.
    @objc public var email:String?

    ///Status of the ticket. Includes the custom statuses that exist in your help desk.
    @objc public var status               = ""

    @objc public var teamId:String?

    @objc public var contact : ZDContact?
    @objc public var product : ZDProduct?

    @objc public var webUrl               = ""
    @objc public var ticketDetail:ZDTicketDetail?

    @objc public var lastThread:ZDLastThread?

    @objc public var assignee:ZDAssignee?
    @objc public var orgId:String         = ""

    @objc public  init(orgId:String,ticketId:String){
        self.orgId = orgId
        self.id = ticketId
    }
    
    @objc public  override init() {}

    @objc public  class func modelsFromDictionary(dictionary:[String:AnyObject],orgId:String) -> [ZDTicket] {
        
        guard let array:[[String:AnyObject]] = dictionary["data"] as? [[String : AnyObject]] else{
            return [ZDTicket]()
        }
        
        return modelsFromArray(array: array,orgId:orgId)
    }
    
    @objc public  class func modelsFromArray(array:[[String:AnyObject]],orgId:String) -> [ZDTicket]{
        
        return array.map{ZDTicket(ticketJsonObject: $0,orgId:orgId)}
        
    }


    @objc public  init(ticketJsonObject: [String:AnyObject],orgId:String) {
        
        self.orgId = orgId
        ticketNumber         = ticketJsonObject["ticketNumber"].toString()
        customerResponseTime = ticketJsonObject["customerResponseTime"].toString()
        productId            = ticketJsonObject["productId"] as? String
        contactId            = ticketJsonObject["contactId"].toString()
        subject              = ticketJsonObject["subject"].toString()
        dueDate              = ticketJsonObject["dueDate"] as? String
        departmentId         = ticketJsonObject["departmentId"].toString()
        channel              = ticketJsonObject["channel"].toString()
        threadCount          = ticketJsonObject["threadCount"].toString()
        priority             = ticketJsonObject["priority"] as? String
        assigneeId           = ticketJsonObject["assigneeId"].toString()
        closedTime           = ticketJsonObject["closedTime"].toString()
        commentCount         = ticketJsonObject["commentCount"].toString()
        phone                = ticketJsonObject["phone"] as? String
        createdTime          = ticketJsonObject["createdTime"].toString()
        id                   = ticketJsonObject["id"].toString()
        email                = ticketJsonObject["email"] as? String
        status               = ticketJsonObject["status"].toString()
        webUrl               = ticketJsonObject["webUrl"].toString()
        teamId             = ticketJsonObject["teamId"] as? String

        if let contacts = ticketJsonObject["contact"] as? [String:AnyObject]{
            contact = ZDContact(contactJsonReponce: contacts, orgId: orgId)
        }
        
        if let productJson = ticketJsonObject["product"] as? [String:AnyObject]{
            self.product = ZDProduct(productJsonReponce: productJson, orgId: orgId)
        }
        
        if let lastThread = ticketJsonObject["lastThread"] as? [String:AnyObject]{
            self.lastThread = ZDLastThread(lastThreadJsonReponce: lastThread, orgId: orgId)
        }
        
        if let assignee = ticketJsonObject["assignee"] as? [String:AnyObject]{
            self.assignee = ZDAssignee(assignee: assignee)
        }
        
        
    }
}


extension ZDTicket{
    private func migrateTicketData(ticketDetail:ZDTicketDetail) ->Void{
        self.ticketNumber = ticketDetail.ticketNumber
        self.id = ticketDetail.id
        self.phone = ticketDetail.phone
        self.subject = ticketDetail.subject
        
        self.status = ticketDetail.status
        self.createdTime = ticketDetail.createdTime
        self.priority = ticketDetail.priority
        self.channel = ticketDetail.channel
        self.dueDate = ticketDetail.dueDate
        self.commentCount = ticketDetail.commentCount
        self.threadCount = ticketDetail.threadCount
        self.closedTime = ticketDetail.closedTime
        self.departmentId = ticketDetail.departmentId
        self.contactId = ticketDetail.contactId
        self.productId = ticketDetail.productId
        self.assigneeId = ticketDetail.assigneeId
        self.teamId = ticketDetail.teamId
        self.ticketDetail = ticketDetail
        self.customerResponseTime = ticketDetail.customerResponseTime
        self.assignee = ticketDetail.assignee
    }
    
}

@objc public class ZDAssignee:NSObject{
    
    @objc public var email  = ""
    @objc public var firstName:String?
    @objc public var id  = ""
    @objc public var lastName  = ""
    @objc public var photoURL:String?

    @objc public  override init() {super.init()}
    
    @objc public  init(assignee:[String:AnyObject]) {
        super.init()
        self.email = assignee["email"].toString()
        self.firstName = assignee["firstName"] as? String
        self.id = assignee["id"].toString()
        self.lastName = assignee["lastName"].toString()
        self.photoURL = assignee["photoURL"] as? String
    }
}


