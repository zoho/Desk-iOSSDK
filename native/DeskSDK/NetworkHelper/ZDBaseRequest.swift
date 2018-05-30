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

internal enum Method: String {
    case GET, POST, PUT, DELETE , PATCH 
}

public enum ParamType: String {
    case json, path, data
}

internal class ZDBaseRequest {

    
    var baseURL:URL              = URL(string: "https://desk.zoho.com/api/v1/")!
    var path                     = ""
    var method: Method           = .GET
    var paramType: ParamType     = .path
    var parameters: Parameters   = [String: String]()
    var headers: Headers         = ["Content-Type": "application/json"]
    var isAuthenticationRequired = true
    var genralAPI                = false
    var streamData:Data?
    
    private let defaultBaseURL = URL(string: "https://desk.zoho.com/api/v1/")!

    init(path:String,method:Method = .GET,paramType:ParamType = .path,parameters:Parameters = [String: String](),headers:Headers = ["Content-Type": "application/json"]) {
        
        self.baseURL = URL(string: "\(getBaseURL())/api/v1/") ?? defaultBaseURL
        self.path = path
        self.method = method
        self.paramType = paramType
        self.parameters = parameters
        self.headers = headers
        
    }
    
    func getBaseURL() -> String{
        switch ZohoDeskSDK.configuration?.domain ?? .us{
        case .us:
            return "https://desk.zoho.com"
        case .eu:
            return "https://desk.zoho.eu"
        }
    }
}

extension ZDBaseRequest {
    func defaultJSONHeaders() -> Headers {
        return ["Content-Type": "application/json"]
    }
}
