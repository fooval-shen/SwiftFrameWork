//
//  SafeArray.swift
//  SwiftFrameWork
//
//  Created by shenfh on 16/1/29.
//  Copyright © 2016年 com.meiqu.com. All rights reserved.
//

import Foundation


public func ==<T: Equatable>(lhs: [T]?, rhs: [T]?) -> Bool {
    switch (lhs, rhs) {
    case (.some(let lhs), .some(let rhs)):
        return lhs == rhs
    case (.none, .none):
        return true
    default:
        return false
    }
}

public extension NSArray{
    public func objectAtIndex(safe index: Int) -> Element?{
        guard index >= 0 else {return nil}
        guard index < count else { return nil}
        return self.object(at: index)
    }
}

public extension Array {
    public subscript (safe index: Int) -> Element? {
        get{
          return indices.contains(index) ? self[index] : nil
        }
        set {
            if let value = newValue {
                if indices.contains(index) {
                    self[index] = value
                } else {
                    self.append(value)
                }
            }
        }
    }
    
    
    public mutating func addFromArray(_ array:[Element]){
        for object in array {
            append(object)
        }
    }
    
    public mutating func resetByArray(_ array:[Element]) {
        removeAll()
        addFromArray(array)
    }
    
    public mutating func removeAtIndex(safe index:Int) {
        guard index < count else{return}
        self.remove(at: index)
    }
    
    public func random() -> Element? {
        guard isEmpty == false else {
            return nil
        }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
    
}
public extension Array where Element:Equatable {
    public func unique() -> [Element] {
        
        var array: [Element] = []
        
        for element in self where !array.contains(element) {
            array.append(element)
        }
        
        return array
    }
}

extension Dictionary {
    public subscript(safe key:Key) ->Value?{
        get{
            return self[key]
        }
        set{
            if let value = newValue {
                self[key] = value
            }
        }
    }
}
