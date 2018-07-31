
import Foundation

@objc public class ZDCustomizedSignatures:NSObject{
	@objc public var signature : String?
	@objc public var departmentId  = ""

    public class func modelsFromDictionaryArray(jsonArray:[[String:AnyObject]]?) -> [ZDCustomizedSignatures]{
        var models:[ZDCustomizedSignatures] = []
        guard let array = jsonArray else{return models}
        models = array.map({ZDCustomizedSignatures(json: $0)})
        return models
    }

    required public init(json: [String:AnyObject]) {
		signature = json["signature"].toString()
		departmentId = json["departmentId"].toString()
	}
}
