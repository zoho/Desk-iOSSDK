//
//  ZDAgent.swift
//  Pods
//
//  Created by rajeshkumar.l.
//  Copyright © 2017 rajesh-2098. All rights reserved.
//

import Foundation

@objc open class ZDAgent:NSObject {

    @objc public var orgId       = ""
    @objc public var lastName    = ""
    @objc public var extn:String?
    @objc public var roleId:String?
    @objc public var langCode:String?
    @objc public var mobile:String?
    @objc public var emailId     = ""
    @objc public var zuid:String?
    @objc public var firstName:String?
    @objc public var photoURL:String?
    @objc public var phone:String?
    @objc public var profileId:String?
    @objc public var countryCode:String?
    @objc public var isConfirmed = false
    @objc public var id          = ""
    @objc public var status:String?
    @objc public var timeZone:String?
    
    @objc public var associatedDepartmentIds = [String]()
    @objc public var associatedChatDepartmentIds : [String]?

    @objc open class func modelsFrom(orgId:String,dic:[String:AnyObject]?) -> [ZDAgent]?
    {
        var models:[ZDAgent] = []
        guard let array = dic?["data"] as? [[String:AnyObject]] else{return models}
        for item in array
        {
            if let agentObject = ZDAgent(orgId: orgId,agentJsonReponce: item){
                models.append(agentObject)
            }
        }
        return models
    }
    
   @objc public override init() {}
   @objc public init?(orgId:String,agentJsonReponce: [String:AnyObject]?) {

        guard let agentJson = agentJsonReponce else { return nil }
        self.orgId       = orgId
        lastName    = agentJson["lastName"].toString()
        extn        = agentJson["extn"].toString()
        roleId      = agentJson["roleId"].toString()
        langCode    = agentJson["langCode"].toString()
        mobile      = agentJson["mobile"].toString()
        emailId     = agentJson["emailId"].toString()
        zuid        = agentJson["zuid"].toString()
        firstName   = agentJson["firstName"].toString()
        photoURL    = agentJson["photoURL"].toString()
        phone       = agentJson["phone"].toString()
        profileId   = agentJson["profileId"].toString()
        countryCode = agentJson["countryCode"].toString()
        isConfirmed = agentJson["isConfirmed"].toBool()
        id          = agentJson["id"].toString()
        status      = agentJson["status"].toString()
        timeZone    = agentJson["timeZone"].toString()
        
        if let associatedDepartmentIds = agentJson["associatedDepartmentIds"] as? [String]{
            self.associatedDepartmentIds = associatedDepartmentIds
        }
        
        if let associatedChatDepartmentIds = agentJson["associatedChatDepartmentIds"] as? [String]{
            self.associatedChatDepartmentIds = associatedChatDepartmentIds
        }
	}
}

@objc open class ZDAgentDetail:ZDAgent{
    
    @objc public override init() {super.init()}
    
    @objc public var associatedChatDepartments = [ZDAssociatedChatDepartments]() // object
    @objc public var associatedDepartments = [ZDAssociatedDepartments]() // object
    @objc public var role = ZDRole()
    @objc public var profile = ZDProfile()
    
    @objc public override init?(orgId:String,agentJsonReponce: [String:AnyObject]?) {
        super.init(orgId: orgId, agentJsonReponce: agentJsonReponce)
        guard let agentJson = agentJsonReponce else { return nil }
        
        if let chatDepartments = agentJson["associatedChatDepartments"] as? [[String:AnyObject]]{
            self.associatedChatDepartments = chatDepartments.map({ZDAssociatedChatDepartments(orgId: orgId, jsonReponce: $0)})
        }
        if let departments = agentJson["associatedDepartments"] as? [[String:AnyObject]]{
            self.associatedDepartments = departments.map({ZDAssociatedDepartments(orgId: orgId, jsonReponce: $0)})
        }
        
        if let roleJson = agentJson["role"] as? [String:AnyObject]{
            self.role = ZDRole(orgId: orgId, jsonReponce: roleJson)
        }
        
        if let profileJson = agentJson["profile"] as? [String:AnyObject]{
            self.profile = ZDProfile(orgId: orgId, jsonReponce: profileJson)
        }
    }
    
}

@objc open class ZDObjectHolder:NSObject{
    
    @objc public var orgId = ""
    @objc public var name = ""
    @objc public var id = ""
    
    @objc public override init() {}
    @objc public init(orgId:String,jsonReponce: [String:AnyObject]) {
        self.name = jsonReponce["name"].toString()
        self.id = jsonReponce["id"].toString()
    }
}

@objc open class ZDAssociatedDepartments:ZDObjectHolder{
    

    @objc public override init() {super.init()}
    @objc public override init(orgId:String,jsonReponce: [String:AnyObject]) {
        super.init(orgId: orgId, jsonReponce: jsonReponce)
    }
}

@objc open class ZDAssociatedChatDepartments:ZDObjectHolder{
    
    @objc public override init() {super.init()}
    @objc public override init(orgId:String,jsonReponce: [String:AnyObject]) {
       super.init(orgId: orgId, jsonReponce: jsonReponce)
    }
}

@objc open class ZDProfile:ZDObjectHolder{
    
    @objc public override init() {super.init()}
    @objc public override init(orgId:String,jsonReponce: [String:AnyObject]) {
        super.init(orgId: orgId, jsonReponce: jsonReponce)
    }
}

@objc open class ZDRole:ZDObjectHolder{
    
    @objc public override init() {super.init()}
    @objc public override init(orgId:String,jsonReponce: [String:AnyObject]) {
        super.init(orgId: orgId, jsonReponce: jsonReponce)
    }
}
