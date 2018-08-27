//
//  ZDContactProvoider.swift
//  Pods
//
//  Created by rajeshkumar.l on 30/10/17.
//
//

import Foundation

@objc open class ZDContactAPIHandler: NSObject {

//https://desk.zoho.com/DeskAPIDocument#Contacts#Contacts_Getacontact
   @objc open static func getContact(_ orgID:String = String().getZDOrgId(),contactId:String,optionalParams:Parameters = Parameters(),onComplition:@escaping ((ZDContactDetail?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.Contacts.getAContact, contactId),parameters:optionalParams,headers:["orgId":orgID])

        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, statusCode) in
            guard let contactJson = json else{onComplition(nil,error,statusCode);return}
            onComplition(ZDContactDetail(contactDetailJson: contactJson, orgId: orgID), error, statusCode)
        }
    }
    
    
    //https://desk.zoho.com/DeskAPIDocument#Contacts#Contacts_Listallcontacts
   @objc open static func getAllContacts(_ orgID:String = String().getZDOrgId(),optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping (([ZDContact]?,Error?,Int)->())) -> Void{
        
        
        let details = ZDBaseRequest(path: URLPathConstants.Contacts.listAllContact,parameters : optionalParams,headers:["orgId":orgID])
        ZDBaseRequester.getJsonDicReponce(baseRequest: details) { (json, reponceData, error, statusCode) in
            onComplition(ZDContact.modelsFromArray(dic: json, orgId: orgID), error, statusCode)
        }
        
    }
    
//    https://desk.zoho.com/DeskAPIDocument#Contacts#Contacts_Createacontact
   @objc open static func createContact(_ orgID:String = String().getZDOrgId(),lastName:String,optionalParams:[String:AnyObject],onComplition:@escaping ((ZDContactDetail?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.Contacts.createContact), method: .POST, paramType: .json, parameters: optionalParams, headers: ["orgId":orgID])
        request.parameters["lastName"] = lastName
        
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, statusCode) in
                guard let contactJson = json else{onComplition(nil,error,statusCode);return}
                onComplition(ZDContactDetail(contactDetailJson: contactJson, orgId: orgID), error, statusCode)
        }
    }
    
//    https://desk.zoho.com/DeskAPIDocument#Contacts#Contacts_Updateacontact
   @objc open static func updateContact(_ orgID:String = String().getZDOrgId(),contactID:String,optionalParams:[String:AnyObject] = [String:AnyObject](),onComplition:@escaping ((ZDContactDetail?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.Contacts.updateContact,contactID), method: .POST, paramType: .json, parameters: optionalParams, headers: ["orgId":orgID])
        
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, statusCode) in
            guard let contactJson = json else{onComplition(nil,error,statusCode);return}
            onComplition(ZDContactDetail(contactDetailJson: contactJson, orgId: orgID), error, statusCode)
        }
    }
    
    
   @objc open static func getTicketsByContact(_ orgId:String = String().getZDOrgId(),contactId:String,optionalParams:Parameters = Parameters(),onComplition:@escaping (([ZDTicket]?,Error?,Int)->())) -> Void{
        
        let request = ZDBaseRequest(path: String(format: URLPathConstants.Contacts.getTicketsByContact,contactId), method: .POST, paramType: .json, parameters: optionalParams, headers: ["orgId":orgId])
        ZDBaseRequester.getJsonDicReponce(baseRequest: request) { (json, reponceData, error, statusCode) in
            guard let ticketListJson = json else{onComplition(nil,error,statusCode);return}
            onComplition(ZDTicket.modelsFromDictionary(dictionary: ticketListJson, orgId: orgId),error,statusCode)
        }
    }
    
    
}
