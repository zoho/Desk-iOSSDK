//
//  initialize.swift
//  ZohoDeskSupportSDK
//
//  Created by rajeshkumar.l on 11/10/17.
//  Copyright © 2017 rajesh-2098. All rights reserved.
//

import Foundation
public typealias tokenHandler = (String?,Error?)
@objc public enum ZDDomain : Int{
    case us,eu,cn
}

@objc public class ZohoDeskSDK: NSObject {

    public static var delegete:ZDAuthentication!
    
    public static var authtoken = ""
    
    internal static var configuration:SDKConfiguration?

    @discardableResult public init(configuration:SDKConfiguration){
        super.init()
        ZohoDeskSDK.configuration = configuration
    }
    
    public static func resetAllNetworkRequest(){
        URLSession.shared.invalidateAndCancel()
    }
}


/// Desk SDK will work based on this configuration.
@objc public class SDKConfiguration:NSObject{
    var domain = ZDDomain.us
    
    /// Desk SDK will work based on this configuration.
    ///
    /// - Parameter baseURL: baseURL used to API request possible values are "ZDDomain.us","ZDDomain.eu"
    public init(domain:ZDDomain) {
        super.init()
        self.domain = domain
    }
}
