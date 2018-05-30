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
    
    public var orgId           = ""
    
    public var channel:String?
    public var isDraft    = false
    public var isForward  = false
    public var direction      = ""

    
    
    internal init?(lastThreadJsonReponce: [String:AnyObject]?,orgId:String) {
        
        guard let contactJson = lastThreadJsonReponce else { return nil}
        
        self.orgId = orgId
        
        self.channel    = contactJson["channel"] as? String
        self.isDraft    = contactJson["isDraft"].toBool()
        self.isForward  = contactJson["isForward"].toBool()
        self.direction  = contactJson["direction"].toString()
        
    }
    
}
