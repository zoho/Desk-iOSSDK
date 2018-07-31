//
//  ZDViews.swift
//  ZohoDeskSDK
//
//  Created by Rajeshkumar Lingavel on 26/05/18.
//  Copyright © 2018 rajesh-2098. All rights reserved.
//

import Foundation

@objc public class ZDView: NSObject {
    
    @objc public var orgId  = ""
    @objc public var isCustomView = false
    @objc public var name = ""
    @objc public var i18NLabel = ""
    @objc public var id = ""
    
    @objc public  class func modelsFromArray(jsonResponce:[String:AnyObject]?,orgId:String) -> [ZDView]? {
        guard let viewArrayJson = jsonResponce?["data"] as? [[String:AnyObject]]else{ return nil}
        return viewArrayJson.map({ZDView(json: $0, orgId: orgId)})
    }
    init(json:[String:AnyObject],orgId:String) {
        super.init()
        
        self.orgId = orgId
        
        self.isCustomView = json["isCustomView"].toBool()
        self.name = json["name"].toString()
        self.i18NLabel = json["i18NLabel"].toString()
        self.id = json["id"].toString()
    
    }
}
