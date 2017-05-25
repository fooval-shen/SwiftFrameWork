//
//  TableViewProtocol.swift
//  SwiftExample
//
//  Created by shenfh on 17/5/10.
//  Copyright © 2017年 shenfh. All rights reserved.
//

import UIKit

private var CanLoadMoreKey = "tableView.canLoadMore"

public protocol TableViewProtocol:UITableViewDataSource,UITableViewDelegate {
    var dataSource:[Any]{get}
//    var canLoadMore:Bool {get set}
}

public extension TableViewProtocol where Self:NSObject {
    // MARK: - UITableViewDataSource
     public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
   

    // MARK:- UITableViewDelegate
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if canLoadMore {
            
        }
    }
    
    
    
    
    public var canLoadMore:Bool{
        get{
            if let loadMore = objc_getAssociatedObject(self, &CanLoadMoreKey) as? Bool {
                return loadMore
            }
            return false
        }
        set {
             objc_setAssociatedObject(self, &CanLoadMoreKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

