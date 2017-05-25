//
//  NSAttributedString.swift
//  SwiftFrameWork
//
//  Created by shenfh on 17/4/8.
//  Copyright © 2017年 shenfh. All rights reserved.
//

import Foundation

public func += (left: inout NSAttributedString, right: NSAttributedString) {
    let ns = NSMutableAttributedString(attributedString: left)
    ns.append(right)
    left = ns
}

public extension NSAttributedString {
    public func bold() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        
        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSFontAttributeName: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)], range: range)
        return copy
    }
    
    public func underline() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        
        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue], range: range)
        return copy
    }
}
public extension NSAttributedString {
   // from: http://stackoverflow.com/questions/30450434/figure-out-size-of-uilabel-based-on-string-in-swift
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return CGFloat(ceilf( Float(boundingBox.height)))
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)        
        return CGFloat(ceilf( Float(boundingBox.width)))
    }
}
