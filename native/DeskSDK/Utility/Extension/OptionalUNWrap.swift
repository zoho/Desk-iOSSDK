//
//  IntExtension.swift
//  Pods
//
//  Created by rajeshkumar.l on 17/10/17.
//
//

import Foundation
extension Optional where Wrapped == Int{
    
    func toString() -> String{
        if let value = self{
            return "\(value)"
        }
        
        return ""
    }
}

extension Optional where Wrapped == AnyObject{
    
    func toString() -> String{
        if let value = self{
            let StringValue =  "\(value)"
            return StringValue == "<null>" ? "" : StringValue
        }
        
        return ""
    }
    func toInt() -> Int{
        if let value = self as? Int{
            return value
        }
        return 0
        
    }
    
    func toBool() -> Bool{
        if let value = self as? Bool{
            return value
        }
        return false
        
    }
    
    func toDouble() -> Double{
        if let value = self as? Double{
            return value
        }
        return 0
    }
}
