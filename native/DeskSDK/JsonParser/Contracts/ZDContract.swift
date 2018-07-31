//
//  ZDContracts.swift
//  ZohoDeskSDK
//
//  Created by rajesh-2098 on 09/05/18.
//  Copyright © 2018 rajesh-2098. All rights reserved.
//

import Foundation

 @objc public class ZDContract : NSObject {
    
    @objc public var orgId = ""
    
    @objc public var associatedSLAId     = ""//
    @objc public var modifiedTime        = ""//
    @objc public var productId:String?
    @objc public var endDate:String?
    @objc public var departmentId        = ""//
    @objc public var notifyBefore:String?
    @objc public var contractNumber:String?
    @objc public var contractDescription:String?
    @objc public var ownerId             = ""//
    @objc public var accountId           = ""//
    @objc public var createdBy           = "" //
    @objc public var notifyOn:String?
    @objc public var createdTime         = ""//
    @objc public var contractName        = ""//
    @objc public var modifiedBy          = ""//
    @objc public var id                  = ""//
    @objc public var startDate           = ""//
    
    @objc public var customFields : [String:AnyObject]?
    @objc public var notificationAgentIds : [Int]?//??????
    
    //Account,Product,SLA

    
    //Details
    
    
    @objc public class func modelsFromDArray(json:[String:AnyObject]?,orgId:String) -> [ZDContract]?{
        guard let jsonObjectArray = json?["data"] as? [[String:AnyObject]] else {return nil}
        return jsonObjectArray.map({ZDContract(json: $0, orgId: orgId)})
    }
    
    @objc public init(json:[String:AnyObject],orgId:String)  {

        self.orgId = orgId
        
        associatedSLAId     = json["associatedSLAId"].toString()
        modifiedTime        = json["modifiedTime"].toString()
        productId           = json["productId"].toString()
        endDate             = json["endDate"].toString()
        departmentId        = json["departmentId"].toString()
        notifyBefore        = json["notifyBefore"].toString()
        contractNumber      = json["contractNumber"].toString()
        contractDescription = json["description"].toString()
        ownerId             = json["ownerId"].toString()
        accountId           = json["accountId"].toString()
        createdBy           = json["createdBy"].toString()
        notifyOn            = json["notifyOn"].toString()
        createdTime         = json["createdTime"].toString()
        contractName        = json["contractName"].toString()
        modifiedBy          = json["modifiedBy"].toString()
        id                  = json["id"].toString()
        startDate           = json["startDate"].toString()
        
        if let customFields = json["customFields"] as? [String:AnyObject]{
            self.customFields = customFields
        }
        
        if let notificationAgentIds = json["notificationAgentIds"] as? [Int]{
            self.notificationAgentIds = notificationAgentIds
        }

    }
}

@objc public class ZDContractDetail : ZDContract{}
