//
//  Account.swift
//  Pods
//
//  Created by rajeshkumar.l on 16/10/17.
//  Copyright © 2017 rajesh-2098. All rights reserved.
//
import Foundation

@objc public class ZDAccount : ZDSearch {
    
    @objc public var website:String?
    @objc public var phone:String?
    @objc public var email:String?
    @objc public var accountName = ""
    @objc public var id          = ""
    
    @objc public var orgId = ""
    
    @objc public class func modelsFromArray(dic:[String:AnyObject]?,orgId:String) -> [ZDAccount]?{
        
        var model = [ZDAccount]()
        guard let array = dic?["data"] as? [[String:AnyObject]] else { return nil}
        for item in array{
            if let object =  ZDAccount(accountJsonReponce:item, orgId: orgId){
                model.append(object)
            }
        }
        return model
        
    }
    
    @objc public init?(accountJsonReponce: [String:AnyObject]?,orgId:String) {
        
        guard let accountJson = accountJsonReponce else { return nil}
        
        self.orgId = orgId
        
        website     = accountJson["website"].toString()
        phone     = accountJson["phone"].toString()
        email     = accountJson["email"].toString()
        accountName = accountJson["accountName"].toString()
        id          = accountJson["id"].toString()
        
    }
}
