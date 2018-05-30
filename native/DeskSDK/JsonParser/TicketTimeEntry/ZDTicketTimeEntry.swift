//
//  ZDTicketTimeEntry.swift
//  Pods
//
//  Created by rajeshkumar.l.
//  Copyright © 2017 rajesh-2098. All rights reserved.
//


import Foundation

@objc public class ZDTicketTimeEntry:NSObject {

    @objc public var secondsSpent:String?
    @objc public var executedTime:String?
    @objc public var customFields : [String:AnyObject]?
    @objc public var minutesSpent:String?
    @objc public var creatorId                 = ""
    @objc public var agentCostPerHour:String?
    @objc public var timeEntrydescription:String?
    @objc public var hoursSpent:String?
    @objc public var ownerId:String?
    @objc public var createdTime               = ""
    @objc public var id                        = ""
    @objc public var requestChargeType         = ""
    @objc public var additionalCost:String?
    @objc public var totalCost : String?
    @objc public var invoiceId:String?
    @objc public var owner = ZDAuthor()
    internal var orgId = ""
    
    public class func modelsFrom(dic:[String:AnyObject],orgId:String) -> [ZDTicketTimeEntry]
    {
        var models:[ZDTicketTimeEntry] = []
        guard let array = dic["data"] as? [[String:AnyObject]] else { return models }
        for item in array
        {
            models.append(ZDTicketTimeEntry(ticketTimeEntryJson: item, orgId: orgId))
        }
        return models
    }

    internal init(ticketTimeEntryJson: [String:AnyObject],orgId:String) {

        self.orgId = orgId
        
        secondsSpent         = ticketTimeEntryJson["secondsSpent"] as? String
        executedTime         = ticketTimeEntryJson["executedTime"]as? String
        minutesSpent         = ticketTimeEntryJson["minutesSpent"]as? String
        creatorId            = ticketTimeEntryJson["creatorId"].toString()
        agentCostPerHour     = ticketTimeEntryJson["agentCostPerHour"] as? String
        timeEntrydescription = ticketTimeEntryJson["description"] as? String
        hoursSpent           = ticketTimeEntryJson["hoursSpent"] as? String
        ownerId              = ticketTimeEntryJson["ownerId"] as? String
        createdTime          = ticketTimeEntryJson["createdTime"].toString()
        id                   = ticketTimeEntryJson["id"].toString()
        requestChargeType    = ticketTimeEntryJson["requestChargeType"].toString()
        additionalCost       = ticketTimeEntryJson["additionalCost"] as? String
        totalCost            = ticketTimeEntryJson["totalCost"] as? String
        invoiceId            = ticketTimeEntryJson["invoiceId"] as? String
        
        if let customFields = ticketTimeEntryJson["customFields"] as? [String:AnyObject]{
            self.customFields = customFields
        }
        if let owner = ticketTimeEntryJson["owner"] as? [String:AnyObject]{
            self.owner = ZDAuthor(author: owner)
        }
	}

}
