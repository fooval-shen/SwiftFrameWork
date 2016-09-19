//
//  CommonHeader.swift
//  News
//
//  Created by shenfh on 16/8/8.
//  Copyright © 2016年 shenfh. All rights reserved.
//

import Foundation

private let backgroundQueue = DispatchQueue(label: "com.runQueue.background", attributes: DispatchQueue.Attributes.concurrent)

/**
 在主线程执行
 
 */
public func runInMainThread(_ block:@escaping ()->()!){
    if( Thread.current.isMainThread){
        block()
    }else{
        DispatchQueue.main.async(execute: block as! @convention(block) () -> Void)
    }
}
/**
 后台线程执行
 
 */
public func runInBackgroundThread(_ block:@escaping ()->()!){
    backgroundQueue.async(execute: block as! @convention(block) () -> Void);
}

public func synchronized(_ lock: AnyObject, closure: () -> ()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}

public func delay(_ second:Double, closure:@escaping ()->()) {
    delay(second, queue: DispatchQueue.main, closure: closure)
}
public func delay(_ second:Double,queue:DispatchQueue,closure:@escaping ()->()){
    queue.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(second*Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC),
        execute: closure)
}

func resourseName(_ name:String) ->String {
    return "Frameworks/SwiftFrameWork.framework/" + name
}
func resoursePath(_ name:String) -> String {
    return "\(Bundle.main.bundlePath)/" + resourseName(name)
}
public func printlen<T>(_ message: T,
                     file: String = #file,
                     method: String = #function,
                     line: Int = #line) {
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")   
}

private let ServiceName = "com.Device.uid"
private let ServiceAccount = "DeviceUUID"

///获取设备唯一标识
public func deviceIdentifier()->String {
    if let uid =  SSKeychain.password(forService: ServiceName, account: ServiceAccount) {
        return uid
    }
    let newUUID = (UIDevice.current.identifierForVendor?.uuidString ??  NSUUID().uuidString).lowercased()
    SSKeychain.setPassword(newUUID, forService: ServiceName, account: ServiceAccount)
    return newUUID
}
public func uuidString()->String {
    return NSUUID().uuidString.lowercased()
}


public let ScreenSize   = UIScreen.main.bounds.size
public let ScreenWidth  = UIScreen.main.bounds.size.width
public let ScreenHeight = UIScreen.main.bounds.size.height
public let ScreenBounds = UIScreen.main.bounds
