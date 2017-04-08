//
//  String.swift
//  SwiftFrameWork
//
//  Created by shenfh on 16/12/26.
//  Copyright © 2016年 shenfh. All rights reserved.
//

import Foundation


extension String {
    public  func queryParameters()->[String:String] {        
        var parameters = [String:String]()
        self.components(separatedBy: "&").forEach {
            let keyAndValue = $0.components(separatedBy: "=")
            if keyAndValue.count == 2 {
                let key = keyAndValue[0]
                let value = keyAndValue[1].replacingOccurrences(of: "+", with: " ").removingPercentEncoding
                    ?? keyAndValue[1]
                parameters[key] = value
            }
        }
        return parameters
    }
}
