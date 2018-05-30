//
//  ZDSearch.swift
//  ZohoDeskSDK
//
//  Created by Rajeshkumar Lingavel on 25/05/18.
//  Copyright © 2018 rajesh-2098. All rights reserved.
//

import Foundation

@objc public class ZDSearch: NSObject {
    
}

@objc public class ZDTicketSearch: NSObject {
    
    internal var orgId  = ""
    @objc public var tickets = [ZDTicketDetail]()
    @objc public var count = 0
    
    internal init?(json:[String:AnyObject],orgId:String) {
        self.orgId = orgId
        self.count = json["count"].toInt()
        if let ticketJson = json["data"] as? [[String:AnyObject]]{
            self.tickets = ticketJson.map({ZDTicketDetail(ticketDetailJsonObject: $0, orgId: orgId)})
        }
    }
}


@objc public class ZDTaskSearch: NSObject {
    
    internal var orgId  = ""
    @objc public var tasks = [ZDTask]()
    @objc public var count = 0
    
    internal init?(json:[String:AnyObject],orgId:String) {
        self.orgId = orgId
        self.count = json["count"].toInt()
        if let taskJson = json["data"] as? [[String:AnyObject]]{
            self.tasks = taskJson.map({ZDTask(taskJsonReponce: $0, orgId: orgId)!})
        }
    }
}

@objc public class ZDContactSearch: NSObject {
    
    internal var orgId  = ""
    @objc public var tickets = [ZDContactDetail]()
    @objc public var count = 0
    
    internal init?(json:[String:AnyObject],orgId:String) {
        self.orgId = orgId
        self.count = json["count"].toInt()
        if let contactJson = json["data"] as? [[String:AnyObject]]{
            self.tickets = contactJson.map({ZDContactDetail(contactDetailJson: $0, orgId: orgId)})
        }
    }
}

@objc public class ZDAccountSearch: NSObject {
    
    internal var orgId  = ""
    @objc public var account = [ZDAccount]()
    @objc public var count = 0
    
    internal init?(json:[String:AnyObject],orgId:String) {
        self.orgId = orgId
        self.count = json["count"].toInt()
        if let accountJson = json["data"] as? [[String:AnyObject]]{
            for json in accountJson {
                if let account = ZDAccount(accountJsonReponce: json, orgId: orgId){
                    self.account.append(account)
                }
            }
        }
    }
}