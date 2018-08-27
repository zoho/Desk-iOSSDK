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
@objc open class ZDOrganization :NSObject {

    ///Field that returns if the organization is the default organization of a user.
    @objc public var isDefault        = false

    ///Phone number of the organization
    @objc public var phoneNumber      = ""

    ///Portal name of the organization as it appears in Zoho Desk , it contains lower case letters and numbers only.
    @objc public var organizationName = ""

    ///Actual company name of the organization/business.
    @objc public var companyName      = ""

    ///URL of the organization
    @objc public var portalURL        = ""

    ///Unique ID of the Organization
    @objc public var id               = ""

    ///URL of the organization's logo image file
    @objc public var logoURL          = ""

    ///Field that returns if the user is an admin in the organization.
    @objc public var isAdminInOrg     = false

    @objc public var street           = ""
    @objc public var city             = ""
    @objc public var state            = ""
    @objc public var country          = ""
    @objc public var currencyLocale   = ""
    @objc public var zip              = ""
    @objc public var fax              = ""
    @objc public var mobile           = ""

    @objc public var orgDescription   = ""
    @objc public var alias            = ""
    @objc public var employeeCount    = ""
    @objc public var primaryContact   = ""
    @objc public var portalName       = ""

    
    //This will privent create Object from outside
    @objc public override init() {}
    
    ///Helper method Convert Organization json data into array of ZDOrganization
    ///
    /// - Parameter dictionary: List of organization json
    /// - Returns: Array of ZDOrganization data
    @objc open class func modelsFromDictionary(dictionary:[String:AnyObject]) -> [ZDOrganization]{
        
        guard let array:[[String:AnyObject]] = dictionary["data"] as? [[String : AnyObject]] else{
            return [ZDOrganization]()
        }
        return modelsFromArray(array: array)
    }
    
    @objc open class func modelsFromArray(array:[[String:AnyObject]]) -> [ZDOrganization]{
        
        var models:[ZDOrganization] = []
        
        models = array.map{ZDOrganization(dictionary:$0)}
        return models
    }
    
    
    
    @objc public init(dictionary: [String:AnyObject]) {
        super.init()

        isDefault        = dictionary["isDefault"].toBool()
        phoneNumber      = dictionary["phoneNumber"].toString()
        organizationName = dictionary["organizationName"].toString()
        companyName      = dictionary["companyName"].toString()
        portalURL        = dictionary["portalURL"].toString()
        id               = dictionary["id"].toString()
        logoURL          = dictionary["logoURL"].toString()
        isAdminInOrg     = dictionary["isAdminInOrg"].toBool()

        street           = dictionary["street"].toString()
        city             = dictionary["city"].toString()
        state            = dictionary["state"].toString()
        country          = dictionary["country"].toString()
        currencyLocale   = dictionary["currencyLocale"].toString()
        zip              = dictionary["zip"].toString()
        fax              = dictionary["fax"].toString()
        mobile           = dictionary["mobile"].toString()
        orgDescription   = dictionary["orgDescription"].toString()
        alias            = dictionary["alias"].toString()
        employeeCount    = dictionary["employeeCount"].toString()
        primaryContact   = dictionary["primaryContact"].toString()
        portalName       = dictionary["portalName"].toString()

    }
}
