//
//  ZDConverstaion.swift
//  Pods
//
//  Created by rajeshkumar.l on 29/03/18.
//

import Foundation
@objc public enum ZDConverstaionType:Int{
    case thread,comment
}
@objc open class ZDConverstaion:NSObject{
    @objc public var orgId = ""
    @objc public var type = ZDConverstaionType.thread
    @objc public var hasAttach = false
    @objc public var author = ZDAuthor()
}
