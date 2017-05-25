//
//  HUDProtocol.swift
//  News
//
//  Created by shenfh on 16/8/22.
//  Copyright © 2016年 shenfh. All rights reserved.
//

import UIKit
import MBProgressHUD

public protocol HUDProtocol:class {
    func HUDContainerView()->UIView
}


public extension HUDProtocol {
    public func showHUDText(text:String,autoHide:Bool = true) {
        let hudView = HUDView()
        hudView.mode = .text
        hudView.label.text = text
        hudView.show(animated: true)
        if autoHide {
            delayHide()
        }
    }
    
    public func showProgressHUD(text:String? = nil) {
        let hudView = HUDView()
        hudView.mode = .indeterminate
        hudView.show(animated: true)
    }
    
    
    public func hideHUD(animated:Bool = true) {
        MBProgressHUD(for: HUDContainerView())?.hide(animated: animated)
    }
}

fileprivate extension HUDProtocol {    
    fileprivate func delayHide() {
        delay(2.0) { [weak self] in
            self?.hideHUD()
        }
    }
    
    fileprivate  func HUDView()->MBProgressHUD {
        let containerView = HUDContainerView()
        if let hudView = MBProgressHUD(for: containerView) {
            hudView.hide(animated: false)
        }
        let hudView =  MBProgressHUD(view: containerView)
        hudView.removeFromSuperViewOnHide = true
        containerView.addSubview(hudView)
        return hudView
    }
}

// MARK:- UIView
public extension HUDProtocol where Self:UIView {
    func HUDContainerView()->UIView {
        return self
    }
}

// MARK:- UIViewController
public extension HUDProtocol where Self:UIViewController {
    func HUDContainerView()->UIView {
        return self.view
    }
}
