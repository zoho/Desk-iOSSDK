//
//  StringExtention.swift
//  ZohoDeskSupportSDK
//
//  Created by rajeshkumar.l on 28/09/17.
//  Copyright © 2017 rajesh-2098. All rights reserved.
//

import Foundation
extension String {
    func ZDhtmlContentToString() -> String {
        return self.replacingOccurrences(of:"<[^>]+>", with: "" , options: .regularExpression, range: nil).trimmingCharacters(in: .whitespaces)
    }
    

    
    func ZDencode() -> String {
        
        let customAllowedSet =  CharacterSet(charactersIn: "=\"#%/<>?@\\^`{|}").inverted

        if let encodedString = self.addingPercentEncoding(withAllowedCharacters: customAllowedSet) {
            return encodedString
        }
        return self
    }
    
   public func getZDOrgId() -> String {
        guard let value = UserDefaultConfiguration.get(key: ZDUserDefaultKeyConstants.defaultOrgID) as? String else{return ""}
        return value
    }
    
    public func saveZDOrgID() -> Void{
        UserDefaultConfiguration.save(key: ZDUserDefaultKeyConstants.defaultOrgID, value: self as AnyObject) 
    }
    
    internal func makeLog(){
        print(self)
    }
}

internal extension Optional where Wrapped == String{
    
    func unWrap() -> String{
        guard let value = self else { return "" }
        return value
    }
}

internal extension Optional where Wrapped == Bool{
    
    func unWrap() -> Bool{
        guard let value = self else { return false }
        return value
    }
}

internal extension Optional where Wrapped == AnyObject {
    
    func unWrap() -> String {
        
        guard let value = self else { return "" }
        return "\(value)"
        
    }
}

protocol ZDAnyObject:AnyObject {}

internal extension ZDAnyObject {
    func toString() -> String{
        return "\(self)"
    }
}
