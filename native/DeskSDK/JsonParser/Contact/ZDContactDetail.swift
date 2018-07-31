//
//  ZDContactDetail.swift
//  Pods
//
//  Created by rajeshkumar.l on 30/10/17.
//
//

import Foundation

@objc public class ZDContactDetail :NSObject {

    @objc public var state:String?
    @objc public var twitter:String?
    @objc public var createdTime       = ""
    @objc public var zip:String?
    @objc public var customFields : [String:AnyObject]?
    @objc public var title:String?
    @objc public var secondaryEmail:String?
    @objc public var zohoCRMContact:ZDZohoCRMContact?
    @objc public var city:String?
    @objc public var mobile:String?
    @objc public var ownerId:String?
    @objc public var facebook:String?
    @objc public var street:String?
    @objc public var contactDescription:String?
    @objc public var customerHappiness = ZDCustomerHappiness()
    @objc public var accountId:String?
    @objc public var modifiedTime      = ""
    @objc public var country:String?
    @objc public var firstName:String?
    @objc public var lastName          = ""
    @objc public var phone:String?
    @objc public var photoURL:String?
    @objc public var id                = ""
    @objc public var type:String?
    @objc public var email:String?
    @objc public var account : ZDAccount?
    @objc public var isDeleted         = false
    
    
    @objc public var orgId = ""
    
    @objc public class func modelsFromArray(dic:[String:AnyObject],orgId:String) -> [ZDContactDetail]{
        
        if let array = dic["data"] as? [[String:AnyObject]]{
            return array.map{ZDContactDetail(contactDetailJson: $0, orgId: orgId)}
        }
        return [ZDContactDetail]()
        
    }
    
    @objc public init(contactDetailJson: [String:AnyObject],orgId:String) {
        
        self.orgId = orgId

        firstName      = contactDetailJson["firstName"].toString()
        lastName       = contactDetailJson["lastName"].toString()
        phone          = contactDetailJson["phone"].toString()
        id             = contactDetailJson["id"].toString()
        type           = contactDetailJson["type"].toString()
        email          = contactDetailJson["email"].toString()

        state          = contactDetailJson["state"].toString()
        twitter        = contactDetailJson["twitter"].toString()
        createdTime    = contactDetailJson["createdTime"].toString()
        zip            = contactDetailJson["zip"].toString()
        customFields   = contactDetailJson["customFields"] as? [String:AnyObject]
        title          = contactDetailJson["title"].toString()
        secondaryEmail = contactDetailJson["secondaryEmail"].toString()
        city           = contactDetailJson["city"].toString()
        mobile         = contactDetailJson["mobile"].toString()
        ownerId        = contactDetailJson["ownerId"].toString()
        facebook       = contactDetailJson["facebook"].toString()
        street         = contactDetailJson["street"].toString()
        contactDescription    = contactDetailJson["description"].toString()
        accountId      = contactDetailJson["accountId"].toString()
        modifiedTime   = contactDetailJson["modifiedTime"].toString()
        country        = contactDetailJson["country"].toString()
        isDeleted      = contactDetailJson["isDeleted"].toBool()
        photoURL       = contactDetailJson["photoURL"].toString()


        if let customerHappiness = contactDetailJson["customerHappiness"] as? [String:AnyObject]{
            self.customerHappiness = ZDCustomerHappiness(cutomerHappinessJson: customerHappiness,orgId: orgId)
        }
        
        if let accounts = contactDetailJson["account"] as? [String:AnyObject]{
            account = ZDAccount(accountJsonReponce: accounts, orgId: orgId)
        }
        
        if let zohoCRMContactJson = contactDetailJson["zohoCRMContact"] as? [String:AnyObject]{
            zohoCRMContact = ZDZohoCRMContact(zohoCRMJsonReponce: zohoCRMContactJson, orgId: orgId)
        }
    }
}

