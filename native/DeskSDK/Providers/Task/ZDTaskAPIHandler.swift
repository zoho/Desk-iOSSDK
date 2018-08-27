//
//  ZDTaskProvoider.swift
//  Pods
//
//  Created by rajeshkumar.l on 30/10/17.
//
//

import Foundation

@objc open class ZDTaskAPIHandler: NSObject {
    
    @objc open static func getTask(_ orgId:String = String().getZDOrgId(),taskId:String,optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping ((ZDTask?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: URLPathConstants.Tasks.listTaskByTicket,parameters:optionalParams,headers:["orgId":orgId])
        
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
            onComplition(ZDTask(taskJsonReponce: json, orgId: orgId), error, status)
        }
    }
    
    @objc open static func listAllTasks(_ orgId:String = String().getZDOrgId(),optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping (([ZDTask]?,Error?,Int)->())) -> Void{

        let request = ZDBaseRequest(path: URLPathConstants.Tasks.listAllTask,parameters:optionalParams,headers:["orgId":orgId])
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, status) in
            onComplition(ZDTask.modelsFromDictionaryArray(dic: json, orgId: orgId), error, status)
        }
        
    }
    
    @objc open static func createTask(_ orgId:String = String().getZDOrgId(),departmentId:String,subject:String,optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping ((ZDTask?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: URLPathConstants.Tasks.createTask, method: .POST, paramType: .json, parameters: optionalParams, headers: ["orgId":orgId])
        request.parameters["departmentId"] = departmentId
        request.parameters["subject"] = subject
        createOrUpdateTask(request: request, onComplition: onComplition)
        
        
    }
    
    @objc open static func updateTask(_ orgId:String = String().getZDOrgId(),taskId:String,optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping ((ZDTask?,Error?,Int)->())) -> Void {
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.Tasks.updateTask,taskId), method: .PATCH, paramType: .json, parameters: optionalParams, headers: ["orgId":orgId])
        createOrUpdateTask(request: request, onComplition: onComplition)
    }
    
    @objc open static func getTasksByTicket(_ orgId:String = String().getZDOrgId(),ticketId:String,optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping (([ZDTask]?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: URLPathConstants.Tasks.listTaskByTicket,parameters:optionalParams,headers:["orgId":orgId])
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
