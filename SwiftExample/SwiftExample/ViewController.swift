//
//  ViewController.swift
//  SwiftExample
//
//  Created by shenfh on 16/9/1.
//  Copyright © 2016年 shenfh. All rights reserved.
//

import UIKit
import SwiftFrameWork
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
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

