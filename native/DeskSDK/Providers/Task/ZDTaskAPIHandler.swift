//
//  ZDTaskProvoider.swift
//  Pods
//
//  Created by rajeshkumar.l on 30/10/17.
//
//

import Foundation

@objc public class ZDTaskAPIHandler: NSObject {
    
    @objc public static func getTask(_ orgId:String = String().getOrgId(),taskId:String,optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping ((ZDTask?,[String:AnyObject]?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: URLPathConstants.listTaskByTicket,parameters:optionalParams,headers:["orgId":orgId])
        
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
            onComplition(ZDTask(taskJsonReponce: json, orgId: orgId),json,error, status)
        }
    }
    
    @objc public static func listAllTasks(_ orgId:String = String().getOrgId(),from:Int = 0,limit:Int = 50,optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping (([ZDTask]?,Error?,Int)->())) -> Void{
        
        
        let request = ZDBaseRequest(path: URLPathConstants.listAllTask,parameters:optionalParams,headers:["orgId":orgId])
        request.parameters["from"] = from
        request.parameters["limit"] = limit
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
            onComplition(ZDTask.modelsFromDictionaryArray(dic: json, orgId: orgId), error, status)
        }
        
    }
    
    @objc public static func createTask(_ orgId:String = String().getOrgId(),departmentId:String,subject:String,optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping ((ZDTask?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: URLPathConstants.createTask, method: .POST, paramType: .json, parameters: optionalParams, headers: ["orgId":orgId])
        request.parameters["departmentId"] = departmentId
        request.parameters["subject"] = subject
        createOrUpdateTask(request: request, onComplition: onComplition)
        
        
    }
    
    @objc public static func updateTask(_ orgId:String = String().getOrgId(),taskId:String,optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping ((ZDTask?,Error?,Int)->())) -> Void {
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.updateTask,taskId), method: .PATCH, paramType: .json, parameters: optionalParams, headers: ["orgId":orgId])
        createOrUpdateTask(request: request, onComplition: onComplition)
    }
    
    @objc public static func getTasksByTicket(_ orgId:String = String().getOrgId(),ticketId:String,from:Int = 0,limit:Int = 50,optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping (([ZDTask]?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: URLPathConstants.listTaskByTicket,parameters:optionalParams,headers:["orgId":orgId])
        request.parameters["from"] = from
        request.parameters["limit"] = limit
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
            onComplition(ZDTask.modelsFromDictionaryArray(dic: json, orgId: orgId), error, status)
        }
        
    }
    
    ///Internal API
    internal static func createOrUpdateTask(request:ZDBaseRequest,onComplition:@escaping ((ZDTask?,Error?,Int)->())) -> Void {
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
            onComplition(ZDTask(taskJsonReponce: json, orgId: request.headers["orgId"]!), error, status)
        }
    }
    
    
    
    
}
