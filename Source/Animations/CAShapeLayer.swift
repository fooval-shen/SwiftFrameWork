//
//  CAShapeLayer.swift
//  SwiftExample
//
//  Created by shenfh on 17/4/26.
//  Copyright © 2017年 shenfh. All rights reserved.
//

import Foundation


public extension CAShapeLayer {
    func makeCircleLayer(with size: CGSize, color: UIColor,borderWidth:CGFloat = .nan,boardColor:UIColor = .clear) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                    radius: size.width / 2,
                    startAngle: 0,
                    endAngle: 2 * CGFloat.pi,
                    clockwise: false)
        layer.fillColor = color.cgColor
        layer.borderWidth = borderWidth.isNaN ? borderWidth:0;
        if layer.borderWidth > 0 {
            layer.borderColor = boardColor.cgColor
        }
        layer.apply(path: path, size: size)
        return layer
    }
}

private extension CAShapeLayer {
    func apply(path: UIBezierPath, size: CGSize) {
        self.backgroundColor = nil
        self.path = path.cgPath
        self.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
}
