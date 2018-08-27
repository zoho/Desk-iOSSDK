//
//  ZDCustomerHappiness.swift
//  Pods
//
//  Created by rajeshkumar.l on 30/10/17.
//
//

import Foundation

@objc open class ZDCustomerHappiness: NSObject {
    
    @objc public var badPercentage  = 0
    @objc public var goodPercentage = 0
    @objc public var okPercentage   = 0
    
    @objc public var orgId = ""
    @objc public override init() {}
    @objc public init(cutomerHappinessJson: [String:AnyObject],orgId:String) {
        
        self.orgId = orgId
        badPercentage = cutomerHappinessJson["badPercentage"].toInt()
        goodPercentage  = cutomerHappinessJson["goodPercentage"].toInt()
        okPercentage     = cutomerHappinessJson["okPercentage"].toInt()
        
    }
    
}
