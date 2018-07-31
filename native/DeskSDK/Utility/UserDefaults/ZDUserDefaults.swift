//
//  ZDUserDefaults.swift
//  Pods
//
//  Created by rajeshkumar.l on 17/10/17.
//
//

import Foundation
@objc public class ZDUtility :NSObject{
    @objc public static func setOrgId(orgId:String){
        orgId.saveZDOrgID()
    }
}

internal class UserDefaultConfiguration: NSObject {
    
    internal static func save(key:String,value:AnyObject){
        
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    internal static func get(key:String) -> AnyObject? {
        return UserDefaults.standard.value(forKey: key) as AnyObject
    }
    
}

internal struct ZDUserDefaultKeyConstants{
    
    static let defaultOrgID = "defaultOrgID"
}
