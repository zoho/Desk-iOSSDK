//
//  ZDLastThread.swift
//  ZohoDeskSDK
//
//  Created by Rajeshkumar Lingavel on 24/05/18.
//  Copyright © 2018 rajesh-2098. All rights reserved.
//

import Foundation
import Foundation

@objc public class ZDLastThread : NSObject{
    
    @objc public var orgId           = ""
    
    @objc public var channel:String?
    @objc public var isDraft    = false
    @objc public var isForward  = false
    @objc public var direction      = ""

    
    
    @objc public init?(lastThreadJsonReponce: [String:AnyObject]?,orgId:String) {
        
        guard let contactJson = lastThreadJsonReponce else { return nil}
        
        self.orgId = orgId
        
        self.channel    = contactJson["channel"] as? String
        self.isDraft    = contactJson["isDraft"].toBool()
        self.isForward  = contactJson["isForward"].toBool()
        self.direction  = contactJson["direction"].toString()
        
    }
    
}
