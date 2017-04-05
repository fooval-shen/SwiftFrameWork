//
//  ViewController.swift
//  SwiftExample
//
//  Created by shenfh on 16/12/26.
//  Copyright © 2016年 shenfh. All rights reserved.
//

import Foundation

extension UIViewController {
    open class var topViewController:UIViewController?{
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
            return nil
        }
        return topViewController(viewController: rootViewController)
    }
    
    
    /// 获取最顶层的ViewController
    ///

    open class func topViewController(viewController:UIViewController)->UIViewController? {
        if let tabBarController = viewController as? UITabBarController,
            let selectedController = tabBarController.selectedViewController {
            return topViewController(viewController: selectedController)
        }
        
        // UINavigationController
        if let navigationController = viewController as? UINavigationController,
            let visibleViewController = navigationController.visibleViewController {
           return topViewController(viewController: visibleViewController)
        }
        
        // presented view controller
        if let presentedViewController = viewController.presentedViewController {
             return topViewController(viewController: presentedViewController)
        }
        
        // child view controller
        for subview in viewController.view?.subviews ?? [] {
            if let childViewController = subview.next as? UIViewController {
                 return topViewController(viewController: childViewController)
            }
        }
        return viewController
    }
}
