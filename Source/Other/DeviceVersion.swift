//
//  DeviceVersion.swift
//  SwiftFrameWork
//
//  Created by shenfh on 16/6/29.
//  Copyright © 2016年 com.meiqu.com. All rights reserved.
//

import Foundation


public enum DeviceName :String{
    case iPhone4
    case iPhone4S
    case iPhone5
    case iPhone5C
    case iPhone5S
    case iPhone5SE
    case iPhone6
    case iPhone6S
    case iPhone6Plus
    case iPhone6SPlus
    case Simulator
    
    case iPad1
    case iPad2
    case iPadMini
    case iPadMini2
    case iPadMini3
    case iPadMini4
    case iPad3
    case iPad4
    case iPadAir
    case iPadAir2
    case iPadPro12Inch
    case iPadPro9Inch
    
    case unkown
}

public enum DeviceSize {
    case inch35
    case inch4
    case inch47
    case inch55
}
//https://www.theiphonewiki.com/wiki/Models
private let deviceDode:[String:DeviceName] = ["iPhone3,1":.iPhone4,
                                              "iPhone3,2":.iPhone4,
                                              "iPhone3,3":.iPhone4,
                                              "iPhone4,1" :.iPhone4S,
                                              "iPhone5,1" :.iPhone5,
                                              "iPhone5,2" :.iPhone5,
                                              "iPhone5,3" :.iPhone5C,
                                              "iPhone5,4" :.iPhone5C,
                                              "iPhone6,1" :.iPhone5S,
                                              "iPhone6,2" :.iPhone5S,
                                              "iPhone7,2" :.iPhone6,
                                              "iPhone7,1" :.iPhone6Plus,
                                              "iPhone8,1" :.iPhone6S,
                                              "iPhone8,2" :.iPhone6SPlus,
                                              "iPhone8,4" :.iPhone5SE,
                                              "i386"      :.Simulator,
                                              "x86_64"    :.Simulator,
                                              
                                              "iPad1,1" :.iPad1,
                                              "iPad2,1" :.iPad2,
                                              "iPad2,2" :.iPad2,
                                              "iPad2,3" :.iPad2,
                                              "iPad2,4" :.iPad2,
                                              "iPad2,5" :.iPadMini,
                                              "iPad2,6" :.iPadMini,
                                              "iPad2,7" :.iPadMini,
                                              "iPad3,1" :.iPad3,
                                              "iPad3,2" :.iPad3,
                                              "iPad3,3" :.iPad3,
                                              "iPad3,4" :.iPad4,
                                              "iPad3,5" :.iPad4,
                                              "iPad3,6" :.iPad4,
                                              "iPad4,1" :.iPadAir,
                                              "iPad4,2" :.iPadAir,
                                              "iPad4,3" :.iPadAir,
                                              "iPad4,4" :.iPadMini2,
                                              "iPad4,5" :.iPadMini2,
                                              "iPad4,6" :.iPadMini2,
                                              "iPad4,7" :.iPadMini3,
                                              "iPad4,8" :.iPadMini3,
                                              "iPad4,9" :.iPadMini3,
                                              "iPad5,1" :.iPadMini4,
                                              "iPad5,2" :.iPadMini4,
                                              "iPad5,3" :.iPadAir2,
                                              "iPad5,4" :.iPadAir2,
                                              "iPad6,3" :.iPadPro9Inch,
                                              "iPad6,4" :.iPadPro9Inch,
                                              "iPad6,7" :.iPadPro12Inch,
                                              "iPad6,8" :.iPadPro12Inch,
                                              ]

                                              

extension UIDevice {
    public class func deviceType()-> DeviceName {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return deviceDode[identifier] ?? .unkown
    }
    
    public class func deviceSize()-> DeviceSize {
        let deviceHeight = UIScreen.main.bounds.height
        switch deviceHeight {
        case 480.0:
            return .inch35
        case 568.0:
            return .inch4
        case 667.0:
            return .inch47
        case 736.0:
            return .inch55
        default:
             return .inch47
        }
    }
}


