//
//  ZDBaseRequest.swift
//  ZohoDeskSupportSDK
//
//  Created by rajeshkumar.l on 10/10/17.
//  Copyright © 2017 rajesh-2098. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

public typealias Headers = [String: String]

public enum Method: String {
    case GET, POST, PUT, DELETE , PATCH 
}

public enum ParamType: String {
    case json, path, data
}

public class ZDBaseRequest {

    
    public var baseURL:URL              = URL(string: "https://desk.zoho.com/api/v1/")!
    public var path                     = ""
    public var method: Method           = .GET
    public var paramType: ParamType     = .path
    public var parameters: Parameters   = [String: String]()
    public var headers: Headers         = ["Content-Type": "application/json"]
    public var isAuthenticationRequired = true
    public var genralAPI         = false
    public var streamData:Data?
    
    private let defaultBaseURL = URL(string: "https://desk.zoho.com/api/v1/")!

    public init(path:String,method:Method = .GET,paramType:ParamType = .path,parameters:Parameters = [String: String](),headers:Headers = ["Content-Type": "application/json"]) {
        
        self.baseURL = URL(string: "\(getBaseURL())/api/v1/") ?? defaultBaseURL
        self.path = path
        self.method = method
        self.paramType = paramType
        self.parameters = parameters
        self.headers = headers
        
    }
    
    public func getBaseURL() -> String{
        switch ZohoDeskSDK.configuration?.domain ?? .us{
        case .us:
            return "https://desk.zoho.com"
        case .eu:
            return "https://desk.zoho.eu"
        case .cn:
            return "https://desk.zoho.com.cn"
        }
    }
}

extension ZDBaseRequest {
    func defaultJSONHeaders() -> Headers {
        return ["Content-Type": "application/json"]
    }
}
