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

    @objc public var modifiedTime:String?
    @objc public var ticketNumber         = ""
    @objc public var subCategory:String?
    @objc public var subject              = ""
    @objc public var customFields : [String:AnyObject]?
    @objc public var dueDate:String?
    @objc public var departmentId         = ""
    @objc public var channel:String?
    @objc public var ticketDescription:String?
    @objc public var resolution:String?
    @objc public var closedTime:String?
    @objc public var approvalCount        = ""
    @objc public var timeEntryCount       = ""
    @objc public var createdTime          = ""
    @objc public var id                   = ""
    @objc public var email:String?
    @objc public var customerResponseTime = ""
    @objc public var product:ZDProduct?
    @objc public var productId:String?
    @objc public var contactId            = ""
    @objc public var threadCount          = ""
    @objc public var priority:String?
    @objc public var classification:String?
    @objc public var assigneeId:String?
    @objc public var commentCount         = ""
    @objc public var taskCount            = ""
    @objc public var phone:String?
    @objc public var attachmentCount      = ""
    @objc public var category:String?
    @objc public var status               = ""
    @objc public var statusType           = ""
    @objc public var layoutId             = ""
    @objc public var modifiedBy:String?
    @objc public var teamId:String?
    @objc public var webUrl               = ""
    @objc public var contact : ZDContact?
    @objc public var lastThread:ZDLastThread?
    @objc public var responseDueDate:String?
    @objc public var isResponseOverdue = ""
    @objc public var accountId:String?
    @objc public var isSpam = ""
    
    @objc public var assignee:ZDAssignee?

    @objc public var orgId = ""

    @objc public  override init() {super.init()}

    @objc public  init(ticketDetailJsonObject: [String:AnyObject],orgId:String) {
        
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
