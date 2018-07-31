
//
//  ZDThreadAction.swift
//  Pods
//
//  Created by rajeshkumar.l on 25/10/17.
//
//

import Foundation

@objc public class ZDThreadAction: NSObject {
    
    @objc public var orgId  = ""
    @objc public var method:String?
    @objc public var rel:String?
    @objc public var href:String?

    @objc public  override init() {super.init()}
    
    @objc public  class func initWithArray(orgId:String,actions:[[String:AnyObject]]) -> [ZDThreadAction]{
        return actions.map{ZDThreadAction(orgId:orgId,Json: $0)}
    }
    
    @objc public  init(orgId:String,Json:[String:AnyObject]){
        
        self.orgId = orgId
        method = Json["method"].toString()
        rel    = Json["rel"].toString().capitalized
        href   = Json["href"].toString()

    }
    
   internal func submitAction(onComplition:@escaping (([String:AnyObject]?,Error?,Int)->())) -> Void {
    
        let details = ZDBaseRequest(path: "", method:Method(rawValue: self.method ?? "") ?? .GET, headers: ["orgId":self.orgId])
            details.baseURL = URL(string: self.href ?? "") ?? URL(string: "https://desk.zoho.com/api/v1/")!
        
        ZDRequestMaker.sharedInstance.makeRequest(for:details,
                                                  success: { (reponceData,statusCode) in
                                                    guard let json  = reponceData?.toJSON() as? [String:AnyObject] else{
                                                        onComplition(nil,nil,statusCode)
                                                        return
                                                    }
                                                    onComplition(json,nil,statusCode)
                                                    
        }) { (reponceData, error, statusCode) in
            onComplition(nil,error,statusCode)
        }
    }
}


