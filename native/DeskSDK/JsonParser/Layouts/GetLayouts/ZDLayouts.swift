
import Foundation

@objc open class ZDLayouts :NSObject {
    
    @objc public var orgId           = ""

    @objc public var modifiedTime    = ""
    @objc public var createdBy       = ""
    @objc public var departmentId    = ""
    @objc public var createdTime     = ""
    @objc public var modifiedBy      = ""
    @objc public var id              = ""
    @objc public var isDefaultLayout = false
    @objc public var layoutName      = ""

    @objc open class func modelsFromArray(responce:[String:AnyObject]?,orgId:String) -> [ZDLayouts]?
    {
        var layouts:[ZDLayouts] = []
        guard let layoutJsonArray = responce?["data"] as? [[String:AnyObject]] else { return layouts }
        
       layouts = layoutJsonArray.map({ZDLayouts(layouts: $0, orgId: orgId)})
        return layouts
    }


    @objc public init(layouts: [String:AnyObject],orgId:String) {

        self.orgId      = orgId

        modifiedTime    = layouts["modifiedTime"].toString()
        createdBy       = layouts["createdBy"].toString()
        departmentId    = layouts["departmentId"].toString()
        createdTime     = layouts["createdTime"].toString()
        modifiedBy      = layouts["modifiedBy"].toString()
        id              = layouts["id"].toString()
        isDefaultLayout = layouts["isDefaultLayout"].toBool()
        layoutName      = layouts["layoutName"].toString()
	}



}
