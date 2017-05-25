//
//  ShadeViewProtocol.swift
//  News
//
//  Created by shenfh on 16/8/10.
//  Copyright © 2016年 shenfh. All rights reserved.
//

import UIKit

public protocol ShadeViewProtocol:class,NetworkShadeProtocol {
    var containerView:UIView {get} //container
}

private var loadingViewKey      = "com.ViewController.loadingView"
extension ShadeViewProtocol {
        
    fileprivate  var loadingView:NetworkShadeView{
        get{
            if let view = objc_getAssociatedObject(self, &loadingViewKey) as? NetworkShadeView {
                return view
            }
            let view = NetworkShadeView(type: .loading)
            view.delegate = self
            objc_setAssociatedObject(self, &loadingViewKey, view, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return view
        }
    }
    /**
     show networt action shade view
     
     - parameter type: view type
     */
    public func showShadeView(_ type:NetworkShadeViewType = .loading){
        if !self.loadingView.isShow {
            self.loadingView.show(containerView,type: type)
        }else {
            self.loadingView.changeView(type)
        }
    }
    
    /**
     dismiss shade view
     */
    public func dismissShadeView(){
        if loadingView.isShow {
            self.loadingView.dismiss()
        }
    }
    public func shadeViewType()->NetworkShadeViewType{
        return self.loadingView.showType
    }
    
    /**
     call after tap network refresh view
     */
    public func networkFailureRefresh(){
        
    }
}
