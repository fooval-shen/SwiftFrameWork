//
//  CALayer.swift
//  SwiftFrameWork
//
//  Created by shenfh on 17/4/8.
//  Copyright © 2017年 shenfh. All rights reserved.
//

import Foundation

fileprivate final class AnimationDelegate: NSObject, CAAnimationDelegate {
    
    private var completion: (Bool) -> Void
    
    init(completion: @escaping (Bool) -> Void) {
        self.completion = completion
    }
    
    fileprivate func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        completion(flag)
    }
}

public extension CALayer {
    public func addAnimation(_ animation: CAAnimation, forKey key: String?, withCompletion completion: @escaping (Bool) -> Void) {
        animation.delegate = AnimationDelegate(completion: completion)
        add(animation, forKey: key)
    }
}

public extension CALayer {
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        } set(value) {
            self.frame = CGRect(x: value, y: self.y, width: self.width, height: self.height)
        }
    }
    
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        } set(value) {
            self.frame = CGRect(x: self.x, y: value, width: self.width, height: self.height)
        }
    }
    
    public var width: CGFloat {
        get {
            return self.frame.size.width
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: value, height: self.height)
        }
    }
    
    public var height: CGFloat {
        get {
            return self.frame.size.height
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: self.width, height: value)
        }
    }
    public var left: CGFloat {
        get {
            return self.x
        } set(value) {
            self.x = value
        }
    }
    
    public var right: CGFloat {
        get {
            return self.x + self.width
        } set(value) {
            self.x = value - self.width
        }
    }
    
    public var top: CGFloat {
        get {
            return self.y
        } set(value) {
            self.y = value
        }
    }
    
    public var bottom: CGFloat {
        get {
            return self.y + self.height
        } set(value) {
            self.y = value - self.height
        }
    }
    
    public var origin: CGPoint {
        get {
            return self.frame.origin
        } set(value) {
            self.frame = CGRect(origin: value, size: self.frame.size)
        }
    }    
    
    
    public var size: CGSize {
        get {
            return self.frame.size
        } set(value) {
            self.frame = CGRect(origin: self.frame.origin, size: value)
        }
    }
    
    public func removeAllSubLayer() {
        guard let sublayers = self.sublayers else {
            return;
        }
        for layer in sublayers {
            layer.removeFromSuperlayer()
        }
    }
    
}
