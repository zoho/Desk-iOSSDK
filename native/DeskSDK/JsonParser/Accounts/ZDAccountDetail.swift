//
//  ZDAccountDetail.swift
//  Pods
//
//  Created by rajeshkumar.l.
//  Copyright © 2017 rajesh-2098. All rights reserved.
//

import Foundation
 

@objc public class ZDAccountDetail:NSObject {

    public var country:String?
    public var modifiedTime:String?
    public var website:String?
    public var code:String?
    public var accountName        = ""
    public var city:String?
    public var customFields : [String:AnyObject]?
    public var accountDescription:String?
    public var industry:String?
    public var ownerId:String?
    public var phone:String?
    public var street:String?
    public var annualrevenue:String?
	public var associateSLAs : [AnyObject]?
    public var createdTime        = ""
    public var state:String?
    public var id                 = ""
    public var fax:String?
    public var email:String?


    internal var orgId = ""
    
    internal class func modelsFromDic(dic:[String:AnyObject],orgId:String) -> [ZDAccountDetail]
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


    internal init?(accountJsonReponce: [String:AnyObject]?,orgId:String) {
        
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
