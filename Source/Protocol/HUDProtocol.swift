//
//  HUDProtocol.swift
//  News
//
//  Created by shenfh on 16/8/22.
//  Copyright © 2016年 shenfh. All rights reserved.
//

import UIKit

private var HUDKey = "com.view.hud"

public protocol HUDProtocol:class {
    var containerView :UIView {get}
}

extension HUDProtocol {
    
    public func showMessage(_ message:String,delay:TimeInterval = 2){
        hudViewModel       = .text
        hudView.label.text = message
        showHudView(delay)
    }
    
    public func showMessage(_ message:String,customView:UIView,delay:TimeInterval = 2){
        hudViewModel       = .customView
        hudView.label.text = message
        hudView.customView = customView
        showHudView(delay)
    }
    
    fileprivate func showHudView(_ delay:TimeInterval){
        containerView.addSubview(hudView)
        hudView.show(animated: true)
        hudView.hide(animated: true, afterDelay: delay)
    }
    fileprivate var hudView:MBProgressHUD {
        get{
            if let view = objc_getAssociatedObject(self, &HUDKey) as? MBProgressHUD {
                return view
            }
            let view = MBProgressHUD(view: self.containerView)
            view.removeFromSuperViewOnHide = true
            view.isSquare          = true
            MBProgressHUD.appearance().contentColor = UIColor.white
            view.bezelView.color = UIColor.black
            objc_setAssociatedObject(self, &HUDKey, view, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return view
        }
    }
    fileprivate var hudViewModel:MBProgressHUDMode {
        set {
            if hudView.mode != newValue {
                hudView.mode = newValue
            }
        }
        get {
            return hudView.mode
        }
    }
}
