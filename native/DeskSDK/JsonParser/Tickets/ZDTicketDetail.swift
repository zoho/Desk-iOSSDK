//
//  ZDTicketDetail.swift
//  Pods
//
//  Created by rajeshkumar.l.
//  Copyright © 2017 rajesh-2098. All rights reserved.
//


import Foundation
 
//Tickets
//Tickets are organizing units using which service agents handle customer enquiries, requests, complaints, and other such interactions in Zoho Desk.
@objc public class ZDTicketDetail : ZDSearch{

    public var modifiedTime:String?
    public var ticketNumber         = ""
    public var subCategory:String?
    public var subject              = ""
    public var customFields : [String:AnyObject]?
    public var dueDate:String?
    public var departmentId         = ""
    public var channel:String?
    public var ticketDescription:String?
    public var resolution:String?
    public var closedTime:String?
    public var approvalCount        = ""
    public var timeEntryCount       = ""
    public var createdTime          = ""
    public var id                   = ""
    public var email:String?
    public var customerResponseTime = ""
    public var product:ZDProduct?
    public var productId:String?
    public var contactId            = ""
    public var threadCount          = ""
    public var priority:String?
    public var classification:String?
    public var assigneeId:String?
    public var commentCount         = ""
    public var taskCount            = ""
    public var phone:String?
    public var attachmentCount      = ""
    public var category:String?
    public var status               = ""
    public var statusType           = ""
    public var layoutId             = ""
    public var modifiedBy:String?
    public var teamId:String?
    public var webUrl               = ""
    public var contact : ZDContact?
    public var lastThread:ZDLastThread?
    public var responseDueDate:String?
    public var isResponseOverdue = ""
    public var accountId:String?
    public var isSpam = ""
    
    public var assignee:ZDAssignee?

    public var orgId = ""

    public override init() {super.init()}

    internal init(ticketDetailJsonObject: [String:AnyObject],orgId:String) {
        
        super.init()
        self.orgId = orgId

        webUrl               = ticketDetailJsonObject["webUrl"].toString()
        accountId            = ticketDetailJsonObject["accountId"].toString()
        isSpam               = ticketDetailJsonObject["isSpam"].toString()
        responseDueDate      = ticketDetailJsonObject["responseDueDate"].toString()
        isResponseOverdue    = ticketDetailJsonObject["isResponseOverdue"].toString()
        modifiedTime         = ticketDetailJsonObject["modifiedTime"].toString()
        ticketNumber         = ticketDetailJsonObject["ticketNumber"].toString()
        subCategory          = ticketDetailJsonObject["subCategory"].toString()
        subject              = ticketDetailJsonObject["subject"].toString()
        dueDate              = ticketDetailJsonObject["dueDate"].toString()
        departmentId         = ticketDetailJsonObject["departmentId"].toString()
        channel              = ticketDetailJsonObject["channel"].toString()
        ticketDescription    = ticketDetailJsonObject["description"].toString()
        resolution           = ticketDetailJsonObject["resolution"].toString()
        closedTime           = ticketDetailJsonObject["closedTime"].toString()
        approvalCount        = ticketDetailJsonObject["approvalCount"].toString()
        timeEntryCount       = ticketDetailJsonObject["timeEntryCount"].toString()
        createdTime          = ticketDetailJsonObject["createdTime"].toString()
        id                   = ticketDetailJsonObject["id"].toString()
        email                = ticketDetailJsonObject["email"].toString()
        customerResponseTime = ticketDetailJsonObject["customerResponseTime"].toString()
        productId            = ticketDetailJsonObject["productId"].toString()
        contactId            = ticketDetailJsonObject["contactId"].toString()
        threadCount          = ticketDetailJsonObject["threadCount"].toString()
        priority             = ticketDetailJsonObject["priority"].toString()
        classification       = ticketDetailJsonObject["classification"].toString()
        assigneeId           = ticketDetailJsonObject["assigneeId"].toString()
        commentCount         = ticketDetailJsonObject["commentCount"].toString()
        taskCount            = ticketDetailJsonObject["taskCount"].toString()
        phone                = ticketDetailJsonObject["phone"].toString()
        attachmentCount      = ticketDetailJsonObject["attachmentCount"].toString()
        category             = ticketDetailJsonObject["category"].toString()
        status               = ticketDetailJsonObject["status"].toString()
        statusType           = ticketDetailJsonObject["statusType"].toString()

        layoutId               = ticketDetailJsonObject["layoutId"].toString()
        teamId               = ticketDetailJsonObject["teamId"].toString()

        customFields         = ticketDetailJsonObject["customFields"] as? [String:AnyObject]
        modifiedBy           = ticketDetailJsonObject["modifiedBy"].toString()
        
        if let contacts = ticketDetailJsonObject["contact"] as? [String:AnyObject]{
            contact = ZDContact(contactJsonReponce: contacts, orgId: orgId)
        }
        
        if let productJson = ticketDetailJsonObject["product"] as? [String:AnyObject]{
            self.product = ZDProduct(productJsonReponce: productJson, orgId: orgId)
        }
        
        if let lastThread = ticketDetailJsonObject["lastThread"] as? [String:AnyObject]{
            self.lastThread = ZDLastThread(lastThreadJsonReponce: lastThread, orgId: orgId)
        }
        
        if let assignee = ticketDetailJsonObject["assignee"] as? [String:AnyObject]{
            self.assignee = ZDAssignee(assignee: assignee)
        }
}

}
extension ZDTicketDetail {
    
//    public func updateResolution(resolution:String,onComplition:@escaping (((ZDTicketDetail?, Error?, Int))->())){
//        ZDTicketProvoider.updateTicket(orgId, ticketId: id, subject: self.subject, departmentId: self.departmentId, additionalParams: ["resolution":resolution as AnyObject], onComplition: onComplition)
//    }
}
