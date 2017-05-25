//
//  BaseViewController.swift
//  News
//
//  Created by shenfh on 16/8/10.
//  Copyright © 2016年 shenfh. All rights reserved.
//

import UIKit


public typealias NavigationClosure = () -> Void

open class BaseViewController:UIViewController,ViewControllerProtocol {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        prepareData()
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        navigationController?.setNavigationBarHidden(navigationBarHidden, animated: animated)
    }
    
    open func prepareUI() {
        if let navigationController = navigationController  {
            if(navigationController.viewControllers.count > 1) {
                leftNavigationButton(UIImage(named: resourseName("arrowLeft")), hlightedImage: UIImage(named: resourseName("arrowLeftSelect")))
            }
        }
       view.backgroundColor = UIColor.white
    }
    open func prepareData() {
        
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
    
    final  func navigationButtonAction(_ button:UIButton){
        if button.isEqual(leftNavigationButton) {
            guard let closure = leftNavButtonClosure else {
                let _ = navigationController?.popViewController(animated: true)
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
    
    open var leftNavButtonClosure: NavigationClosure?
    open var rightNavButtonClosure: NavigationClosure?
    open var navigationBarHidden :Bool = false
   
}
