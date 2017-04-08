//
//  UIDevice.swift
//  SwiftFrameWork
//
//  Created by shenfh on 17/4/8.
//  Copyright © 2017年 shenfh. All rights reserved.
//

import Foundation

public extension UIDevice {
    public class func idForVendor() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
   
    public class func systemName() -> String {
        return UIDevice.current.systemName
    }
   
    public class func systemVersion() -> String {
        return UIDevice.current.systemVersion
    }
   
    public class func systemFloatVersion() -> Float {
        return (systemVersion() as NSString).floatValue
    }
   
    public class func deviceName() -> String {
        return UIDevice.current.name
    }
   
    public class func deviceLanguage() -> String {
        return Bundle.main.preferredLocalizations[0]
    }
   
    public class func isPhone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    }    
   
    public class func isPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }
}
