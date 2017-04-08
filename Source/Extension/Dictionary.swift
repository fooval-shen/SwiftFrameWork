//
//  Dictionary.swift
//  SwiftFrameWork
//
//  Created by shenfh on 17/4/8.
//  Copyright © 2017年 shenfh. All rights reserved.
//

import Foundation


public extension Dictionary {
    public func random() -> Value {
        let index: Int = Int(arc4random_uniform(UInt32(self.count)))
        return Array(self.values)[index]
    }
    
    public func has(key: Key) -> Bool {
        return index(forKey: key) != nil
    }
}
