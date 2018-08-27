//
//  ZDAccountDetail.swift
//  Pods
//
//  Created by rajeshkumar.l.
//  Copyright © 2017 rajesh-2098. All rights reserved.
//

import Foundation
 

@objc open class ZDAccountDetail:NSObject {

    @objc public var country:String?
    @objc public var modifiedTime:String?
    @objc public var website:String?
    @objc public var code:String?
    @objc public var accountName        = ""
    @objc public var city:String?
    @objc public var customFields : [String:AnyObject]?
    @objc public var accountDescription:String?
    @objc public var industry:String?
    @objc public var ownerId:String?
    @objc public var phone:String?
    @objc public var street:String?
    @objc public var annualrevenue:String?
	@objc public var associateSLAs : [AnyObject]?
    @objc public var createdTime        = ""
    @objc public var state:String?
    @objc public var id                 = ""
    @objc public var fax:String?
    @objc public var email:String?


    internal var orgId = ""
    
    @objc open class func modelsFromDic(dic:[String:AnyObject],orgId:String) -> [ZDAccountDetail]
    {
        var models:[ZDAccountDetail] = []
        guard let array = dic["data"] as? [[String:AnyObject]] else { return models }
        
        for item in array
        {
            if let accountDetail = ZDAccountDetail(accountJsonReponce: item, orgId: orgId) {
                models.append(accountDetail)
            }
        }
        return models
    }


    @objc public init?(accountJsonReponce: [String:AnyObject]?,orgId:String) {
        
        guard let accountJson = accountJsonReponce else { return nil }
        
        self.orgId = orgId
        country            = accountJson["country"].toString()
        modifiedTime       = accountJson["modifiedTime"].toString()
        website            = accountJson["website"].toString()
        code               = accountJson["code"].toString()
        accountName        = accountJson["accountName"].toString()
        city               = accountJson["city"].toString()
        accountDescription = accountJson["description"].toString()
        industry           = accountJson["industry"].toString()
        ownerId            = accountJson["ownerId"].toString()
        phone              = accountJson["phone"].toString()
        street             = accountJson["street"].toString()
        annualrevenue      = accountJson["annualrevenue"].toString()
        createdTime        = accountJson["createdTime"].toString()
        state              = accountJson["state"].toString()
        id                 = accountJson["id"].toString()
        fax                = accountJson["fax"].toString()
        email              = accountJson["email"].toString()


        customFields  = accountJson["customFields"] as? [String:AnyObject]
        
        if let associateSLAs =  accountJson["associateSLAs"] as? [AnyObject]{
            self.associateSLAs = associateSLAs
        }
        

	}

}
