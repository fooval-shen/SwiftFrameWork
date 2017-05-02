//
//  URIManager.swift
//  SwiftExample
//
//  Created by shenfh on 17/4/26.
//  Copyright © 2017年 shenfh. All rights reserved.
//

import Foundation

var routes = [String:URIModel]()
public typealias URIClosure = () -> Any?

class URIModel {
    var path:String
    var clourse :URIClosure
    
    init(path:String,clourse:@escaping URIClosure) {
        self.path = path
        self.clourse = clourse
    }
}





public final class URIManager {
    static let sharedInstance = URIManager()
    
    public func addRoutePath(path:String,clourse:@escaping URIClosure) {
        lock.lock()
        defer {
            lock.unlock()
        }
        let key = path.base64
        routes[key] = URIModel(path: path, clourse: clourse)
    }
    
    public func runPath(path:String) ->Any? {
        lock.lock()
        defer {
            lock.unlock()
        }
        guard  let model = routes[path.base64] else {
            return nil
        }
        return model.clourse()
    }
    
    
    fileprivate lazy var lock :NSRecursiveLock = {
        var lock = NSRecursiveLock()
        lock.name = "URILock"
        return lock
    }()
}
