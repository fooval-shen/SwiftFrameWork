//
//  CommonHeader.swift
//  News
//
//  Created by shenfh on 16/8/8.
//  Copyright © 2016年 shenfh. All rights reserved.
//

import Foundation

private let backgroundQueue = dispatch_queue_create("com.runQueue.background", DISPATCH_QUEUE_CONCURRENT)

/**
 在主线程执行
 
 */
public func runInMainThread(block:dispatch_block_t!){
    if( NSThread.currentThread().isMainThread){
        block()
    }else{
        dispatch_async(dispatch_get_main_queue(),block)
    }
}
/**
 后台线程执行
 
 */
public func runInBackgroundThread(block:dispatch_block_t!){
    dispatch_async(backgroundQueue, block);
}

public func synchronized(lock: AnyObject, closure: () -> ()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}

public func delay(second:Double, closure:()->()) {
    delay(second, queue: dispatch_get_main_queue(), closure: closure)
}
public func delay(second:Double,queue:dispatch_queue_t,closure:dispatch_block_t){
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(second*Double(NSEC_PER_SEC))
        ),
        queue,
        closure)
}

func resourseName(name:String) ->String {
    return "Frameworks/SwiftFramework.framework/" + name
}
func resoursePath(name:String) -> String {
    return "\(NSBundle.mainBundle().bundlePath)/" + resourseName(name)
}
public func printlen<T>(message: T,
                     file: String = #file,
                     method: String = #function,
                     line: Int = #line) {
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")   
}

private let ServiceName = "com.Device.uid"
private let ServiceAccount = "DeviceUUID"

///获取设备唯一标识
public func deviceIdentifier()->String {
    if let uid =  SSKeychain.passwordForService(ServiceName, account: ServiceAccount) {
        return uid
    }
    let newUUID = (UIDevice.currentDevice().identifierForVendor?.UUIDString ??  NSUUID().UUIDString).lowercaseString
    SSKeychain.setPassword(newUUID, forService: ServiceName, account: ServiceAccount)
    return newUUID
}
public func uuidString()->String {
    return NSUUID().UUIDString.lowercaseString
}


public let ScreenSize   = UIScreen.mainScreen().bounds.size
public let ScreenWidth  = UIScreen.mainScreen().bounds.size.width
public let ScreenHeight = UIScreen.mainScreen().bounds.size.height
public let ScreenBounds = UIScreen.mainScreen().bounds
