//
//  ZDContactDetail.swift
//  Pods
//
//  Created by rajeshkumar.l on 30/10/17.
//
//

import Foundation

@objc public class ZDContactDetail :NSObject {

    public var state:String?
    public var twitter:String?
    public var createdTime       = ""
    public var zip:String?
    public var customFields : [String:AnyObject]?
    public var title:String?
    public var secondaryEmail:String?
    public var zohoCRMContact:ZDZohoCRMContact?
    public var city:String?
    public var mobile:String?
    public var ownerId:String?
    public var facebook:String?
    public var street:String?
    public var contactDescription:String?
    public var customerHappiness = ZDCustomerHappiness()
    public var accountId:String?
    public var modifiedTime      = "" 
    public var country:String?
    public var firstName:String?
    public var lastName          = ""
    public var phone:String?
    public var photoURL:String?
    public var id                = ""
    public var type:String?
    public var email:String?
    public var account : ZDAccount?
    public var isDeleted         = false
    
    
    internal var orgId = ""
    
    public class func modelsFromArray(dic:[String:AnyObject],orgId:String) -> [ZDContactDetail]{
        
        if let array = dic["data"] as? [[String:AnyObject]]{
            return array.map{ZDContactDetail(contactDetailJson: $0, orgId: orgId)}
        }
        return [ZDContactDetail]()
        
    }
    
    internal init(contactDetailJson: [String:AnyObject],orgId:String) {
        
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

