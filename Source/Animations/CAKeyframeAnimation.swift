//
//  CAKeyframeAnimation.swift
//  SwiftExample
//
//  Created by shenfh on 17/4/26.
//  Copyright © 2017年 shenfh. All rights reserved.
//

import Foundation


public extension CAKeyframeAnimation {
    var scaleAnimation: CAKeyframeAnimation {
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        return scaleAnimation
    }
    
    var opacityAnimation: CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        return opacityAnimation
    }
}
