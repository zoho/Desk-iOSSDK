//
//  ZDURLConstructor.swift
//  ZohoDeskSupportSDK
//
//  Created by rajeshkumar.l on 10/10/17.
//  Copyright © 2017 rajesh-2098. All rights reserved.
//

import Foundation

internal class ZDURLConstructor: NSObject {

    func generateRequest(request:ZDBaseRequest) -> URLRequest {
        
        switch request.paramType {
        case .path:
            var components = request.baseURL.absoluteString
            components.append(request.path)
            components.append(convert(params: request.parameters))
            components = components.trimmingCharacters(in: .whitespaces)
            let newUrl = URL(string: components)!
            
            return URLRequest(url: newUrl)
        case .data:
            return createRequest(for: request, params: request.parameters)
        case .json:
            
            var components = request.baseURL.absoluteString
            components.append(request.path)
            let newUrl = URL(string: components)!
        
           var mutableRequest = URLRequest(url: newUrl)
            mutableRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

            do{
                mutableRequest.httpBody = try JSONSerialization.data(withJSONObject: request.parameters, options: [])
            }
            catch{
                return mutableRequest
            }

            return mutableRequest
            
        }
        
    }
    
    private func convert(params: Parameters?) -> String {
        var query = ""
        guard let params = params else {
            return query
        }
        
        if  params.keys.count <= 0 {return query}
        
        params.forEach { key, value in
            let valueString = "\(value)"
            query = query + "\(key.ZDencode())=\(valueString.ZDencode())&"
        }
        
        return "?" + query
    }
    
    
    private func createRequest(for url: ZDBaseRequest, params: Parameters?) -> URLRequest {
        
        let boundary = generateBoundaryString()
        
        var components = url.baseURL.absoluteString
        components.append(url.path)
        components = components.trimmingCharacters(in: .whitespaces)
        
        let newUrl = URL(string: components)!
        var request = URLRequest(url: newUrl)
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        request.httpBody = getBodyData(url.parameters as [String : AnyObject])
        return request
    }

    private func generateBoundaryString() -> String {
        return "----WebKitFormBoundary7MA4YWxkTrZu0gW"
    }

    func getBodyData(_ pramas:[String:AnyObject]) -> Data{
        
        let fileName = pramas["filename"] as? String ?? "img.png"
        let data = pramas["file"] as! Data
        
        let boundary = "----WebKitFormBoundary7MA4YWxkTrZu0gW"
        
        let boundaryStart = "--\(boundary)\r\n"
        let boundaryEnd = "--\(boundary)--\r\n"
        let contentDispositionString = "Content-Disposition: form-data; name=file; filename=\"\(fileName)\"\r\n"
        
        let contentTypeString = "Content-Type: \("mutipart/form-data; boundary=\(boundary)")\r\n\r\n"
        
        let requestBodyData  = NSMutableData()
        requestBodyData.append(boundaryStart.data(using: String.Encoding.utf8)!)
        requestBodyData.append(contentDispositionString.data(using: String.Encoding.utf8)!)
        requestBodyData.append(contentTypeString.data(using: String.Encoding.utf8)!)
        requestBodyData.append(data)
        requestBodyData.append("\r\n".data(using: String.Encoding.utf8)!)
        requestBodyData.append(boundaryEnd.data(using: String.Encoding.utf8)!)
        
        return requestBodyData as Data
        
        
    }
    
}
