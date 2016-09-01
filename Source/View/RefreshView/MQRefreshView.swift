//
//  MQRefreshView.swift
//  meiqu
//
//  Created by shenfh on 16/3/18.
//  Copyright © 2016年 com.meiqu.com. All rights reserved.
//

import UIKit

class RefreshView:MQRefreshHeaderView{
    
    class func refresh(block:()->Void )->RefreshView {
        let refreshView = RefreshView()
        refreshView.refreshingBlock = block
        return refreshView
    }
    
    override func beginRefreshing() {
        super.beginRefreshing()
    }
    
    override func endRefreshing() {
        super.endRefreshing()
    }
    override func isRefreshing() -> Bool {
        return super.isRefreshing()
    }
}
