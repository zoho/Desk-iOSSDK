//
//  ZDAttachementProvoider.swift
//  Pods
//
//  Created by rajeshkumar.l on 30/10/17.
//
//

import Foundation

@objc public class ZDAttachementProvoider: NSObject {}

internal extension ZDAttachementProvoider{
    internal static func listAllAttachments(_ orgID:String = String().getZDOrgId(),urlPath:String = "",parentId:String = "",subParentId:String = "",parentType:ZDAttachmentParent, optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping (([ZDAttachment]?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: urlPath,parameters:optionalParams,headers:["orgId":orgID])
        
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, responceData, error, statusCode) in
            guard let attchmentJson = json else{onComplition(nil,nil,statusCode);return}
            onComplition(ZDAttachment.modelsFrom(json: attchmentJson, orgId: orgID, parentID: parentId, subParentID: subParentId, parentType: parentType), nil, statusCode)
        }
    }

    internal static func createAttachement(_ orgID:String = String().getZDOrgId(),path:String,data:Data,fileName:String,isPublic:Bool,parentId:String = "",subParentId:String = "",parentType:ZDAttachmentParent,addPublicData:Bool,onComplition:@escaping ((ZDAttachment?,Error?,Int)->())) -> URLRequest {
        
        var params:Parameters = ["file":data,"filename":fileName]
        if addPublicData{
            params["isPublic"] = isPublic
        }
        let request = ZDBaseRequest(path: path, method: .POST, paramType: .data, parameters: params, headers: ["orgId":orgID])
        return  ZDBaseRequester.getJsonDicReponce(baseRequest: request, onComplition: { (json, responceData, error, statusCode) in
            
            guard let attchmentJson = json else{onComplition(nil,nil,statusCode);return}
            let attachObject = ZDAttachment(attachmentJson: attchmentJson, orgId: orgID, parentID:parentId, subParentID: subParentId, parentType: parentType)
            onComplition(attachObject,nil,statusCode)
        })
    }
    
    internal static func updateAttachement(_ orgID:String = String().getZDOrgId(),path:String,updateDetails:Parameters,parentId:String = "",subParentId:String = "",parentType:ZDAttachmentParent,onComplition:@escaping ((ZDAttachment?,Error?,Int)->())) -> Void{
        
//        let request = ZDBaseRequest(path: path, method: .PATCH, paramType: .data, parameters: updateDetails, headers: ["orgId":orgID])
        
        let request = ZDBaseRequest(path: path, method: .PATCH, paramType: .json, parameters: updateDetails, headers: ["orgId":orgID])
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, data, error, statusCode) in
            guard let attchmentJson = json else{onComplition(nil,nil,statusCode);return}
            let attachObject = ZDAttachment(attachmentJson: attchmentJson, orgId: orgID, parentID:parentId, subParentID: subParentId, parentType: parentType)
            onComplition(attachObject,nil,statusCode)
        }
    }

    internal static func deleteAttachment(_ orgID:String = String().getZDOrgId(),path:String,onComplition:@escaping ((Error?,Int)->())) -> Void{        
        let request = ZDBaseRequest(path: path, method: .DELETE, headers: ["orgId":orgID])
        ZDRequestMaker.sharedInstance.makeRequest(for:request,
                                                  success: { (reponceData,statusCode) in
                                                    onComplition(nil, statusCode)
                                                    
        }) { (reponceData, error, statusCode) in
            onComplition(error, statusCode)
        }
    }


}
