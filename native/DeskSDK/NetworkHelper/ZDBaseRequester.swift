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

public typealias NetworkCallBackWithDictionay = ((_ jsonDic:[String:AnyObject]?,_ reponceData:Data?,_ error:Error?, _ statusCode:Int) -> Void)

public typealias NetworkCallBackWithArray = ((_ jsonArray:[[String:AnyObject]]?,_ reponceData:Data?,_ error:Error?, _ statusCode:Int) -> Void)

public typealias ZDErrorCallBack = ((_ error:Error?, _ statusCode:Int) -> Void)


public class ZDBaseRequester{
    
   @discardableResult public static func getJsonDicReponce(baseRequest:ZDBaseRequest,onComplition:@escaping NetworkCallBackWithDictionay) -> URLRequest{
        
       return ZDRequestMaker.sharedInstance.makeRequest(for:baseRequest,
                                                  success: { (reponceData,statusCode) in
                                                    
                                                    guard let json  = reponceData?.toJSON() as? [String:AnyObject] else{
                                                        let customError = getCustomErrorFromData(error: nil, reponceData: reponceData, statusCode: statusCode)
                                                        onComplition(nil,reponceData,customError,statusCode)
                                                        return
                                                    };                                                    onComplition(json,reponceData,nil,statusCode)
                                                    
        }) { (reponceData, error, statusCode) in
            let customError = getCustomErrorFromData(error: error, reponceData: reponceData, statusCode: statusCode)
            onComplition(nil,reponceData,customError,statusCode)
        }

        
    }
    
   @discardableResult public static func getJsonArrayReponce(baseRequest:ZDBaseRequest,onComplition:@escaping NetworkCallBackWithArray) -> URLRequest{
      return  ZDRequestMaker.sharedInstance.makeRequest(for:baseRequest,
                                                  success: { (reponceData,statusCode) in
                                                    
                                                    guard let json  = reponceData?.toJSON() as? [[String:AnyObject]]
                                                    else{
                                                        let customError = getCustomErrorFromData(error: nil, reponceData: reponceData, statusCode: statusCode)
                                                        onComplition(nil,reponceData,customError,statusCode)
                                                        return
                                                    }
                                                    onComplition(json,reponceData,nil,statusCode)
                                                    
                                                    
        }) { (reponceData, error, statusCode) in
            let customError = getCustomErrorFromData(error: error, reponceData: reponceData, statusCode: statusCode)
            onComplition(nil,reponceData,customError,statusCode)
        }
    }
    
    internal static func getCustomErrorFromData(error:Error?,reponceData:Data?,statusCode:Int) -> Error{
        let errorFromData = NSError(domain:String(describing: String(data: reponceData ?? Data(), encoding: .utf8)), code: statusCode, userInfo: nil)
        return error ?? errorFromData
        
    }
    
}
