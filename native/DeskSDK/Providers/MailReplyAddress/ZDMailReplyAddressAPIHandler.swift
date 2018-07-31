//
//  ZDMailReplayAddressProvider.swift
//  ZohoDeskSDK
//
//  Created by rajesh-2098 on 09/05/18.
//  Copyright © 2018 rajesh-2098. All rights reserved.
//

import Foundation
@objc public class ZDMailReplyAddressAPIHandler : NSObject{
    
    @objc public static func listAllMailReplyAddresses(_ orgId:String = String().getZDOrgId(),optionalParams:Parameters = Parameters(),onComplition:@escaping (([ZDMailReplyAddresses]?,Error?,Int)->())) -> Void {
                let request = ZDBaseRequest(path: String(format: URLPathConstants.MailReplyAddress.mailReplyAddress),parameters:optionalParams, headers: ["orgId":orgId])
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, data, error, statusCode) in
            guard let mailReplyAddressesJson = json else{onComplition(nil,error,statusCode);return}
            onComplition(ZDMailReplyAddresses.modelFromArry(json: mailReplyAddressesJson, orgId: orgId),error,statusCode)
        }
    }
}

@objc public class ZDMailReplyAddresses:NSObject{
    
    @objc public var address = ""
    @objc public var isVerified = false
    @objc public var displayName = ""
    @objc public var departmentId = ""
    @objc public var id = ""
    @objc public var isActive = false
    
    @objc public var orgId = ""
    
    @objc public class func modelFromArry(json:[String:AnyObject],orgId:String) -> [ZDMailReplyAddresses]? {
        if let mailAddressJson = json["data"] as? [[String:AnyObject]]{
            return mailAddressJson.map({ZDMailReplyAddresses(json: $0, orgId: orgId)})
        }
        return nil
    }
    
    @objc public init(json:[String:AnyObject],orgId:String) {
        self.orgId = orgId
        self.address = json["address"].toString()
        self.displayName = json["displayName"].toString()
        self.departmentId = json["departmentId"].toString()
        self.id = json["id"].toString()
        self.isActive = json["isActive"].toBool()
        self.isVerified = json["isVerified"].toBool()
    }
}
