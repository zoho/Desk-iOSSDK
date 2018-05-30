//
//  DataExtention.swift
//  ZohoDeskSupportSDK
//
//  Created by rajeshkumar.l on 10/10/17.
//  Copyright © 2017 rajesh-2098. All rights reserved.
//

import Foundation

internal extension Data {

    mutating func append(string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
    
    func toString(){
        print(String(data: self, encoding: .utf8) ?? "Unknown Error occured")
    }
    
    func toJSON() -> AnyObject?{
        do {
            return try JSONSerialization.jsonObject(with: self, options: []) as AnyObject
        } catch _ {
            return nil
        }
    }
    
}


