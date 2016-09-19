//
//  ViewControllerProtocol.swift
//  News
//
//  Created by shenfh on 16/8/12.
//  Copyright © 2016年 shenfh. All rights reserved.
//

import UIKit

private var leftNavigationButtonKey  = "com.ViewController.leftNavigationButton"
private var rightNavigationButtonKey = "com.ViewController.rightNavigationButton"
private var titleLabelKey            = "com.ViewController.titleLabel"

public protocol ViewControllerProtocol:class {
    var leftNavigationButtonSelector:Selector {get}
    var rightNavigationButtonSelector:Selector {get}
    func prepareUI()
    func prepareData()
}

public extension ViewControllerProtocol where Self:UIViewController {
    
    
    public func prepareUI(){
        if let navigationController = navigationController  {
            if(navigationController.viewControllers.count > 1) {
                leftNavigationButton(UIImage(named: resourseName("arrowLeft")), hlightedImage: UIImage(named: resourseName("arrowLeftSelect")))
            }
        }
        view.backgroundColor = UIColor.white
    }
    // 加载数据
    public func prepareData(){
        
    }
    
    // MARK: navigation title
    final public func navigationTitle(_ title:String) {
        navigationTitle(NSAttributedString(string: title, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 17),NSForegroundColorAttributeName:UIColor.white]))
    }
    
    final public func navigationTitle(_ attribute:NSAttributedString?){
        titleLable.attributedText = attribute
    }
    
    // MARK: left navigation button
    public func leftNavigationButton(_ noramlImage:UIImage?,hlightedImage:UIImage?,size:CGSize = CGSize.zero){
        if leftNavigationButton != nil {
            leftNavigationButton = nil
        }
        leftNavigationButton = createButton(noramlImage, hlightedImage: hlightedImage,size: size)
        guard let button = leftNavigationButton else {
            return
        }
        setLeftBarButton(button)
    }
    public func leftNavigationButton(_ text:NSAttributedString,font:UIFont = UIFont.systemFont(ofSize: 16)){
        if leftNavigationButton != nil {
            leftNavigationButton = nil
        }
        leftNavigationButton = createButton(text)
        guard let button = leftNavigationButton else {
            return
        }
        setLeftBarButton(button)
    }
    // MARK: right navgation button
    public func rightNavigationButton(_ noramlImage:UIImage?,hlightedImage:UIImage?,size:CGSize = CGSize.zero){
        if rightNavigationButton != nil {
            rightNavigationButton = nil
        }
        rightNavigationButton = createButton(noramlImage, hlightedImage: hlightedImage,size: size)
        setRightBarButton(rightNavigationButton!)
    }
    public func rightNavigationButton(_ text:NSAttributedString){
        if rightNavigationButton != nil {
            rightNavigationButton = nil
        }
        rightNavigationButton = createButton(text)
        setRightBarButton(rightNavigationButton!)
    }
    
    // MARK: pravate func
    fileprivate func createButton(_ text:NSAttributedString)->UIButton{
        let button             = UIButton(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        button.backgroundColor = UIColor.clear
        var buttonSize           = text.boundingRect(with: CGSize(width: 0, height: 44),options: [.usesFontLeading,.usesLineFragmentOrigin], context: nil).size
        if buttonSize.width > 100 {
            buttonSize.width = 100
        }
        button.frame           = CGRect(x: 0, y: 0, width: buttonSize.width+4, height: 44)
        button.setAttributedTitle(text, for: UIControlState())
        return button
    }
    fileprivate func createButton(_ noramlImage:UIImage?,hlightedImage:UIImage?,size:CGSize = CGSize.zero)->UIButton {
        let button                 = UIButton()
        if size.equalTo(CGSize.zero) {
            if let noramlImage = noramlImage {
                button.frame = CGRect(x: 0, y: 0, width: noramlImage.size.width*30/noramlImage.size.height, height: 30)
            } else {
                button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            }
            
        } else {
            button.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        }
        
        button.backgroundColor = UIColor.clear;
        button.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
        button.setImage(noramlImage, for: UIControlState())
        button.setImage(hlightedImage, for: UIControlState.highlighted)
        button.contentMode = UIViewContentMode.center;
        button.setTitleColor(UIColor.black, for: UIControlState());
        return button
    }
    
    fileprivate func setLeftBarButton(_ button:UIButton){
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spaceItem.width = -8
        navigationItem.setLeftBarButtonItems([spaceItem,UIBarButtonItem(customView: button)], animated: false)
        button.addTarget(self, action: leftNavigationButtonSelector, for: .touchUpInside)
    }
    fileprivate func setRightBarButton(_ button:UIButton){
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spaceItem.width = -8
        navigationItem.setRightBarButtonItems([spaceItem,UIBarButtonItem(customView: button)], animated: false)
        button.addTarget(self, action: rightNavigationButtonSelector, for: .touchUpInside)
    }
    
    
    public fileprivate(set) var leftNavigationButton: UIButton? {
        get{
            if let button = objc_getAssociatedObject(self,&leftNavigationButtonKey) as? UIButton {
                return button
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &leftNavigationButtonKey, newValue,objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public fileprivate(set) var rightNavigationButton: UIButton? {
        get{
            if let button = objc_getAssociatedObject(self,&rightNavigationButtonKey) as? UIButton {
                return button
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &rightNavigationButtonKey, newValue,objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public  var titleLable: UILabel {
        get {
            if let label = objc_getAssociatedObject(self,&titleLabelKey) as? UILabel {
                if !label.isEqual(self.navigationItem.titleView) {
                    self.navigationItem.titleView = label;
                }
                return label
            }
            let label =  UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
            label.backgroundColor = UIColor.clear;
            label.textColor       = UIColor.white;
            label.font            = UIFont.systemFont(ofSize: 17);
            label.textAlignment   = .center;
            objc_setAssociatedObject(self, &titleLabelKey, label, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.navigationItem.titleView = label;
            return label
        }
    }   
}

