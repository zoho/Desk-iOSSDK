//
//  Contact.swift
//  Pods
//
//  Created by rajeshkumar.l on 16/10/17.
//  Copyright © 2017 rajesh-2098. All rights reserved.
//

import Foundation

public class ZDContact : ZDSearch {

    @objc public var firstName:String?
    @objc public var lastName  = ""
    @objc public var phone:String?
    @objc public var id        = ""
    @objc public var type:String?
    @objc public var email:String?
    @objc public var photoURL:String?
    @objc public var accountId:String?
    @objc public var secondaryEmail:String?
    @objc public var zohoCRMContact:ZDZohoCRMContact?
    @objc public var customerHappiness = ZDCustomerHappiness()
    @objc public var ownerId:String?
	@objc public var account : ZDAccount?

    @objc public var orgId = ""
    
    @objc public class func modelsFromArray(dic:[String:AnyObject]?,orgId:String) -> [ZDContact]?{
        
        var model = [ZDContact]()
        guard let array = dic?["data"] as? [[String:AnyObject]] else{return nil}
        
        for item in array {
            if let contactObject = ZDContact(contactJsonReponce: item, orgId: orgId){
                model.append(contactObject)
            }
        }
        
        return model
        
    }

    @objc public init?(contactJsonReponce: [String:AnyObject]?,orgId:String) {
        
        guard let contactJson = contactJsonReponce else { return nil}
        
        self.orgId = orgId
        
        firstName = contactJson["firstName"] as? String
        lastName  = contactJson["lastName"].toString()
        phone     = contactJson["phone"] as? String
        id        = contactJson["id"].toString()
        type      = contactJson["type"] as? String
        email     = contactJson["email"] as? String
        photoURL  = contactJson["photoURL"] as? String
        accountId  = contactJson["accountId"] as? String
        secondaryEmail = contactJson["secondaryEmail"] as? String
        ownerId = contactJson["ownerId"] as? String
        
        if let accounts = contactJson["account"] as? [String:AnyObject]{
            account = ZDAccount(accountJsonReponce: accounts, orgId: orgId)
        }
        if let zohoCRMContactJson = contactJson["zohoCRMContact"] as? [String:AnyObject]{
            zohoCRMContact = ZDZohoCRMContact(zohoCRMJsonReponce: zohoCRMContactJson, orgId: orgId)
        }
        if let customerHappinessJson = contactJson["customerHappiness"] as? [String:AnyObject]{
            customerHappiness = ZDCustomerHappiness(cutomerHappinessJson: customerHappinessJson, orgId: orgId)
        }
    }


}

@objc public class ZDZohoCRMContact:NSObject{
    @objc public var orgId = ""
    
    @objc public var type = ""
    @objc public var id = ""
    
    @objc public init?(zohoCRMJsonReponce: [String:AnyObject]?,orgId:String) {
        
        guard let zohoCRMJson = zohoCRMJsonReponce else { return nil}
        
        self.orgId = orgId
        
        type = zohoCRMJson["type"].toString()
        id   =  zohoCRMJson["id"].toString()
        
    }
}

@objc public class ZDProduct:NSObject{
    @objc public var orgId = ""
    @objc public var productName = ""
    @objc public var id = ""
    
    @objc public init?(productJsonReponce: [String:AnyObject]?,orgId:String) {
        
        guard let productJson = productJsonReponce else { return nil}
        
        self.orgId = orgId
        
        productName = productJson["productName"].toString()
        id          =  productJson["id"].toString()
        
    }
}
