//
//  NSURL.swift
//  SwiftFrameWork
//
//  Created by shenfh on 16/12/26.
//  Copyright © 2016年 shenfh. All rights reserved.
//

import Foundation

extension NSURL {
    public  func queryParameters()->[String:String] {
        guard let queString = self.query else {
            return [String:String]();
        }
        return queString.queryParameters()
    }
}

public extension URL {
    
    /// 获取URL上面的参数
    public  func queryParameters()->[String:String] {
        guard let queString = self.query else {
            return [String:String]();
        }
        return queString.queryParameters()
    }
    
    /// 添加参数
    public func appendingQueryParameters(_ parameters: [String: String]) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        var items = urlComponents.queryItems ?? []
        items += parameters.map({ URLQueryItem(name: $0, value: $1) })
        urlComponents.queryItems = items
        return urlComponents.url!
    }
    
    /// 添加参数
    public mutating func appendQueryParameters(_ parameters: [String: String]) {
        self = appendingQueryParameters(parameters)
    }
}
