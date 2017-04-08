//
//  CGRect.swift
//  SwiftFrameWork
//
//  Created by shenfh on 17/4/8.
//  Copyright © 2017年 shenfh. All rights reserved.
//

import Foundation

public extension CGRect {
    public var x:CGFloat {
        get {
            return origin.x
        }
        set(value) {
            origin.x  = value;
        }
    }
    
    public var y:CGFloat {
        get {
            return origin.y
        }
        set(value) {
            origin.y = value;
        }
    }
    
    public var width:CGFloat {
        get {
            return size.width
        }
        set(value) {
            size.width = width;
        }
    }
    
    public var height:CGFloat {
        get {
            return size.height
        }
        set(value) {
            size.height = value;
        }
    }
}
