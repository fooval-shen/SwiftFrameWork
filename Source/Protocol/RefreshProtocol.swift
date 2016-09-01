//
//  RefreshProtocol.swift
//  News
//
//  Created by shenfh on 16/8/10.
//  Copyright © 2016年 shenfh. All rights reserved.
//

import UIKit

public protocol HeaderRefreshProtocol:class {
    var refreshScrollView:UIScrollView {get}
    func refreshAction()
}

extension HeaderRefreshProtocol {    
    /// 添加下来刷新功能
    public func addRefreshView(){
        if let _ = refreshScrollView.header as? RefreshView {
            return
        }
        refreshScrollView.header = RefreshView.refresh({[weak self] () -> Void in
            guard let strongSelf = self else {return}
            strongSelf.refreshAction()
        })
    }
    /// 开始下拉刷新
    public func beginRefresh(){
        guard let refreshView = refreshScrollView.header as?RefreshView else {return}
        if !refreshView.isRefreshing() {
            refreshView.beginRefreshing()
        }
        
    }
    /// 结束下拉刷新
    public func endRefresh(){
        guard let refreshView = refreshScrollView.header as? RefreshView else {return}
        if refreshView.isRefreshing() {
            refreshView.endRefreshing()
        }
    }    
}
