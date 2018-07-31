
import Foundation

@objc public class ZDLayoutSections :NSObject {
    @objc public var name            = ""
    @objc public var isCustomSection = false
    @objc public var id              = ""
    @objc public var fields:[[String:AnyObject]]?

    @objc public class func modelsFromJsonArray(json:[[String:AnyObject]]?) -> [ZDLayoutSections]
    {
        var models:[ZDLayoutSections] = []
        guard let sections = json else {
            return models
        }
        models = sections.map({ZDLayoutSections(json: $0)})
        return models
    }

    required public init(json: [String:AnyObject]) {
        
        name            = json["name"].toString()
        isCustomSection = json["isCustomSection"].toBool()
        id              = json["id"].toString()
        fields          = json["fields"] as? [[String : AnyObject]]
    }
}
