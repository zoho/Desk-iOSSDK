
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

    public var ticketNumber         = ""
    public var customerResponseTime = ""

    ///Product to which the ticket is mapped
    public var productId:String?

    ///Contact who raised the ticket.
    public var contactId            = ""

    ///Ticket subject
    public var subject              = ""

    //Ticket dueDate
    public var dueDate:String?

    //Department to which the ticket belongs.
    public var departmentId         = ""

    //Channel through which the ticket originated.
    public var channel:String?
    public var threadCount          = ""

    //Ticket priority
    public var priority:String?

    ///ID of agent to whom the ticket is assigned.
    public var assigneeId:String?
    public var closedTime:String?
    public var commentCount         = ""

    //Phone number in the ticket
    public var phone:String?
    public var createdTime          = ""

    ///Id of the ticket.
    public var id                   = ""

    ///Email ID in the ticket.
    public var email:String?

    ///Status of the ticket. Includes the custom statuses that exist in your help desk.
    public var status               = ""

    public var teamId:String?

    public var contact : ZDContact?
    public var product : ZDProduct?

    public var webUrl               = ""
    public var ticketDetail:ZDTicketDetail?

    public var lastThread:ZDLastThread?

    public var assignee:ZDAssignee?
    public var orgId:String         = ""

    public init(orgId:String,ticketId:String){
        self.orgId = orgId
        self.id = ticketId
    }
    
    public override init() {}

    internal class func modelsFromDictionary(dictionary:[String:AnyObject],orgId:String) -> [ZDTicket] {
        
        guard let array:[[String:AnyObject]] = dictionary["data"] as? [[String : AnyObject]] else{
            return [ZDTicket]()
        }
        
        return modelsFromArray(array: array,orgId:orgId)
    }
    
    internal class func modelsFromArray(array:[[String:AnyObject]],orgId:String) -> [ZDTicket]{
        
        return array.map{ZDTicket(ticketJsonObject: $0,orgId:orgId)}
        
    }


    internal init(ticketJsonObject: [String:AnyObject],orgId:String) {
        
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
    
    public var email  = ""
    public var firstName:String?
    public var id  = ""
    public var lastName  = ""
    public var photoURL:String?

    internal override init() {super.init()}
    
    internal init(assignee:[String:AnyObject]) {
        super.init()
        self.email = assignee["email"].toString()
        self.firstName = assignee["firstName"] as? String
        self.id = assignee["id"].toString()
        self.lastName = assignee["lastName"].toString()
        self.photoURL = assignee["photoURL"] as? String
    }
}


