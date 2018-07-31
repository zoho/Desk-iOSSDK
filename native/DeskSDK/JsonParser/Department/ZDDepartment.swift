//
//  ZDDepartment.swift
//  Pods
//
//  Created by rajeshkumar.l.
//  Copyright © 2017 rajesh-2098. All rights reserved.
//

import Foundation

/// Departments are the organizational divisions configured in your helpdesk.
@objc public class ZDDepartment : NSObject {
    
    ///Is this is default department for particular organization
    @objc public var isDefault                 = false
    
    ///States whether the department has a logo
    @objc public var hasLogo                   = false
    
    ///Visibility of the department in the customer portal
    @objc public var isVisibleInCustomerPortal = false
    
    ///Activation status of the department
    @objc public var isEnabled                 = false
    
    ///ID of user who created the department
    @objc public var creatorId                 = ""
    
    ///Department name
    @objc public var name                      = ""
    
    ///Description of the department
    @objc public var departmentDescription:String?
    
    ///IDs of agents associated with the department
    @objc public var associatedAgentIds        = [String]()
    
    ///ID of the department
    @objc public var id                        = ""
    
    ///Display name of the department
    @objc public var nameInCustomerPortal      = ""

    @objc public var orgId                   = ""
    
    @objc public class func modelsFromDictionaryArray(dic:[String: AnyObject]?,orgId:String) -> [ZDDepartment]?{
        var models:[ZDDepartment] = []
        guard let array = dic?["data"] as? [[String:AnyObject]] else { return models }
        for item in array{
            if let departmentObject = ZDDepartment(departmentJsonReponce: item, orgId: orgId){
                models.append(departmentObject)
            }
        }
        return models
    }

    @objc public init?(departmentJsonReponce: [String:AnyObject]?,orgId:String) {

        guard let departmentJson = departmentJsonReponce else { return nil }
        
        self.orgId = orgId
        
        isDefault                 = departmentJson["isDefault"].toBool()
        hasLogo                   = departmentJson["hasLogo"].toBool()
        isVisibleInCustomerPortal = departmentJson["isVisibleInCustomerPortal"].toBool()
        isEnabled                 = departmentJson["isEnabled"].toBool()
        creatorId                 = departmentJson["creatorId"].toString()
        name                      = departmentJson["name"].toString()
        departmentDescription     = departmentJson["description"].toString()
        id                        = departmentJson["id"].toString()
        nameInCustomerPortal      = departmentJson["nameInCustomerPortal"].toString()
        
        if let associatedAgentIds = departmentJson["associatedAgentIds"] as? [String]{
            self.associatedAgentIds   = associatedAgentIds
        }
	}
}
