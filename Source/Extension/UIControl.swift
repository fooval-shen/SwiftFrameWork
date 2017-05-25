//
//  UIControl.swift
//  SwiftFrameWork
//
//  Created by shenfh on 17/5/23.
//  Copyright © 2017年 shenfh. All rights reserved.
//

import Foundation

public enum ControlEvent:String {
    case touchDown
    case touchDownRepeat
    case touchDragInside
    case touchDragOutside
    case touchDragEnter
    case touchDragExit
    case touchUpInside
    case touchUpOutside
    case touchCancel
    case valueChanged
    
    public func Events()-> UIControlEvents {
        switch self {
        case .touchDown:
            return .touchDown
        case .touchDownRepeat:
            return .touchDownRepeat
        case .touchDragInside:
            return .touchDragInside
        case .touchDragOutside:
            return .touchDragOutside
        case .touchDragEnter:
            return .touchDragEnter
        case .touchDragExit:
            return .touchDragExit
        case .touchUpInside:
            return .touchUpInside
        case .touchUpOutside:
            return .touchUpOutside
        case .touchCancel:
            return .touchCancel
        case .valueChanged:
            return .valueChanged
        }
    }
}


private var EventClosureKey      = "com.UIControl.closure"
public extension UIControl {
    public func addClosureForEvent(event:ControlEvent,closure:@escaping ClosureWithSender) {
        var events = objc_getAssociatedObject(self, &EventClosureKey) as? [String:[ControlWrapper]]
        if events == nil {
            events = [String:[ControlWrapper]]()
        }
        guard let _ = events else {
            return
        }
        var set = events![event.rawValue]
        if set == nil {
            set = []
            events![event.rawValue] = set!
        }
        let target = ControlWrapper(event: event, closure: closure)
        set?.append(target)
        self.addTarget(target, action: #selector(ControlWrapper.closureTargetAction(sender:)), for: event.Events())
        
        events?[event.rawValue] = set
        
        objc_setAssociatedObject(self, &EventClosureKey, events!, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    public func removeClosureFoEvent(event:ControlEvent) {
        var events = objc_getAssociatedObject(self, &EventClosureKey) as? [String:[ControlWrapper]]
        if events == nil {
            events = [String:[ControlWrapper]]()
            objc_setAssociatedObject(self, &EventClosureKey, events!, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        guard  let set = events?[event.rawValue] else {
            return
        }
        
        set.forEach { (sender:Any) in
          removeTarget(sender, action: nil, for: event.Events())
        }
        let _ = events?.removeValue(forKey: event.rawValue)
    }
    
    public func hasEventClosureFoeEvent(event:ControlEvent)-> Bool {
        var events = objc_getAssociatedObject(self, &EventClosureKey) as? [String:[ControlWrapper]]
        if events == nil {
            events = [String:[ControlWrapper]]()
            objc_setAssociatedObject(self, &EventClosureKey, events!, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        guard let set = events?[event.rawValue] else {
            return false
        }
        return set.count > 0
    }
    
   
}

fileprivate class ControlWrapper {
    fileprivate var event:ControlEvent
    fileprivate var closure:ClosureWithSender
    
    init(event:ControlEvent,closure:@escaping ClosureWithSender) {
        self.event = event
        self.closure = closure
    }
    @objc func closureTargetAction(sender:Any) {
        self.closure(sender)
    }   
}
