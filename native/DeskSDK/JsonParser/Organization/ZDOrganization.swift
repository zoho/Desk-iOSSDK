//
//  ZDOrganization.swift
//  DeskSDK
//
//  Created by rajesh-2098 on 07/05/18.
//  Copyright © 2018 rajesh-2098. All rights reserved.
//

import Foundation
///Organizations
//In Zoho Desk, each business is categorized as an organization. If you have multiple businesses, set each business up as an individual organization by creating a new signup and generating a unique organization ID. All APIs except the ones directly related to organizations must include the organization ID in the header in this format: orgId:{organization_id}
@objc public class ZDOrganization :NSObject {
    
    ///Field that returns if the organization is the default organization of a user.
    public var isDefault        = false
    
    ///Phone number of the organization
    public var phoneNumber  = ""
    
    ///Portal name of the organization as it appears in Zoho Desk , it contains lower case letters and numbers only.
    public var organizationName = ""
    
    ///Actual company name of the organization/business.
    public var companyName      = ""
    
    ///URL of the organization
    public var portalURL        = ""
    
    ///Unique ID of the Organization
    public var id               = ""
    
    ///URL of the organization's logo image file
    public var logoURL          = ""
    
    ///Field that returns if the user is an admin in the organization.
    public var isAdminInOrg     = false
    
    //This will privent create Object from outside
    fileprivate override init() {}
    
    ///Helper method 
    internal class func modelsFromDictionary(dictionary:[String:AnyObject]) -> [ZDOrganization]{
        
        guard let array:[[String:AnyObject]] = dictionary["data"] as? [[String : AnyObject]] else{
            return [ZDOrganization]()
        }
        return modelsFromArray(array: array)
    }
    
    internal class func modelsFromArray(array:[[String:AnyObject]]) -> [ZDOrganization]{
        
        var models:[ZDOrganization] = []
        
        models = array.map{ZDOrganization(dictionary:$0)}
        return models
    }
    
    
    
    internal init(dictionary: [String:AnyObject]) {
        super.init()
        
        isDefault        = dictionary["isDefault"].toBool()
        phoneNumber      = dictionary["phoneNumber"].toString()
        organizationName = dictionary["organizationName"].toString()
        companyName      = dictionary["companyName"].toString()
        portalURL        = dictionary["portalURL"].toString()
        id               = dictionary["id"].toString()
        logoURL          = dictionary["logoURL"].toString()
        isAdminInOrg     = dictionary["isAdminInOrg"].toBool()
        
    }
}
