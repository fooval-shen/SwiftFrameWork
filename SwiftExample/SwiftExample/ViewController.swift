//
//  ViewController.swift
//  SwiftExample
//
//  Created by shenfh on 16/9/1.
//  Copyright © 2016年 shenfh. All rights reserved.
//

import UIKit
import SwiftFrameWork

extension UIButton:TouchExtensionProtocol {
    open  override func point(inside point: CGPoint, with event: UIEvent?) -> Bool  {
        var bounds = self.bounds
        bounds.origin.x -= extendTouchInsets.left
        bounds.origin.y -= extendTouchInsets.top
        bounds.size.width += extendTouchInsets.left + extendTouchInsets.right
        bounds.size.height += extendTouchInsets.top + extendTouchInsets.bottom
        return bounds.contains(point)
    }
}

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationTitle("SwiftFrameWork")
        leftNavigationButton(UIImage(named:"leftImage"), hlightedImage: UIImage(named:"leftImage"))
        rightNavigationButton(NSAttributedString(string: "right", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 16)]))
       
        leftNavButtonClosure = { void  in
            printlen("leftNavButtonClosure")
        }
        rightNavButtonClosure = {void in
            printlen("rightNavButtonClosure")
        }
        leftNavigationButton?.extendTouchInsets = UIEdgeInsetsMake(10, 0, 10, 200)
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

