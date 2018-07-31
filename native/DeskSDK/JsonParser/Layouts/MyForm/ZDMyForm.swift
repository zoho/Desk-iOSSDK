
import Foundation

@objc public class ZDMyForm :ZDLayouts{
    
    @objc public var layoutId = ""
    
	@objc public var sections = [ZDLayoutSections]()

    @objc public init?(jsonObject: [String:AnyObject]?,orgId:String,layoutId:String) {
        
        guard let json = jsonObject else {return nil}        
        super.init(layouts: json, orgId: orgId)
        
        self.orgId = orgId
        self.layoutId = layoutId
        
        sections = ZDLayoutSections.modelsFromJsonArray(json: json["sections"] as? [[String:AnyObject]])
	}
}
