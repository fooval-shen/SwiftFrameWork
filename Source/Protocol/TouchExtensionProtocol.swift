//
//  TouchExtensionProtocol.swift
//  SwiftExample
//
//  Created by shenfh on 17/1/3.
//  Copyright © 2017年 shenfh. All rights reserved.
//

import Foundation

public protocol TouchExtensionProtocol:class {
    var extendTouchInsets:UIEdgeInsets {get set}
    func setExtendTouchValue(value:CGFloat)
}


private var extendTouchInsetKey = "com.SwiftFramework.extendTouch";
public extension TouchExtensionProtocol where Self:UIView {
       public var extendTouchInsets:UIEdgeInsets{
            get{
                if let edgeValue = objc_getAssociatedObject(self, &extendTouchInsetKey) as? UIEdgeInsets {
                    return edgeValue
                }
                let edgeValue = UIEdgeInsetsMake(6, 6, 6, 6)
                objc_setAssociatedObject(self, &extendTouchInsetKey, edgeValue,objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return edgeValue
            }
            set {
                 objc_setAssociatedObject(self, &extendTouchInsetKey, newValue,objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
    }
    public func setExtendTouchValue(value:CGFloat) {
        extendTouchInsets = UIEdgeInsetsMake(value, value, value, value)
    }   
}

