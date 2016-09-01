//
//  BaseViewController.swift
//  News
//
//  Created by shenfh on 16/8/10.
//  Copyright © 2016年 shenfh. All rights reserved.
//

import UIKit


public typealias NavigationClosure = () -> Void

public class BaseViewController:UIViewController,ViewControllerProtocol {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        prepareData()
    }
    public func prepareUI() {
        if let navigationController = navigationController  {
            if(navigationController.viewControllers.count > 1) {
                leftNavigationButton(UIImage(named: resourseName("arrowLeft")), hlightedImage: UIImage(named: resourseName("arrowLeftSelect")))
            }
        }
       view.backgroundColor = UIColor.whiteColor()
    }
    public func prepareData() {
        
    }
    
    deinit {
//        printlen("\(self.classForCoder) deinit")
    }
    
    final public var leftNavigationButtonSelector: Selector {
        return #selector(navigationButtonAction(_:))
    }
    final public var rightNavigationButtonSelector: Selector{
        return #selector(navigationButtonAction(_:))
    }
    
    final  func navigationButtonAction(button:UIButton){
        if button.isEqual(leftNavigationButton) {
            guard let closure = leftNavButtonClosure else {
                navigationController?.popViewControllerAnimated(true)
                return;
            }
           closure()
        } else if button.isEqual(rightNavigationButton) {
            guard let closure = rightNavButtonClosure else {
                return;
            }
            closure()
        }
    }
    
    public var leftNavButtonClosure: NavigationClosure?
    public var rightNavButtonClosure: NavigationClosure?
    
   
}
