//
//  ZDCustomerHappiness.swift
//  Pods
//
//  Created by rajeshkumar.l on 30/10/17.
//
//

import Foundation

public class ZDCustomerHappiness: NSObject {
    
    public var badPercentage  = 0
    public var goodPercentage = 0
    public var okPercentage   = 0
    
    internal var orgId = ""
    internal override init() {}
    internal init(cutomerHappinessJson: [String:AnyObject],orgId:String) {
        
        self.orgId = orgId
        badPercentage = cutomerHappinessJson["badPercentage"].toInt()
        goodPercentage  = cutomerHappinessJson["goodPercentage"].toInt()
        okPercentage     = cutomerHappinessJson["okPercentage"].toInt()
        
    }
    
}
