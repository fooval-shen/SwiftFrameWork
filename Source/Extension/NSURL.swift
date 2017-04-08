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
