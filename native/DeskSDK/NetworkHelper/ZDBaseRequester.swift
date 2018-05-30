//
//  ZDBaseRequester.swift
//  Pods
//
//  Created by rajeshkumar.l on 02/11/17.
//
//

import Foundation


public typealias onComplition = ((AnyObject) -> Void)?
public typealias onError = ((_ error: NSError?, _ responseCode: Int) -> Void)?

internal typealias NetworkCallBackWithDictionay = ((_ jsonDic:[String:AnyObject]?,_ reponceData:Data?,_ error:Error?, _ statusCode:Int) -> Void)

internal typealias NetworkCallBackWithArray = ((_ jsonArray:[[String:AnyObject]]?,_ reponceData:Data?,_ error:Error?, _ statusCode:Int) -> Void)

public typealias ZDErrorCallBack = ((_ error:Error?, _ statusCode:Int) -> Void)


internal class ZDBaseRequester{
    
   @discardableResult internal static func getJsonDicReponce(baseRequest:ZDBaseRequest,onComplition:@escaping NetworkCallBackWithDictionay) -> URLRequest{
        
       return ZDRequestMaker.sharedInstance.makeRequest(for:baseRequest,
                                                  success: { (reponceData,statusCode) in
                                                    
                                                    guard let json  = reponceData?.toJSON() as? [String:AnyObject] else{                                                        onComplition(nil,reponceData,nil,statusCode)
                                                        return
                                                    };                                                    onComplition(json,reponceData,nil,statusCode)
                                                    
        }) { (reponceData, error, statusCode) in
            var customError = error
            if customError == nil{
                customError = NSError(domain:String(describing: String(data: reponceData ?? Data(), encoding: .utf8)), code: statusCode, userInfo: nil)
            }
            onComplition(nil,reponceData,customError,statusCode)
        }

        
    }
    
   @discardableResult internal static func getJsonArrayReponce(baseRequest:ZDBaseRequest,onComplition:@escaping NetworkCallBackWithArray) -> URLRequest{
      return  ZDRequestMaker.sharedInstance.makeRequest(for:baseRequest,
                                                  success: { (reponceData,statusCode) in
                                                    
                                                    guard let json  = reponceData?.toJSON() as? [[String:AnyObject]]
                                                    else{
                                                        onComplition(nil,reponceData,nil,statusCode)
                                                        return
                                                    }
                                                    onComplition(json,reponceData,nil,statusCode)
                                                    
                                                    
        }) { (reponceData, error, statusCode) in
            var customError = error
            if customError == nil{
                customError = NSError(domain:String(describing: String(data: reponceData ?? Data(), encoding: .utf8)), code: statusCode, userInfo: nil)
            }
            onComplition(nil,reponceData,customError,statusCode)
        }
    }
    
}
