//
//  UIImage.swift
//  SwiftFrameWork
//
//  Created by shenfh on 17/4/8.
//  Copyright © 2017年 shenfh. All rights reserved.
//

import Foundation

public extension UIImage {    
    public convenience init(color: UIColor? = UIColor.white) {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color?.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage!)!)
    }
    
    public func filled(with color: UIColor? = UIColor.white) -> UIImage {
        guard let color = color else {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        guard let context = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage else {
            return self
        }
        
        color.setFill()
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.clip(to: rect, mask: cgImage)
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
    
    public func combined(with image: UIImage) -> UIImage? {
        let finalSize = CGSize(width: max(size.width, image.size.width),
                               height: max(size.height, image.size.height))
        var finalImage: UIImage?
        
        UIGraphicsBeginImageContextWithOptions(finalSize, false, UIScreen.main.scale)
        draw(at: CGPoint(x: (finalSize.width - size.width) / 2, y: (finalSize.height - size.height) / 2))
        image.draw(at: CGPoint(x: (finalSize.width - image.size.width) / 2, y: (finalSize.height - image.size.height) / 2))
        finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return finalImage
    }
    
    public func tinted(with color: UIColor) -> UIImage {
        var finalImage: UIImage?
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        guard let ctx = UIGraphicsGetCurrentContext(), let cgImage = cgImage else {
            UIGraphicsEndImageContext()
            return self
        }
        
        let rect = CGRect(origin: .zero, size: size)
        ctx.setBlendMode(.normal)
        ctx.draw(cgImage, in: rect)
        ctx.setBlendMode(.multiply)
        color.setFill()
        ctx.addRect(rect)
        ctx.drawPath(using: .fill)
        ctx.setBlendMode(.destinationIn)
        ctx.draw(cgImage, in: rect)
        
        finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return finalImage ?? self
    }
    
}

// MARK: RenderingMode

public extension UIImage {
    
    public var original: UIImage {
        return withRenderingMode(.alwaysOriginal)
    }
    
    public var template: UIImage {
        return withRenderingMode(.alwaysTemplate)
    }
    
}
