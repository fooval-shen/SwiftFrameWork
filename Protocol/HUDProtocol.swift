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
    
    public func showMessage(message:String,delay:NSTimeInterval = 2){
        hudViewModel       = .Text
        hudView.label.text = message
        showHudView(delay)
    }
    
    public func showMessage(message:String,customView:UIView,delay:NSTimeInterval = 2){
        hudViewModel       = .CustomView
        hudView.label.text = message
        hudView.customView = customView
        showHudView(delay)
    }
    
    private func showHudView(delay:NSTimeInterval){
        containerView.addSubview(hudView)
        hudView.showAnimated(true)
        hudView.hideAnimated(true, afterDelay: delay)
    }
    private var hudView:MBProgressHUD {
        get{
            if let view = objc_getAssociatedObject(self, &HUDKey) as? MBProgressHUD {
                return view
            }
            let view = MBProgressHUD(view: self.containerView)
            view.removeFromSuperViewOnHide = true
            view.square          = true
            MBProgressHUD.appearance().contentColor = UIColor.whiteColor()
            view.bezelView.color = UIColor.blackColor()
            objc_setAssociatedObject(self, &HUDKey, view, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return view
        }
    }
    private var hudViewModel:MBProgressHUDMode {
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
