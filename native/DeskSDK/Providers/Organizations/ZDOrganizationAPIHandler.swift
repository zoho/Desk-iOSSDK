//
//  ZDOrganizationProvider.swift
//  DeskSDK
//
//  Created by rajesh-2098 on 07/05/18.
//  Copyright © 2018 rajesh-2098. All rights reserved.
//

import Foundation
///Organizations

///In Zoho Desk, each business is categorized as an organization. If you have multiple businesses, set each business up as an individual organization by creating a new signup and generating a unique organization ID. All APIs except the ones directly related to organizations must include the organization ID in the header in this format: orgId:{organization_id}
@objc public class ZDOrganizationAPIHandler : NSObject{
    
    /// This API lists all organizations to which the current user belongs
    ///
    /// - Parameter onCompletion: Will retrun array of Organization Swift modelObject.
    @objc public static func getAllOrganizations(_ onCompletion:@escaping (([ZDOrganization]?,Error?,Int)->())) -> Void{
   
        let request = ZDBaseRequest(path: URLPathConstants.allOrganizations)
        request.genralAPI = true
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
            guard let orgData = json else{onCompletion(nil,error,status);return}
            onCompletion(ZDOrganization.modelsFromDictionary(dictionary: orgData),error,status)
        }
        
    }
    
    
    /// This API fetches the details of an organization from your helpdesk.
    ///
    /// - Parameters:
    ///   - orgId: Unique ID of the Organization
    ///   - onCompletion: Organization Swift modelObject
    @objc public static func getOrganization(_ orgId:String, onCompletion:@escaping((ZDOrganization?,Error?,Int)->())) -> Void{

        let details = ZDBaseRequest(path: URLPathConstants.allOrganizations,headers:["orgId":orgId])
        
        ZDBaseRequester.getJsonDicReponce(baseRequest: details) { (json, reponceData, error, status) in
            guard let orgData = json else{onCompletion(nil,error,status);return}
            onCompletion(ZDOrganization.modelsFromDictionary(dictionary: orgData).first,error,status)
        }
    }
}
