//
//  UIView.swift
//  SwiftFrameWork
//
//  Created by shenfh on 17/4/8.
//  Copyright © 2017年 shenfh. All rights reserved.
//

import Foundation

public extension UIView {
    public func removeAllSubView() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
}
