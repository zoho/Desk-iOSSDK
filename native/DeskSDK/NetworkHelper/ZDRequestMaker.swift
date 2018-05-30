//
//  ZDMainRequest.swift
//  ZohoDeskSupportSDK
//
//  Created by rajeshkumar.l on 10/10/17.
//  Copyright © 2017 rajesh-2098. All rights reserved.
//

import Foundation

typealias ZDRequestMakerSuccess = ((Data?, _ responseCode: Int) -> Void)?

typealias ZDRequestMakerFailure = ((_ data: Data?, _ error: Error?, _ responseCode: Int) -> Void)?

internal class ZDRequestMaker {

    static let sharedInstance = ZDRequestMaker()

    
    private var task: URLSessionDataTask?
    private var successCodes: CountableRange<Int> = 200..<299
    private var failureCodes: CountableRange<Int> = 400..<499
    
    @discardableResult func makeRequest(for request:ZDBaseRequest,
                          success: ZDRequestMakerSuccess = nil,
                          failure: ZDRequestMakerFailure = nil) -> URLRequest  {
    
        var urlRequest = ZDURLConstructor().generateRequest(request: request)
        
        
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpMethod = request.method.rawValue
        
        getAuthToken { (authorizationToken, error) in
            if error == nil{

                if request.isAuthenticationRequired {
                    if ZohoDeskSDK.delegete == nil{
                        failure?(nil, NSError(domain:"ZohoDeskSDK.delegete Not assigened", code: 0, userInfo: nil), 0)
                        return
                    }
                    urlRequest.allHTTPHeaderFields = ["Authorization":authorizationToken]
                }
            
                if urlRequest.allHTTPHeaderFields?["orgId"] == nil && !request.genralAPI {
                    failure?(nil, NSError(domain:"invalid OrgID or Empty Org ID", code: 0, userInfo: nil), 0)
                    "invalid OrgID or Empty Org ID".makeLog()
                    return
                }
                
                if  let streamData = request.streamData {
                    urlRequest.httpBody = streamData
                }
                
                "🚀 Body =>\(String(describing: urlRequest.httpBody?.toString()))".makeLog()
                "🚀 URL =>\(String(describing: urlRequest.url))".makeLog()
                "🚀 Header=>\(String(describing: urlRequest.allHTTPHeaderFields))".makeLog()
                
                
                
                self.hitServer(urlRequest: urlRequest, success: success, failure: failure)
                
            }
            else{
                failure?(nil, error,401)
            } 
        }
    
        
        return urlRequest
    }
    
    
    internal func hitServer(urlRequest:URLRequest,
                            success: ZDRequestMakerSuccess = nil,
                            failure: ZDRequestMakerFailure = nil) -> Void {
        
        let session = URLSession.shared
        task = session.dataTask(with: urlRequest as URLRequest, completionHandler: { (data, response, error) in
            let url = urlRequest.url?.absoluteString ?? ""
            guard let httpResponse = response as? HTTPURLResponse else {
                failure?(data, error, 0)
                return
            }
            
            if let error = error {
                failure?(data, error, httpResponse.statusCode)
                return
            }
            
            if self.successCodes.contains(httpResponse.statusCode) {
                "✅ \(url) Request finished with success.".makeLog()
                success?(data,httpResponse.statusCode)
            } else if self.failureCodes.contains(httpResponse.statusCode) {
               "⚠️ \(url)  Request finished with failure. Error:=> \(String(describing: error)) Status Code : =>\(httpResponse.statusCode)".makeLog()
                "⚠️ \(url)  Responce Data \(String(describing: String(data: data ?? Data(), encoding: .utf8)))".makeLog()

                failure?(data, error, httpResponse.statusCode)
            } else {
                "⚠️ \(url)  Request finished with failure. Error:=> \(String(describing: error)) Status Code : =>\(httpResponse.statusCode)".makeLog()
                
                let info = [
                    NSLocalizedDescriptionKey: " \(url) Request failed with code \(httpResponse.statusCode)",
                    NSLocalizedFailureReasonErrorKey: " \(url) Wrong handling logic, wrong endpoing mapping or backend bug."
                ]
                
                let error = NSError(domain: "NetworkService", code: 0, userInfo: info)
                failure?(data, error, httpResponse.statusCode)
            }
        })
        task?.resume()
    }
    
    
    internal func getAuthToken(_ onCompletion:@escaping ((String,Error?)->())) -> Void{
        guard let delegate = ZohoDeskSDK.delegete else {
                onCompletion("",NSError(domain:"Authorization delegate not set please refer Documentation", code: 0, userInfo: nil))
            return
        }
       delegate.getToken(completion: { (token) in
            onCompletion(token, nil)
        })
        
    }
}
@objc public protocol ZDAuthentication: class {
    func getToken(completion:@escaping((String)->()))
}




