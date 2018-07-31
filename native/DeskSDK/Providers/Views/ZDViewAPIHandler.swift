//
//  ZDViewAPIHandler.swift
//  ZohoDeskSDK
//
//  Created by Rajeshkumar Lingavel on 26/05/18.
//  Copyright © 2018 rajesh-2098. All rights reserved.
//

import Foundation

@objcMembers public class ZDViewsAPIHandler: NSObject {
    
    public static func listAllViews(_ orgId:String,department:String, onCompletion:@escaping (([ZDView]?,Error?,Int)->())) -> Void{
        let request = ZDBaseRequest(path: URLPathConstants.Views.listTicketViews, parameters: ["department":department], headers: ["orgId":orgId])
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
            onCompletion(ZDView.modelsFromArray(jsonResponce: json, orgId: orgId),error,status)
        }
    }
    
}
