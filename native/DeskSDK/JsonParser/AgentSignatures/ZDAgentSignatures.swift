

import Foundation

@objc public class ZDAgentSignatures:NSObject {
	@objc public var customizedSignatures =  [ZDCustomizedSignatures]()
	@objc public var agentId  = ""
	@objc public var defaultSignature : String?
	@objc public var isActive  = false
    @objc public var orgId  = ""

    public init?(json: [String:AnyObject]?,orgId:String) {
        guard let jsonObject = json else {return}
        self.orgId = orgId
        customizedSignatures =  ZDCustomizedSignatures.modelsFromDictionaryArray(jsonArray: jsonObject["customizedSignatures"] as? [[String:AnyObject]])
		agentId = jsonObject["agentId"].toString()
		defaultSignature = jsonObject["defaultSignature"].toString()
		isActive = jsonObject["isActive"].toBool()
	}
}
