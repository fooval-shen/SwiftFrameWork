//
//  Color.swift
//  News
//
//  Created by shenfh on 16/8/9.
//  Copyright © 2016年 shenfh. All rights reserved.
//

import Foundation

extension UIColor {
    public class func color(_ rgbValue:Int32) -> UIColor {
        return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0xFF00) >> 8))/255.0, blue: ((CGFloat)(rgbValue & 0xFF))/255.0, alpha: 1);
    }
    public class func color(_ rgbValue:Int32,alpha:CGFloat) -> UIColor {
        return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0xFF00) >> 8))/255.0, blue: ((CGFloat)(rgbValue & 0xFF))/255.0, alpha: alpha);
    }
}
