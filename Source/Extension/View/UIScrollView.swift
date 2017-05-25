//
//  UIScrollView.swift
//  SwiftFrameWork
//
//  Created by shenfh on 17/4/8.
//  Copyright © 2017年 shenfh. All rights reserved.
//

import Foundation

public extension UIScrollView {
    
    /// 立即停止滑动
    public func immediatelyStopScroll() {
        let offset = contentOffset
        setContentOffset(offset, animated: false)
    }
}
