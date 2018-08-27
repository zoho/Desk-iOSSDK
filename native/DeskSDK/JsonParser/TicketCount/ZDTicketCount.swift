//
//  ZDTicketCount.swift
//  ZohoDeskSDK
//
//  Created by Rajeshkumar Lingavel on 20/08/18.
//  Copyright © 2018 rajesh-2098. All rights reserved.
//

import Foundation
@objc open class ZDTicketsCount:NSObject{
    var count:Int = 0
    public init?(json:[String:AnyObject]?) {
        guard let jsonObject = json else{return nil}
        self.count = jsonObject["count"].toInt()
    }
}
