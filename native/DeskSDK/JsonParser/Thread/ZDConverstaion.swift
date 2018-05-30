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
@objc public class ZDConverstaion:NSObject{
    public var orgId = ""
    public var type = ZDConverstaionType.thread
    public var hasAttach = false
    public var author = ZDAuthor()

}
